#!/bin/env zsh

source config_brew.zsh

while read i
do
  if  [[ !  -z  $i ]]; then
    echo "testing $i"
    brew install $i
    if  [[ $TESTING == "true"  ]]; then
      brew uninstall $i
      brew cleanup > /dev/null
      fi
  fi
done < ./brews
