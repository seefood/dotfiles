local wezterm = require('wezterm')
local platform = require('utils.platform')
local font = wezterm.font_with_fallback {
   'Maple Mono NF',
   'Maple Mono SC NF',
   'FiraCode Nerd Font',
   'JetBrains Mono',
   'Courier New',
   'DaddyTimeMono Nerd Font',
   'ComicShannsMono Nerd Font',
   'Lilex Nerd Font',
   'JetBrainsMono Nerd Font',
   'FiraCode Nerd Font',
   'CaskaydiaCove Nerd Font',
   '0xProto Nerd Font',
   'Inconsolata Nerd Font'
}
local font_size = 12
if platform.is_mac then
   font_size = 16
end
-- local font_family = 'JetBrainsMono Nerd Font'
local font_family = 'Maple Mono NF'
-- local font_family = 'CartographCF Nerd Font'

return {
   font_size = font_size,
   font = font,
--   font = wezterm.font({
--      family = font_family,
--      weight = 'Medium',
--   }),

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
