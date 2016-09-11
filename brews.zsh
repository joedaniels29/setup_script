#!/bin/env zsh

source config_brews.zsh

while read i; do
  if  [[ !  -z  $i  ]]; do
    echo "testing $i"
    brew install $i
    if  [[ $TESTING == "true"  ]]; do
      brew uninstall $i
      brew cleanup;
    done
  fi
done < brews
