#!/bin/sh

# ln -s $PWD/init.vim ~/.config/nvim/init.vim
# ln -s $PWD/Frugal.colloquyStyle ~/Library/Application\ Support/Colloquy/Styles/Frugal.colloquyStyle
# ln -s $PWD/.Xdefaults ~/.Xdefaults
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.spacemacs ~/.spacemacs
ln -s $PWD/.alacritty.yml ~/.alacritty.yml

mkdir -p ~/.config/nvim
ln -s $PWD/init.lua ~/.config/nvim/init.lua
ln -s $PWD/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sf $PWD/lua/ ~/.config/nvim/.

mkdir -p ~/.config/doom
ln -s $PWD/doom/init.el ~/.config/doom/init.el
ln -s $PWD/doom/packages.el ~/.config/doom/packages.el
ln -s $PWD/doom/config.el ~/.config/doom/config.el

# for x1:
sudo ln -s $PWD/flake.nix /etc/nixos/flake.nix

# ln -s $PWD/spacemacsOS ~/.emacs.d/private/exwm
