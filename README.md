# Configuration Repository

This (bare)repo contains all the important config files and instructions to setup a new workspace.

## Workspace Setup

### Install Prerequsites.

```sh
// Install github
sudo apt update && sudo apt upgrade && sudo apt install git

// Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Setup Github

Create a new ssh-key([github tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)) and add it to the [github account](https://github.com/syodage).

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"

// add new key to ssh agent.
ssh-add ~/.ssh/id_ed25519


```

### Setup configs bare repository.

Atlassian has a really good [tutorial](https://www.atlassian.com/git/tutorials/dotfiles) explaining the whole workflow. Following are extract of that tutorial.

#### Setup bare repository

```sh
// Initiate new bare repository to track configs
git init --bare $HOME/.cfg -b main
// add new alias to wrap bare git command.
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
// Optionally you can add a shell function
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

// Dissable showing untrack files.
config config --local status.showUntrackedFiles no

// Add new alias to bashrc
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc

// setup remote repository
config remote add origin git@github.com:syodage/dot-configs.git
config push -u origin main
```

```sh
// Track a new file.
config status
config add .bashrc
config commit -m "Add bashrc"
config push
```

#### Setup existing bare repository

```sh
// to avoid weird recursion problem.
echo ".cfg" >> .gitignore

// Clone the bare repository
git clone --bare git@github.com:syodage/dot-configs.git $HOME/.cfg

// add new alias to wrap bare git command.
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

// checkout the actual content.
config checkout

// if above failed with `Please move or remove them before you can switch branches` error.
// run following command to move all the conflict configs to a backup directory
mkdir -p .config-backup && \
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} mv {} .config-backup/{}

// Set the flag showUntrackedFiles to no on this specific (local) repository.
config config status.showUntrackedFiles no

```

### Terminal

#### Alacritty Terminal

**Prerequsites** - rust and cargo

```sh
// see installation instructions here: https://github.com/alacritty/alacritty/blob/master/INSTALL.md
cargo install alacritty
```

#### Starship

Install [starship](https://starship.rs/) cross shell prompt, works with `bash`, `zsh` and `fish` shells.

Configs are located at `.config/starship/*`

### Nerd Fonts

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

## Archive

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

### Install

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

#### Nitrogen

```sh
sudo apt-get install nitrogen
```
