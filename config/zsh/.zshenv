#  ~/.zshenv
# Core envionmental variables
# Locations configured here are requred for all other files to be correctly imported

# Set XDG directories
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"
export XDG_CACHE_HOME="${HOME}/.cache"
export GIT_CONFIG_GLOBAL="${XDG_CONFIG_HOME}/git/.gitconfig"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"


source $XDG_CONFIG_HOME/zsh/.zshrc
