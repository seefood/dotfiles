alias json='python -mjson.tool'

function ps() {
  if [ $# -eq 0 ]; then
    command ps aux --sort rss
  elif [ $# -eq 2 ] && [ $1 == '-p' ]; then
    p_nm=$(pidof $2)
    p=$2

    plist=$(command ps -aef | awk -v x=${p} ' $8 ~ x { print $2 } ')
    size=${#plist}

    if [ $size -ne 0 ]; then
      command ps -u -p $plist
      command ps -u -p $plist | grep -v PID | awk '{ sum+=$3} END {print "CPU %:", sum}'
      command ps -u -p $plist | grep -v PID | awk '{ sum+=$4} END {print "MEM %:", sum}'
    else
      echo "[$p] process not found"
    fi
  else
    command ps $*
  fi
  lscpu | grep "CPU MHz"
}

function yaml2json()
{
    ruby -ryaml -rjson -e \
      'puts JSON.pretty_generate(YAML.load(ARGF))' $*
}
