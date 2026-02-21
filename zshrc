alias mv="mv -v"
alias sv="sudo vim"
command -v bat >/dev/null 2>&1 && alias cat="bat"
command -v eza >/dev/null 2>&1 && alias ls="eza --color=auto --git --icons=always"

export EDITOR=vim

POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

# load zplug
# https://github.com/zplug/zplug
if [ -r "/usr/share/zsh/scripts/zplug/init.zsh" ]; then
	export ZPLUG_HOME="/usr/share/zsh/scripts/zplug"
elif [ -r "/usr/local/opt/zplug/init.zsh" ]; then
	export ZPLUG_HOME="/usr/local/opt/zplug"
elif [ -r "/opt/homebrew/opt/zplug/init.zsh" ]; then
	export ZPLUG_HOME="/opt/homebrew/opt/zplug"
elif [ -r "$HOME/.zplug/init.zsh" ]; then
	export ZPLUG_HOME="$HOME/.zplug"
fi

if [ -n "${ZPLUG_HOME:-}" ] && [ -r "$ZPLUG_HOME/init.zsh" ]; then
	source "$ZPLUG_HOME/init.zsh"
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

	# Load the theme.
	zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

	# Install plugins if there are plugins that have not been installed
	if ! zplug check --verbose; then
		printf "Install? [y/N]: "
		if read -q; then
			echo
			zplug install
		fi
	fi

	# Then, source plugins and add commands to $PATH
	zplug load
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Set up fzf key bindings and fuzzy completion
if command -v fzf >/dev/null 2>&1; then
	source <(fzf --zsh)
fi

[ -r "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# OpenClaw Completion
if command -v openclaw >/dev/null 2>&1; then
	source <(openclaw completion --shell zsh)
fi
