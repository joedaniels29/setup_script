#!/bin/env zsh

brew install wget 
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



curl https://install.meteor.com/ | sh
gem install cocoapods
gem install fastlane
npm install -g bower
# npm install  -g steroids
npm install -g ember-cli



curl https://gist.githubusercontent.com/joedaniels29/f9fb30554649f68d2c973f8d4e98b68b/raw > .tmux.conf
curl https://gist.github.com/joedaniels29/4d30854664085d75d78b71b735d26647/raw > ~/Library/Keyboard\ Layouts/simple.keylayout
curl https://gist.github.com/joedaniels29/4d30854664085d75d78b71b735d26647/raw > ~/Library/Preferences/com.divisiblebyzero.Spectacle.plist
wget https://www.dropbox.com/s/63gjkdrck5wiqy3/com.divisiblebyzero.Spectacle.plist?dl=1 -O ~/Library/Preferences/com.divisiblebyzero.Spectacle.plist
wget https://gist.github.com/joedaniels29/647388ca7a36d19762614dbd454ff0e8/raw -O ~/Library/Application\ Support/Karabiner/private.xml
wget https://gist.github.com/joedaniels29/909a18f542196800eeb5145b7f3a68db/raw -O /Users/Joe/Library/Developer/Xcode/UserData/KeyBindings/Joes.idekeybindings