### customizations for WSL ###
if [ -n "${WSL_DISTRO_NAME+set}" ]; then
	#unsetopt BG_NICE
	export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
	export LIBGL_ALWAYS_INDIRECT=1
fi

unset HOMEBREW_SHELLENV_PREFIX 
system=`uname -a`
if [[ $system == *_ARM64_* ]]; then
	#export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
        eval $(/opt/homebrew/bin/brew shellenv)
	export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:$PATH"
fi

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

