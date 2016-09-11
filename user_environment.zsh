#!/bin/env zsh

cd ~/;
for d (Projects/Work Projects/Mine Projects/Contract Projects/School); do
  mkdir -p $d
done

git clone --recursive https://github.com/joedaniels29/prezto.git "${ZDOTDIR:-$HOME}/.zprezto";
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

git clone  git@github.com:joedaniels29/zsh_scripts.git "~/.zsh_scripts";
git clone  git@github.com:joedaniels29/.tmuxinator.git "~/.tmuxinator";

for f (FiraCode-Bold.ttf FiraCode-Light.ttf FiraCode-Medium.ttf FiraCode-Regular.ttf FiraCode-Retina.ttf); do
    wget https://github.com/tonsky/FiraCode/raw/master/distr/ttf/$f -O /Library/Fonts/$f
done
# Preferences
cd ~/Library/Preferences
for f (IntelliJIdea2016.2 AppCode2016.2); do
    git clone https://github.com/joedaniels29/$f
done
cd ~
