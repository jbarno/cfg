# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# 
# COMPLETIONS
fpath+=$HOME/.zfunc

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
         tmux
         kubectl
         kube-ps1
         git-flow
         postgres
         zsh-autosuggestions
         )

source $ZSH/oh-my-zsh.sh

# User configuration
[ -f $HOME/.profile ] && source $HOME/.profile


export PY_DEV_TOOLS=1
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR='vim'

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   # would you look at this little injection point, neat
#   export EDITOR='mvim'
# fi

# Compilation flags
# packer is your friend here
# export ARCHFLAGS="-arch x86_64"

# ssh
# see cry()
# also why does id_ed25519 become supported but have less bits
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Fedora
# why not a container tho dumb dumb 
# note the arch is hardcoded
alias signal='2>/dev/null 1>&2 /usr/bin/flatpak run org.signal.Signal/x86_64/stable &'

# goodies explained
# hide your keys
setopt histignorespace
# vimmy up that shell a bit i.e. esc exits insert mode search and jk scroll
bindkey -v

# Get world info
alias wthr='/usr/bin/curl wttr.in/$HOME_WEATHER'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Please forgive me
alias souce='source'

alias tarit='/usr/bin/tar -zcvf'
alias untarit='/usr/bin/tar -xvf'

# Openstack
alias os='openstack server list'

kill_boxen()
{
    openstack server delete $1 && salt-key -d $1
}

# start status stop
vpn()
{
    sudo systemctl $1 openvpn@$2
}

# lynx a browser vimmy
alias lynx='/usr/bin/lynx -vikeys -anonymous'

# Python
install_pyenv()
{
    $HOME/.pyenv-installer/bin/pyenv-installer
}

alias ptest='python -m pytest '
alias ptox='poetry run tox'

# The best dirtiest way to find wtf 
pywhich()
{
  python -c "import $1; print($1.__file__);"
}

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[[ -x /usr/local/bin/virtualenvwrapper_lazy.sh ]] && source /usr/local/bin/virtualenvwrapper_lazy.sh

# GO keep
# export PATH=$PATH:/usr/local/go/bin

# KUBE
alias kc=kubectl
alias mk=minikube
alias ctp=

_kca()
{
    kubectl $1 $2 --all-namespaces
}

klogs()
{
    for container in $(kubectl get pods -n $1 -o name); do echo "------------------------ ${container} -----------------------" | grep -iE "${container}" --color=always; kubectl -n $1 logs ${container} | tail -n 20; done
}

# Jimmothy
cry ()
{
    ssh-add -l > /dev/null 2>&1;
    if [[ $? -eq 1 ]]; then
        eval $(ssh-agent) > /dev/null 2>&1;
        ssh-add -K > /dev/null 2>&1;
    fi
}

# Can take some tweaking but script with
# git updates+ci systems that watch and queue it
swap()
{
  ag -r -l "$1" | xargs -r -d'\n' sed -i "s/"${1}"/"${2}"/g"
}


# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# export PATH="/usr/local/sbin:$PATH"
