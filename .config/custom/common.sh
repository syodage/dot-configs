############ CUSTOM CONFIGS ######################

export PATH=$PATH:/usr/local/go/bin

######## NVIM Configs ################
export PATH="$PATH:/opt/nvim-linux64/bin"
. "$HOME/.cargo/env"

if type nvim >/dev/null 2>&1; then
	alias vim=nvim
fi

export EDITOR=nvim
export VISUAL=nvim

######## Aliases ################
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|to\ full|percentage"'
# Dotfile Configs
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

######## Startship Configs ######
export STARSHIP_CONFIG=~/.config/starship/starship.toml
