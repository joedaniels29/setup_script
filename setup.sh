#!/bin/sh

script_location=$(pwd)
fancy_echo() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

# HOMEBREW_PREFIX="/usr/local"

# if [ -d "$HOMEBREW_PREFIX" ]; then
#   if ! [ -r "$HOMEBREW_PREFIX" ]; then
#     sudo chown -R "$LOGNAME:admin" /usr/local
#   fi
# else
#   sudo mkdir "$HOMEBREW_PREFIX"
#   sudo chflags norestricted "$HOMEBREW_PREFIX"
#   sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
# fi
if [[ $TESTING != "true" ]]; then
    case "$SHELL" in
      */zsh) : ;;
      *)
        fancy_echo "Changing your shell to zsh ..."
          chsh -s "$(which zsh)" || true
        ;;
    esac
fi
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
