# alias android-connect="mtpfs -o allow_other /media/GalaxyS2"
# alias android-disconnect="fusermount -u /media/GalaxyS2"

alias tat='vi ~/bin/tatsuya && strfile ~/bin/tatsuya'

alias uma='ssh ira@uma.scso.com'
alias bu-server='rsync -avP uma:/var/backup/current/* /warez/backups/uma/'
alias bu-server='rsync -avvP uma::backup/current/ /warez/backups/uma/'

alias cm='mboxcheck ~/Mail/Nospams ~/Mail/root ~/Mail/schwab ~/Mail/people/* ~/Mail/lists/* ~/Mail/people/* ~/Mail/roles/*'
alias irc='BitchX -A -N -n SeeFood '

alias bot='su - moobot -c moobot/moobot.py'

#alias socks5="ssh scso.com -q -f -n -D 9051 sleep 900"
alias socks5="ssh scso.com -qfN -D 9051"
alias mgif='v2gif *.webm *.mp4 -d'

if [[ "$OSTYPE" == "darwin"* ]]; then
alias upt='brew upgrade'
alias uupt='brew upgrade'
else
alias upt='sudo apt -u dist-upgrade'
alias uupt='sudo apt update && upt'
alias uptc='uupt ; sudo apt-get --purge autoremove  `deborphan` `deborphan  --guess-dev` `deborphan --guess-debug`'
fi
alias scan='sudo nmap -sS -Pn -R -v -O -f'
alias beep="echo -e '\a'; sleep 1; echo -e '\a'; sleep 1; echo -e '\a'"


alias eph='time { get_ssm.sh & update_ephemerals.sh ;}'
alias vd='git -C ~/bluevine/chef-repo/ diff ephemerals^..ephemerals ; git -C ~/bluevine/ssm_decrypted/ diff HEAD^'

alias csa='cookstyle -a --except Metrics/BlockNesting,Lint/ParenthesesAsGroupedExpression,Style/Next,Metrics/ParameterLists'
alias ls='colorls --sort-dirs --gs'
