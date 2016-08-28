apt-get install zsh;
sudo adduser --group sudo joe -s$(which zsh)

sudo -u joe zsh -s << EOF
cd ~/;
git clone --recursive https://github.com/joedaniels29/prezto.git "${ZDOTDIR:-$HOME}/.zprezto";
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

git clone  git@github.com:joedaniels29/zsh_scripts.git "~/.zsh_scripts";

EOF
