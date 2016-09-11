#!/bin/env zsh

source

while read i; do
  if  [[ !  -z  $param  ]]; do
    echo "testing $i"
    brew install $i
    brew uninstall $i
    brew cleanup;
  fi
done < brews
