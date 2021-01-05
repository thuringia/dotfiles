### customizations for WSL ###
if [ -n "${WSL_DISTRO_NAME+set}" ]; then
	#unsetopt BG_NICE
	export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
	export LIBGL_ALWAYS_INDIRECT=1
fi

# Customize to your needs...
export PATH="/bin:/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/robert/.local/bin:/home/robert/bin:$PATH"

### add to $PATH ###
export PATH="$PATH:`yarn global bin`" # add yarn global packages to path
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin/"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$HOME/.poetry/bin:$PATH"

### thefuck ###
if [ -x "$(command -v thefuck)" ]; then
	eval "$(thefuck --alias fuck)"
fi

### awsume - easy aws role usage ###
if [ -x "$(command -v awsume)" ]; then
	alias awsume=". awsume"
fi

# set up homebrew-based tools
if [ -x "$(command -v brew)" ]; then
	### z - fast cd ###
	. `brew --prefix`/etc/profile.d/z.sh
fi

### OTHER ###
export HOMEBREW_GITHUB_API_TOKEN=""
