#dotfiles

> My dotfiles for UNIX-based operating systems.

Configuration for both `bash` and `zsh` is installed, so you can use whichever shell you'd like. However, only the configuration for `zsh` is being maintained and updated.

## Installation

```
git clone https://github.com/mass/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh -o
```
The `-o` option installs read-only remotes, which will allow you to clone the submodules if you don't have write access to them (which you don't, unless you're me).

If you are installing this configuation on a EWS machine, use the `-e` option as well. If you don't know what EWS is, don't worry about it.

If you already have any of the configuration files that this configuration installs, you will be asked if they should be replaced. If you want to keep your old files, enter `n`. If you want to use my configuation files, enter `y`.

Once the script finishes, simply open a new terminal shell to begin using your new configuration!

## Updating
```
cd ~/.dotfiles
./update.sh
```
This will pull down the latest code from the main repository and the submodules.
