unsetopt BG_NICE
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1

# Customize to your needs...
export PATH="/bin:/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/robert/.local/bin:/home/robert/bin:$PATH"

### add to $PATH ###
export PATH="$PATH:`yarn global bin`" # add yarn global packages to path
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin/"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# set up tools

### pyenv ###
export PYENV_VERSION=2.7.11
#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

### thefuck ###
eval "$(thefuck --alias fuck)"

### z - fast cd ###
. `brew --prefix`/etc/profile.d/z.sh

### OTHER ###
export HOMEBREW_GITHUB_API_TOKEN=""
