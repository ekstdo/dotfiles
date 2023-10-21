ln -sr ./.zshrc ~/.zshrc 
mkdir -p ~/.config/kitty
ln -sr ./kitty.conf ~/.config/kitty/
ln -sr ./neovim-config ~/.config
mv ~/.config/neovim-config ~/.config/nvim
git submodule init
