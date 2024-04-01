# Configuration Repository 

This (bare)repo contains all the important config files and instructions to setup a new workspace.

## Terminal 

1. Install Alacritty Terminal


```sh
// see installation instructions here: https://github.com/alacritty/alacritty/blob/master/INSTALL.md
cargo install alacritty
```

1. Install zsh(optional)

```zsh
sudo apt install zsh
zsh --version
# make zsh the default shell
chsh -s $(which zsh)
```

1. Install [Oh-my-zsh](https://ohmyz.sh/#install)

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

1. Install [starship](https://starship.rs/) cross shell prompt, works with `bash`, `zsh` and `fish` shells.


## Nerd Fonts

Convenience way to install Nerd Fonts is using `install.sh` script.

```sh
cd ~/Tools
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install FiraCode
./install Hack

# to check 
fc-list | grep Hack
```

## Github Repo

1. Create a new ssh-key([github tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)) and add it to the github.

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

## Track configs 

Atlassian has a really good [tutorial](https://www.atlassian.com/git/tutorials/dotfiles) explaining the whole workflow. Following are extract of that tutorial.

### Setup bare repository

1. Initiate the bare repository `git init --bare $HOME/.cfg -b main`

1. Add a new function to wrap bare git command

```zsh
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
```

1. Update config to don't show untrack files. ` config config --local status.showUntrackedFiles no`

### Setup existing bare repository

1. First clone the repository to the local directory. 

```zsh
git clone --bare https://bitbucket.org/durdn/cfg.git $HOME/.cfg
```

1. Add config function to .zshrc

```zsh
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
```

1. Checkout the repo and update configs to not to show untracked files.

```zsh
config checkout
config config status.showUntrackedFiles no 
```
## Neovim

1. Download Neovim binary from [here](https://neovim.io/) 

1. Extract binary and add it to $PAtH env variable.

```sh
# Create `Tools` directory if not exist
mkdir -p ~/Tools
cd Downloads
tar -zxf nvim-linux64.tar.gz
# Append version to the directory
mv nvim-linux64 ~/Tools/nvim-linux64_v094
echo "export PATH=$HOME/Tools/nvim-linux64_v094/bin:$PATH" >> ~/.zshrc
exec zsh
```
1. If neovim is available alias `vim` to `nvim` 

```sh
if type nvim > /dev/null 2>&1; then
    alias vim=nvim
fi

export EDITOR=nvim
export VISUAL=nvim
```

1. Copy [LasyVim](https://github.com/LazyVim/LazyVim) [starter configs](https://www.lazyvim.org/installation).

```sh
# back up existing nvim config if any
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim
```

## Setup Regolith Desktop Evironment.

[Regolith](https://regolith-desktop.com/) is i3 based desktop environment.


## Setup i3wm

###  Install

Run `sudo apt-get insatall i3` and logout and log back to i3


### Swap LeftAlt <-> LeftCtl 

Follow keyd [installation instructions](https://github.com/rvaiya/keyd#installation).

```sh
cd Tools/
git clone https://github.com/rvaiya/keyd
cd keyd
make && sudo make install
sudo systemctl enable keyd && sudo systemctl start keyd
# Install and start keyd
sudo systemctl enable keyd

# create default conf file
sudo touch /etc/keyd/default.conf
# update configs and reload
sudo keyd reload

# To monitor keys
sudo keyd monitor
```

Swap keys with following configs

```sh
[ids]

*

[main]

# Maps capslock to escape.
capslock = esc 

# Remap Left Ctrl and Left Alt
leftalt = leftcontrol
leftcontrol = leftalt
```
### Polybar

```sh
# install polybar
sudo apt install polybar
# If needed copy the default config
# mkdir -p ~/.config/polybar && cp /usr/share/doc/polybar/config ~/.config/polybar/
chmod +x ~/.config/polybar/launch.sh
```

```sh
#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."
```

Add following to `$HOME/.config/i3/config` file and remove `bar` block in config.

```sh
exec_always --no-startup-id $HOME/.config/polybar/launch.sh
```

### Set wallpaper

#### Nitrogen

```sh
sudo apt-get install nitrogen
```
