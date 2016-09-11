#!/bin/sh
local script_location=$(pwd)/setup.sh
fancy_echo() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

HOMEBREW_PREFIX="/usr/local"

# if [ -d "$HOMEBREW_PREFIX" ]; then
#   if ! [ -r "$HOMEBREW_PREFIX" ]; then
#     sudo chown -R "$LOGNAME:admin" /usr/local
#   fi
# else
#   sudo mkdir "$HOMEBREW_PREFIX"
#   sudo chflags norestricted "$HOMEBREW_PREFIX"
#   sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
# fi

case "$SHELL" in
  */zsh) : ;;
  *)
    fancy_echo "Changing your shell to zsh ..."
      chsh -s "$(which zsh)" || true
    ;;
esac

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
  fi
}

if [ ! -d "$HOME/.rvm/" ]; then
    curl -L https://get.rvm.io | bash -s stable --ruby --rails || true
    . ~/.rvm/scripts/rvm
fi

gem update --system
gem_install_or_update 'bundler'
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    # append_to_zshrc '# recommended by brew doctor'
    #
    # # shellcheck disable=SC2016
    # append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

    export PATH="/usr/local/bin:$PATH"
fi


fancy_echo "brewing! ..."


cd $script_location

zsh ./brews.zsh
zsh ./user_environment.zsh


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
