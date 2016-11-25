sudo apt-get update;
sudo apt-get install zsh;
sudo apt-get install git;

sudo adduser joe --ingroup sudo --shell $(which zsh)

sudo -u joe zsh -s <<EOF
cd ~/;
git clone --recursive https://github.com/joedaniels29/prezto.git "${ZDOTDIR:-$HOME}/.zprezto";
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -fs "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

cd ~/;
git clone  https://github.com/joedaniels29/zsh_scripts.git .zsh_scripts;

EOF



# fasd
sudo add-apt-repository ppa:aacebedo/fasd;
sudo apt update;
sudo apt install fasd;



#where does this stuff go?

sudo dpkg-reconfigure tzdata
# Install ntp
sudo apt-get update
sudo apt-get install ntp
