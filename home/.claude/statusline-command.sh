#!/usr/bin/env bash
# Claude Code status line: context usage, quota remaining, next reset time

input=$(cat)

# --- Context window ---
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
total=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
compact_at="${CLAUDE_CODE_AUTO_COMPACT_WINDOW:-}"

if [ -n "$used_pct" ] && [ -n "$total" ]; then
	used_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
	printf -v ctx_str "ctx: %.0f%%" "$used_pct"

	# Show tokens until auto-compact fires (if env var is set)
	if [ -n "$compact_at" ] && [ -n "$used_tokens" ] && [ "$compact_at" -gt 0 ]; then
		remaining_to_compact=$((compact_at - used_tokens))
		remaining_pct=$((remaining_to_compact * 100 / compact_at))
		if [ "$remaining_to_compact" -le 0 ]; then
			ctx_str="$ctx_str (compact soon)"
		elif [ "$remaining_pct" -le 15 ]; then
			ctx_str="$ctx_str (${remaining_pct}% to compact)"
		fi
	fi
else
	ctx_str=""
fi

# --- Rate limits ---
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage  // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage  // empty')
week_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at  // empty')

quota_parts=()

if [ -n "$five_pct" ]; then
	five_rem=$(echo "$five_pct" | awk '{printf "%.0f", 100 - $1}')
	part="5h: ${five_rem}% left"
	reset_time=$(
		python3 - <<'PYEOF'
import datetime, sys
now = datetime.datetime.now(datetime.timezone.utc)
next_slot = (now.hour // 5 + 1) * 5
if next_slot >= 24:
    d = (now + datetime.timedelta(days=1)).replace(hour=0, minute=0, second=0, microsecond=0)
else:
    d = now.replace(hour=next_slot, minute=0, second=0, microsecond=0)
print(datetime.datetime.fromtimestamp(d.timestamp()).strftime('%H:%M'))
PYEOF
	)
	[ -n "$reset_time" ] && part="$part (resets $reset_time)"
	quota_parts+=("$part")
fi

if [ -n "$week_pct" ]; then
	week_rem=$(echo "$week_pct" | awk '{printf "%.0f", 100 - $1}')
	part="7d: ${week_rem}% left"
	if [ -n "$week_reset" ]; then
		reset_date=$(date -r "$week_reset" "+%a %H:%M" 2>/dev/null || date -d "@$week_reset" "+%a %H:%M" 2>/dev/null)
		[ -n "$reset_date" ] && part="$part (resets $reset_date)"
	fi
	quota_parts+=("$part")
fi

# --- Assemble output ---
parts=()
[ -n "$ctx_str" ] && parts+=("$ctx_str")
for q in "${quota_parts[@]}"; do
	parts+=("$q")
done

if [ "${#parts[@]}" -gt 0 ]; then
	out=""
	for i in "${!parts[@]}"; do
		[ "$i" -gt 0 ] && out="$out | "
		out="$out${parts[$i]}"
	done
	echo "$out"
fi
