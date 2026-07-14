# start in home dir
cd ~

# install build dependencies
sudo apt update
sudo apt install git ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen wget fontconfig ffmpeg 7zip jq fzf zoxide resvg lua5.1 libprotobuf-dev protobuf-compiler -y

sudo apt-get install fd-find python3 luarocks pip tree-sitter-cli -y

# git config

git config --global user.name  "Shalin Lathigra"
git config --global user.email shalinlathigra@gmail.com

# FiraCode font install (possibly not needed)
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
mkdir font-tmp
unzip FiraCode.zip -d font-tmp
mv font-tmp/*.ttf ~/.local/share/fonts
rm -rf font-tmp
fc-cache -vf

# tools install dir
mkdir -p ~/tools
cd ~/tools

# neovim install
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
cd ..

# ripgrep install
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep_14.1.1-1_amd64.deb
sudo dpkg -i ripgrep_14.1.1-1_amd64.deb

# Rustup + Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env 
rustup update
# May need to run this one twice

# Yazi
git clone https://github.com/sxyazi/yazi.git
cd yazi
cargo build --release --locked
sudo mv target/release/yazi target/release/ya /usr/local/bin/
cd ..

# mosh
git clone https://github.com/mobile-shell/mosh
cd mosh
./autogen.sh
./configure
make
make install
cd ..

# tmux install 
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure & make
make install
cd ..
