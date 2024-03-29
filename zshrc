alias mv="mv -v"
alias sv="sudo vim"
alias cat="bat"

export EDITOR=vim

system=`uname -a`
if [[ $system == *_ARM64_* ]]; then
        export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

# load zplug
# https://github.com/zplug/zplug
[ -s /usr/share/zsh/scripts/zplug ] && export ZPLUG_HOME=/usr/share/zsh/scripts/zplug
[ -s /usr/local/opt/zplug ] && export ZPLUG_HOME=/usr/local/opt/zplug
[ -s /opt/homebrew/opt/zplug ] && export ZPLUG_HOME=/opt/homebrew/opt/zplug
[ -s ~/.zplug ] && export ZPLUG_HOME=~/.zplug
[ -s /usr/share/zsh/scripts/zplug ] && export ZPLUG_HOME=/usr/share/zsh/scripts/zplug

source $ZPLUG_HOME/init.zsh
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# Bundles from the default repo (robbyrussell's oh-my-zsh).
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh


# customize prompt
zplug "zsh-users/fizsh"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "felixgravila/zsh-abbr-path"
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "hlissner/zsh-autopair", defer:2

# add quality of life
zplug "popstas/zsh-command-time"
zplug "djui/alias-tips"
zplug "timothyrowan/betterbrew-zsh-plugin", if:"[[ $OSTYPE == *darwin* ]]"
zplug "gusaiani/elixir-oh-my-zsh"
zplug "g-plane/zsh-yarn-autocompletions", hook-build:"./zplug.zsh", defer:2
zplug "agkozak/zsh-z"

# enhance git
zplug "plugins/git", from:oh-my-zsh
zplug "unixorn/git-extra-commands"
zplug "smallhadroncollider/antigen-git-rebase"
zplug "zdharma/zsh-diff-so-fancy", as:command, use:bin/git-dsf

# add tools
zplug "walesmd/caniuse.plugin.zsh", \
  defer:2, \
  rename-to:caniuse

#zplug "mattberther/zsh-pyenv"

# Load the theme.
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
#antigen theme agnoster

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
#zplug load --verbose
zplug load

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# bun completions
[ -s "/Users/rwa/.bun/_bun" ] && source "/Users/rwa/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/rwa/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
