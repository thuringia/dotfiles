### customizations for WSL ###
if [ -n "${WSL_DISTRO_NAME+set}" ]; then
	#unsetopt BG_NICE
	wsl_display_host="$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null)"
	if [ -n "${wsl_display_host}" ]; then
		export DISPLAY="${wsl_display_host}:0"
	fi
	unset wsl_display_host
	export LIBGL_ALWAYS_INDIRECT=1
fi

unset HOMEBREW_SHELLENV_PREFIX

# Initialize Homebrew in a portable way for Apple Silicon and Intel installs.
if [ -x "/opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
	eval "$(/usr/local/bin/brew shellenv)"
fi

# Prefer uv-managed Python on hosts that have uv installed.
if command -v uv >/dev/null 2>&1; then
	export UV_PYTHON_PREFERENCE="managed"
fi

# Keep user-local binaries reachable across macOS and Linux hosts.
export PATH="$HOME/.local/bin:$PATH"

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
	### z - fast cd ###
	z_sh="$(brew --prefix)/etc/profile.d/z.sh"
	[ -r "$z_sh" ] && . "$z_sh"
	unset z_sh
fi

### OTHER ###
# Load Homebrew's GitHub token from 1Password.
# Optional override:
# export OP_HOMEBREW_GITHUB_TOKEN_REF="op://Vault/Item/credential"
if [ -z "${HOMEBREW_GITHUB_API_TOKEN:-}" ] && command -v op >/dev/null 2>&1; then
	: "${OP_HOMEBREW_GITHUB_TOKEN_REF:=op://Personal/Homebrew GitHub API Token/credential}"
	op_brew_token="$(op read "$OP_HOMEBREW_GITHUB_TOKEN_REF" 2>/dev/null || op read "op://Personal/Homebrew GitHub API Token/password" 2>/dev/null || op read "op://Private/Homebrew GitHub API Token/credential" 2>/dev/null || op read "op://Private/Homebrew GitHub API Token/password" 2>/dev/null || true)"
	if [ -n "$op_brew_token" ]; then
		export HOMEBREW_GITHUB_API_TOKEN="$op_brew_token"
	fi
	unset op_brew_token
fi
