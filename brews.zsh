#!/bin/env zsh

source config_brew.zsh
if ! is_function concblock; then
    export CONC_MAX=${CONC_MAX:-2}
    zmodload zsh/parameter
    zmodload zsh/zselect

    function concblock () {
        CONC_MAX=${CONC_MAX:-2}

        # Block until there is an open slot
        if [[ ${#jobstates} -ge $CONC_MAX ]]; then
            while; do
                zselect -t 20
                if [[ ${#jobstates} -lt $CONC_MAX ]]; then
                    break
                fi
            done
        fi;

        return 0
    }
fi
do_install(){
    brew install $i
    if  [[ $TESTING == "true"  ]]; then
      brew uninstall $i

      fi
}


while read i
do
  if  [[ !  -z  $i ]]; then
    echo "testing $i"
    do_install $i &
    concblock
  fi
done < ./brews
