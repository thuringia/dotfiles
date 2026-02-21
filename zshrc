alias mv="mv -v"
alias sv="sudo vim"
command -v bat >/dev/null 2>&1 && alias cat="bat"
command -v eza >/dev/null 2>&1 && alias ls="eza --color=auto --git --icons=always"

export EDITOR=vim

# Shell behavior and history hardening.
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
hist_dir="${HISTFILE:h}"
[ -d "$hist_dir" ] || mkdir -p "$hist_dir" >/dev/null 2>&1
unset hist_dir

typeset -U path PATH

### thefuck ###
if command -v thefuck >/dev/null 2>&1; then
	eval "$(thefuck --alias fuck)"
fi

### awsume - easy aws role usage ###
if command -v awsume >/dev/null 2>&1; then
	alias awsume=". awsume"
fi

# set up homebrew-based tools
if command -v brew >/dev/null 2>&1; then
	z_sh="$(brew --prefix)/etc/profile.d/z.sh"
	[ -r "$z_sh" ] && . "$z_sh"
	unset z_sh
fi

# Homebrew wrapper: inject GitHub API token from 1Password only when needed.
if command -v brew >/dev/null 2>&1 && command -v __read_homebrew_github_api_token >/dev/null 2>&1; then
	brew() {
		local op_brew_token=""
		if [ -z "${HOMEBREW_GITHUB_API_TOKEN:-}" ]; then
			op_brew_token="$(__read_homebrew_github_api_token 2>/dev/null || true)"
		fi

		if [ -n "$op_brew_token" ]; then
			HOMEBREW_GITHUB_API_TOKEN="$op_brew_token" command brew "$@"
		else
			command brew "$@"
		fi
	}
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
zplug_init=""
zplug_prefix=""
if [ -r "/opt/homebrew/opt/zplug/init.zsh" ]; then
	zplug_prefix="/opt/homebrew/opt/zplug"
elif [ -r "/usr/local/opt/zplug/init.zsh" ]; then
	zplug_prefix="/usr/local/opt/zplug"
fi

if [ -r "$HOME/.zplug/init.zsh" ]; then
	zplug_init="$HOME/.zplug/init.zsh"
elif [ -r "/usr/share/zsh/scripts/zplug/init.zsh" ]; then
	zplug_init="/usr/share/zsh/scripts/zplug/init.zsh"
elif [ -n "$zplug_prefix" ] && [ -r "$zplug_prefix/init.zsh" ]; then
	zplug_init="$zplug_prefix/init.zsh"
fi

if [ -n "$zplug_init" ]; then
	source "$zplug_init"
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
	if ! zplug check --verbose >/dev/null 2>&1; then
		printf "Install missing zplug plugins? [y/N]: "
		if read -q; then
			echo
			zplug install
		else
			echo
		fi
	fi

	# Then, source plugins and add commands to $PATH
	zplug load
fi
unset zplug_init
unset zplug_prefix

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)

# Set up fzf key bindings and fuzzy completion
if command -v fzf >/dev/null 2>&1; then
	source <(fzf --zsh)
fi

[ -r "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Added by Antigravity
path=("$HOME/.antigravity/antigravity/bin" $path)

# OpenClaw Completion
if command -v openclaw >/dev/null 2>&1; then
	source <(openclaw completion --shell zsh)
fi

export PATH
