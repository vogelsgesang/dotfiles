alias ..="cd .."
alias sudo=/usr/bin/sudo

function sed-cpp {
   find -iname \*.cpp -exec sed -i "$1" {} \;
   find -iname \*.hpp -exec sed -i "$1" {} \;
}

function sed-test {
   find -iname \*.test -exec sed -i "$1" {} \;
   find -iname \*.loadtest -exec sed -i "$1" {} \;
}

function sed-rename {
  if [ $# -gt 1 ]; then
    sed_pattern=$1
    shift
    for file in $(ls $@); do
      new=`sed $sed_pattern <<< $file`
      if [[ "$new" != "$file" ]]; then
        mv -v "$file" "$new"
      fi
    done
  else
    echo "usage: $0 sed_pattern files..."
  fi
}
