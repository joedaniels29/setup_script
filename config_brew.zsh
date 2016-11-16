#!/bin/env zsh





while read i
do
  echo "taping  $i";
  brew tap $i;
done < ./taps
brew update;
brew upgrade --all > /dev/null;
brew cleanup > /dev/null
