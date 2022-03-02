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
