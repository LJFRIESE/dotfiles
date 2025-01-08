#! /bin/bash

# git
sudo apt install git

git config --global user.email "lucas.j.friesen@gmail.com"
git config --global user.name "LJFRIESE"
git config --global credential.helper store
# Folders
mkdir ~/git
mkdir ~/.config
mkdir ~/.config/dotfiles

# Get dots
git clone https://github.com/LJFRIESE/dotfiles ~/.config/dotfiles
# link them to home
ln ~/.config/dotfiles/* .

# Neovim
## build tools
sudo apt-get install ninja-build gettext cmake unzip curl build-essential

git clone https://github.com/neovim/neovim ~/git/neovim
cd ~/git/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
## Build
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

# ZSH
sudo apt update
sudo apt install zsh
# install oh-my-zsh to set zsh as default shell and install plugins
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## plugins
### PowerLevel
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/git/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

### autocomplete
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git# ~/git/

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Neovim
## build tools
sudo apt-get install ninja-build gettext cmake unzip curl build-essential

git clone https://github.com/neovim/neovim ~/git/neovim
cd ~/git/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
## Build
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

# Go
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

