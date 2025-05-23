ln -sr ./.zshrc ~/.zshrc 
mkdir -p ~/.config/kitty
mkdir -p ~/.config/rofi
mkdir -p ~/.config/jrnl
ln -sr ./kitty.conf ~/.config/kitty/
ln -sr ./config.rasi ~/.config/rofi/
ln -sr ./neovim-config ~/.config
mv ~/.config/neovim-config ~/.config/nvim
ln -sr ./jrnl.yaml ~/.config/jrnl
git submodule init
