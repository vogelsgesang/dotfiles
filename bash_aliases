alias ..="cd .."
alias sudo=/usr/bin/sudo

function sed-cpp {
   find . -iname \*.cpp -exec sed -i "$1" {} \;
   find . -iname \*.hpp -exec sed -i "$1" {} \;
}

function sed-test {
   find . -iname \*.test -exec sed -i "$1" {} \;
   find . -iname \*.loadtest -exec sed -i "$1" {} \;
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

function cpp-move-file {
   local from=$1
   local to=$2
   echo move $from "->" $to
   mkdir -p -- "${to%/*}"
   mv "$from" "$to"
   if [[ "$to" == *.cpp ]]; then
      sed -i "/.* const char tc\[\] =/c\static const char tc[] = \"${to%.cpp}\";" "$to"
   fi
   if [[ "$from" == *.hpp ]]; then
      sed-cpp "s|#include \"$1\"|#include \"$2\"|"
   fi
}


function move-folder {
   local from=$1
   local to=$2
   for entry in $(ls "$from"); do
      path="$from/$entry"
      if [ -f "$path" ]; then
        move-file "$path" "$to/$entry"
      elif [ -d "$path" ]; then
         move-folder "$path" "$to/$entry"
      else
         echo "unsupported file type \"$path\""
      fi
   done
}

function move-hpp-cpp {
   move-file "$1.hpp" "$2.hpp"
   if [ -f "$1.cpp" ]; then
      move-file "$1.cpp" "$2.cpp"
   fi
   if [ -f "$1.proxy.hpp" ]; then
      move-file "$1.proxy.hpp" "$2.proxy.hpp"
   fi
}
