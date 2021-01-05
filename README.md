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

### Software from Mac App Store
Software from MAS will be installed by Homebrew using [`mas-cli`](https://github.com/mas-cli/mas) and will be installed using the `Brewfile`

## Shell setup
The setup is managed by [zplug](https://github.com/zplug/zplug). Binary packages are contained in `Brewfile`, everything else will be installed automatically by zplug.

## Emacs / spacemacs
1. `ln -s ~/dotfiles/spacemacs .spacemacs`
2. `git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d`

It is recommended to use the develop branch for spacemacs.
