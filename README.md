# Dotfiles using chezmoi
## Full install, run from your home directory
`EJSON_KEY=<key> sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jmhufford`

## Reconfigure
`EJSON_KEY=$(chezmoi dump-config | jq -r .ejson.key) chezmoi init`

## Containers


# Dependencies
## chezmoi
ejson
ejson2env
jq

## neovim
### install packer
`git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
