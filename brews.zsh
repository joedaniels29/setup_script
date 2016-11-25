#!/usr/bin/env zsh

source config_brew.zsh
if  [[ -n $TESTING ]]; then
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
fi
do_brew(){
    local installit=$1
    local uninstallit=$2
    brew ${(z)installit} $3
    if  [[ $TESTING == "true"  ]]; then
      brew ${(z)uninstallit} $3
    fi
}

do_install_brew_set(){
    while read i
    do
      if  [[ !  -z  $i ]]; then
        echo "testing $i"
        do_brew "$CASK_CMD_PCH install" "$CASK_CMD_PCH uninstall --force" $i &
        if  [[ -n $TESTING ]]; then concblock; fi
      fi
    done < ./$BREW_SET
}

if  [[ -z $TESTING ]]; then
  do_install_brew_set brews_set_1
  do_install_brew_set brews_set_2
  do_install_brew_set brews_set_3
  CASK_CMD_PCH=cask do_install_brew_set cask
else
  do_install_brew_set $BREW_SET
fi
