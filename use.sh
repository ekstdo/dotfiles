ln -sr ./.zshrc ~/.zshrc 
mkdir -p ~/.config/kitty
mkdir -p ~/.config/rofi
ln -sr ./kitty.conf ~/.config/kitty/
ln -sr ./config.rasi ~/.config/rofi/
ln -sr ./neovim-config ~/.config
mv ~/.config/neovim-config ~/.config/nvim
git submodule init
