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
typeset -U path PATH
path=("$HOME/.local/bin" $path)
export PATH

### OTHER ###
# Homebrew GitHub token reference in 1Password.
# Optional override:
# export OP_HOMEBREW_GITHUB_TOKEN_REF="op://Vault/Item/credential"
: "${OP_HOMEBREW_GITHUB_TOKEN_REF:=op://Personal/Homebrew GitHub API Token/credential}"

# Echoes the token on stdout when available, otherwise returns non-zero.
__read_homebrew_github_api_token() {
	command -v op >/dev/null 2>&1 || return 1

	op read "$OP_HOMEBREW_GITHUB_TOKEN_REF" 2>/dev/null \
		|| op read "op://Personal/Homebrew GitHub API Token/password" 2>/dev/null \
		|| op read "op://Private/Homebrew GitHub API Token/credential" 2>/dev/null \
		|| op read "op://Private/Homebrew GitHub API Token/password" 2>/dev/null
}
