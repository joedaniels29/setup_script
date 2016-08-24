#!/bin/sh

# Welcome to the thoughtbot laptop script!
# Be prepared to turn your laptop (or desktop, no haters here)
# into an awesome development machine.

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

# shellcheck disable=SC2016
append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'

HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" /usr/local
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

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

    append_to_zshrc '# recommended by brew doctor'

    # shellcheck disable=SC2016
    append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

    export PATH="/usr/local/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulae ..."
brew tap Homebrew/bundle
brew update
brew bundle --file=- <<EOF
cask_args appdir: '/Applications'

tap "caskroom/cask"
tap "choppsv1/term24"
tap "homebrew/boneyard"
tap "homebrew/core"
tap "homebrew/science"
tap "homebrew/versions"
tap "homebrew/x11"
tap "kylef/formulae"
tap "thoughtbot/formulae"
tap "homebrew/services"

brew "arpack"
brew "autoconf"
brew "automake"
brew "boost"
brew "cabal-install"
brew "cairo"
brew "carthage"
brew "casperjs"
brew "checkbashisms"
brew "clang-format"
brew "clisp"
brew "cmake"
brew "coreutils"
brew "diff-so-fancy"
brew "doxygen"
brew "elixir"
brew "emacs"
brew "epstool"
brew "erlang"
brew "fasd"
brew "fdk-aac"
brew 'ffmpeg', args: ['with-fdk-aac', 'with-ffplay', 'with-freetype', 'with-libass', 'with-libvorbis', 'with-libvpx', 'with-opus', 'with-x265']
brew "fftw"
brew "fontconfig"
brew "freetype"
brew "fribidi"
brew "gcc"
brew "gd"
brew "gdbm"
brew "gettext"
brew "ghc"
brew "ghostscript"
brew "git"
brew "gl2ps"
brew "glib"
brew "glpk"
brew "gmp"
brew "gnu-sed"
brew "gnupg"
brew "gnuplot"
brew "gobject-introspection"
brew "gradle"
brew "graphicsmagick"
brew "harfbuzz"
brew "hdf5"
brew "hub"
brew "icu4c"
brew "imagemagick"
brew "intltool"
brew "isl"
brew "jpeg"
brew "jq"
brew "lame"
brew "libass"
brew "libevent"
brew "libffi"
brew "libgpg-error"
brew "libksba"
brew "libmpc"
brew "libogg"
brew "libpng"
brew "libsigsegv"
brew "libtiff"
brew "libtool"
brew "libvorbis"
brew "libvpx"
brew "libyaml"
brew "little-cms2"
brew "llvm"
brew "lua"
brew "metis"
brew "mongodb"
brew "mp3cat"
brew "mpfr"
brew "nasm"
brew "node"
brew "octave"
brew "oniguruma"
brew "open-mpi"
brew "openssl"
brew "optipng"
brew "opus"
brew "p7zip"
brew "pcre"
brew "phantomjs"
brew "pixman"
brew "pkg-config"
brew "plotutils"
brew "postgresql"
brew "pstoedit"
brew "pypy"
brew "pyqt"
brew "python"
brew "python3"
brew "qhull"
brew "qrupdate"
brew "qscintilla2"
brew "qt"
brew "readline"
brew "reattach-to-user-namespace"
brew "redis"
brew "sdl"
brew "sip"
brew "sourcekitten"
brew "sqlite"
brew "suite-sparse"
brew "swiftenv"
brew "szip"
brew "tbb"
brew "texi2html"
brew "texinfo"
brew "tmux"
brew "transfig"
brew "unixodbc"
brew "veclibfort"
brew "watchman"
brew "webp"
brew "wget"
brew "wxmac"
brew "x264"
brew "x265"
brew "xvid"
brew "xz"
brew "yasm"
brew "zsh"
brew "gist"
cask 'google-chrome'
cask 'spectacle'
cask 'dropbox'
cask 'google-drive'
cask 'sourcetree'
cask 'transmission'
cask 'vlc'
cask 'flux'
cask 'atom'
cask 'telegram'
cask 'caffeine'
cask 'ukelele'
cask 'intellij-idea'
cask 'the-unarchiver'
cask 'slack'
cask 'appcode'
cask 'alfred'
cask 'alcatraz'
cask 'hipchat'
cask 'skitch'
cask 'injection'
cask 'iterm2'
cask 'sourcetree'

brew 'choppsv1/term24/tmux'
brew 'homebrew/science/veclibfort'
brew 'homebrew/science/arpack'
brew 'homebrew/science/glpk'
brew 'homebrew/science/hdf5'
brew 'homebrew/science/metis'
brew 'homebrew/science/transfig'
brew 'homebrew/science/qhull'
brew 'homebrew/science/qrupdate'
brew 'homebrew/science/suite-sparse'
brew 'homebrew/science/octave'
brew 'kylef/formulae/swiftenv'
# Databases
brew "postgres", restart_service: true
brew "redis", restart_service: true
EOF

cd ~/
# Want to have zsh syntax
cat <<EOF | zsh -s
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


EOF


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
