#!/bin/bash
# WSL dev environment setup: tmux, mosh, neovim, yazi + utilities
# Idempotent: safe to re-run; completed steps are skipped.
set -euo pipefail

cd ~

# ---------------------------------------------------------------------------
# sudo: prompt once up front, then keep the credential cache alive so the
# script can run unattended end-to-end (builds take longer than sudo's
# 15-minute timeout)
# ---------------------------------------------------------------------------
sudo -v
( while true; do sleep 60; sudo -n true; done ) 2>/dev/null &
SUDO_KEEPALIVE=$!
trap 'kill "$SUDO_KEEPALIVE" 2>/dev/null' EXIT

# ---------------------------------------------------------------------------
# apt packages (build deps + utilities)
# ---------------------------------------------------------------------------
sudo apt-get update
sudo apt-get install -y \
  build-essential cargo git ninja-build gettext libtool libtool-bin autoconf \
  automake cmake g++ pkg-config unzip curl doxygen wget fontconfig ffmpeg \
  7zip jq fzf zoxide lua5.1 luarocks fd-find python3 python3-pip \
  resvg tree-sitter-cli \
  libprotobuf-dev protobuf-compiler libevent-dev \
  libncurses-dev bison byacc libssl-dev libutempter-dev zlib1g-dev

# fd-find ships its binary as `fdfind`; expose it under the usual name
mkdir -p ~/.local/bin
ln -sf "$(command -v fdfind)" ~/.local/bin/fd

# ---------------------------------------------------------------------------
# git config
# ---------------------------------------------------------------------------
git config --global user.name "Shalin Lathigra"
git config --global user.email shalinlathigra@gmail.com

# NOTE: Nerd Fonts (FiraCode) must be installed on the *Windows* side, since
# Windows Terminal renders the text. Download FiraCode.zip from
# https://github.com/ryanoasis/nerd-fonts/releases and install the .ttf
# files in Windows (right-click -> Install), then select the font in your
# terminal profile settings.

# ---------------------------------------------------------------------------
# dotfiles repo (setup script, neovim config, ...)
# ---------------------------------------------------------------------------
[ -d ~/effective-barnacle ] || git clone https://github.com/ShalinLathigra/effective-barnacle.git ~/effective-barnacle

mkdir -p ~/.config
if [ ! -e ~/.config/nvim ] || [ -L ~/.config/nvim ]; then
  ln -sfn ~/effective-barnacle/nvim ~/.config/nvim
else
  echo "WARNING: ~/.config/nvim already exists and is not a symlink; leaving it untouched." >&2
fi

mkdir -p ~/tools

# ---------------------------------------------------------------------------
# neovim (stable, from source)
# ---------------------------------------------------------------------------
if ! command -v nvim >/dev/null 2>&1; then
  cd ~/tools
  [ -d neovim ] || git clone --depth 1 --branch stable https://github.com/neovim/neovim.git
  cd neovim
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd ~
fi

# ---------------------------------------------------------------------------
# ripgrep
# ---------------------------------------------------------------------------
if ! command -v rg >/dev/null 2>&1; then
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep_14.1.1-1_amd64.deb
  sudo dpkg -i ripgrep_14.1.1-1_amd64.deb
  rm ripgrep_14.1.1-1_amd64.deb
fi

# ---------------------------------------------------------------------------
# rustup + cargo (non-interactive)
# ---------------------------------------------------------------------------
if [ ! -x "$HOME/.cargo/bin/cargo" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
source "$HOME/.cargo/env"

# ---------------------------------------------------------------------------
# yazi (from source)
# ---------------------------------------------------------------------------
if ! command -v yazi >/dev/null 2>&1; then
  cd ~/tools
  [ -d yazi ] || git clone https://github.com/sxyazi/yazi.git
  cd yazi
  cargo build --release --locked
  sudo install -m 755 target/release/yazi target/release/ya /usr/local/bin/
  cd ~
fi

# ---------------------------------------------------------------------------
# mosh (from source)
# ---------------------------------------------------------------------------
if ! command -v mosh >/dev/null 2>&1; then
  cd ~/tools
  [ -d mosh ] || git clone https://github.com/mobile-shell/mosh
  cd mosh
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd ~
fi

# ---------------------------------------------------------------------------
# tmux (from source)
# ---------------------------------------------------------------------------
if ! command -v tmux >/dev/null 2>&1; then
  cd ~/tools
  [ -d tmux ] || git clone https://github.com/tmux/tmux.git
  cd tmux
  sh autogen.sh
  ./configure
  make
  sudo make install
  cd ~
fi

echo ""
echo "Setup complete. Installed versions:"
nvim --version | head -n 1
rg --version | head -n 1
yazi --version
mosh --version 2>&1 | head -n 1 || true
tmux -V
echo ""
echo "Remaining manual steps:"
echo "  - Ensure ~/.local/bin and ~/.cargo/bin are on your PATH (rustup adds"
echo "    the latter to ~/.bashrc automatically)."
echo "  - Add shell integration to ~/.bashrc:"
echo "      eval \"\$(zoxide init bash)\""
echo "      eval \"\$(fzf --bash)\""
echo "  - Install FiraCode Nerd Font on the Windows side."
