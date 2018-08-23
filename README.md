# dotfiles

My collection of dotfiles, they may not be the best ones, but they are mine

## Prereqs
You need [Homebrew](http:://brew.sh) and git, the preinstalled version is good enough to clone the repo, we will replace it with one from Homebrew later.

Then clone the repo:
```
mkdir dotfiles && cd $_ && git clone git@github.com:thuringia/dotfiles.git .
```

## System Packages and Apps
If it is available via Homebrew, cask or otherwise, install it from there and update the `Brewfile`, if not, not down why.

Download everything by running
`brew bundle ~/dotfiles/Brewfile`

## Shell setup
The setup is managed by [zplug](https://github.com/zplug/zplug). Binary packages are contained in `Brewfile`, everything else will be installed automatically by zplug.

We will be installing the following packages for your zsh convenience (package names are Github-repo-style if you want to check them out):
```sh
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# Bundles from the default repo (robbyrussell's oh-my-zsh).
zplug "plugins/command-not-found", from:oh-my-zsh
#zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
#zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
#zplug "plugins/node", from:oh-my-zsh


# customize prompt
#zplug "zsh-users/fizsh"
#zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "felixgravila/zsh-abbr-path"
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "hlissner/zsh-autopair", defer:2

# add quality of life
zplug "popstas/zsh-command-time"
zplug "djui/alias-tips"
zplug "timothyrowan/betterbrew-zsh-plugin"
zplug "gusaiani/elixir-oh-my-zsh"
zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2

# enhance git
#zplug "plugins/git", from:oh-my-zsh
#zplug "unixorn/git-extra-commands"
zplug "smallhadroncollider/antigen-git-rebase"
zplug "zdharma/zsh-diff-so-fancy", as:command, use:bin/git-dsf

# add tools
zplug "walesmd/caniuse.plugin.zsh", \
  defer:2, \
  rename-to:caniuse

# Load the theme.
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
```

## Atom
Atom (stable and beta) is installed as a Homebrew cask. To configure:
1. Symlink the config directory `ln -s ~/dotfiles/atom .atom`
2. Install the `package-sync`  package `apm install package sync`
3. Launch atom, if packages are not installed automatically, run `Sync packages` from the command pallet

## Emacs / spacemacs
1. `ln -s ~/dotfiles/spacemacs .spacemacs`
2. `git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`
