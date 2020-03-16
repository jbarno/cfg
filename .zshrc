# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export SHELL=/bin/zsh # A dirty hack

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# 
# COMPLETIONS
fpath+=$HOME/.zfunc

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux python pylint auto-pep8 kubectl kube-ps1 git-flow postgres go golang)

source $ZSH/oh-my-zsh.sh

# User configuration
[ -f $HOME/.profile ] && source $HOME/.profile


export PY_DEV_TOOLS=1
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
#
# Fedora
alias signal='2>/dev/null 1>&2 /usr/bin/flatpak run org.signal.Signal/x86_64/stable &'

# goodies
setopt histignorespace
bindkey -v

# Get world info
alias wthr='/usr/bin/curl wttr.in/Chicago'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
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



# Python
install_pyenv()
{
    $HOME/.pyenv-installer/bin/pyenv-installer
}

alias ptest='python -m pytest '
alias ptox='poetry run tox'
pywhich()
{
    python -c "import $1; print $1.__file__;"
}

export EDITOR=vim
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[[ -x /usr/local/bin/virtualenvwrapper_lazy.sh ]] && source /usr/local/bin/virtualenvwrapper_lazy.sh

#GO
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Developemnt/go

#KUBE
alias kc=kubectl
alias mk=minikube

kca()
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
docucry ()
{
  eval `ssh-agent -s` && ssh-add && source ~/.ssh/rc
}

fixit ()
{
  export SSH_AUTH_SOCK="${HOME}"/.ssh/ssh_auth_sock
}

tmssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "*tmux*" ]; then
            tmux rename-window "$(echo $* | cut -d . -f 1)"
            command ssh "$@"
    else
            command ssh "$@"
    fi
}

#!/bin/bash
# for byobu, put this file in ~/.byobu/bin
# then chmod +x
# once that's done, every 10 seconds byobu will run this script
# and rename your windows to either the local host name, or to
# the host a windows is ssh'd into

rename_windows() {
for i in $(tmux list-windows -F '#{window_index}'); do {

    panenames=$(tmux list-panes -t $i -F '#{pane_title}' | sed -e 's/:.*$//' -e 's/^.*@//' | uniq)
    panepids=$(tmux list-panes -t $i -F '#{pane_pid}' | uniq)
    panecmd=$(ps --ppid $panepids -o cmd= | grep "[s]sh")

    if [[ $panecmd = *"ssh"* ]]; then {
        windowname=$(echo $panecmd | grep "[s]sh" | cut -d @ -f 2 | sed 's/ssh//g')
    } else {
        windowname=$(echo ${panenames} | sed -e 's/ /|/g')
    }; fi
    tmux rename-window -t $i $windowname
}; done
}

# "metacode"
swap()
{
  ag -r -l "$1" | xargs -r -d'\n' sed -i "s/"${1}"/"${2}"/g"
}

qswap()
{
  ag -Q -r -l "$1" | xargs -r -d'\n' sed -i "s/"${1}"/"${2}"/g"
}

# swanson -- drink and know things
whats_good()
{
  who | cut -d ' ' -f 1 | xargs -t -I user pstree -lah user
}

# docucm
masters()
{
  tmux new-session -s devm -d -n na11_dev 'ssh master_c_1'
  tmux new-window -a -n na21_dev 'ssh master_l_1'

  tmux new-session -s labm -d -n na11_lab 'ssh master_c_2'
  tmux new-window -a -n na21_lab 'ssh master_l_2'

  tmux new-session -s qatm -d -n na11_qat 'ssh master_c_3'
  tmux new-window -a -n na21_qat 'ssh master_l_3'
  tmux new-window -a -n eu11_qat 'ssh master_s_3'
  tmux new-window -a -n eu21_qat 'ssh master_a_3'

  tmux new-session -s qarm -d -n na11_qar 'ssh master_c_4'
  tmux new-window -a -n na21_qar 'ssh master_l_4'

  tmux new-session -s uatm -d -n na11_uat 'ssh master_c_5'
  tmux new-window -a -n na21_uat 'ssh master_l_5'

  tmux new-session -s prodm -d -n na11_prod 'ssh master_c_6'
  tmux new-window -a -n na21_prod 'ssh master_l_6'
  tmux new-window -a -n eu11_prod 'ssh master_s_6'
  tmux new-window -a -n eu21_prod 'ssh master_a_6'
  tmux new-window -a -n us11_prod 'ssh master_g_6'
  tmux new-window -a -n us12_prod 'ssh master_h_6'
  tmux new-window -a -n us11dr_prod 'ssh master_g1_6'
  tmux new-window -a -n us12dr_prod 'ssh master_h1_6'

  tmux new-session -s opsm -d -n na11_ops 'ssh master_c_7'
  tmux new-window -a -n na21_ops 'ssh master_l_7'
  tmux new-window -a -n eu11_ops 'ssh master_s_7'
  tmux new-window -a -n eu21_ops 'ssh master_a_7'
  tmux new-window -a -n us11_ops 'ssh master_g_7'
  tmux new-window -a -n us11_ops 'ssh master_j_7'
  tmux new-window -a -n us12_ops 'ssh master_h_7'

  tmux new-session -s momm -d -n na11_mom 'ssh master_c_8'
  tmux new-window -a -n us1_mom 'ssh master_g_8'
  tmux new-window -a -n us1dr_mom 'ssh master_j_8'
}

na11_masters()
{
  tmux new-session -s na11 -d -n dev 'ssh master_c_1'

  tmux new-window -a -n lab 'ssh master_c_2'

  tmux new-window -a -n qat 'ssh master_c_3'

  tmux new-window -a -n qar 'ssh master_c_4'

  tmux new-window -a -n uat 'ssh master_c_5'

  tmux new-window -a -n prod 'ssh master_c_6'

  tmux new-window -a -n ops 'ssh master_c_7'

  tmux new-window -a -n mom 'ssh master_c_8'
}

na21_masters()
{
  tmux new-session -s na21 -d -n dev 'ssh master_l_1'

  tmux new-window -a -n lab 'ssh master_l_2'

  tmux new-window -a -n qat 'ssh master_l_3'

  tmux new-window -a -n qar 'ssh master_l_4'
}
#  tmux new-window -a -n uat 'ssh master_l_5'
#
#  tmux new-window -a -n prod 'ssh master_l_6'
#
#  tmux new-window -a -n ops 'ssh master_l_7'
#
#  tmux new-window -a -n mom 'ssh master_l_8'

_envFactory()
{
  echo "Pulling env:"
  echo $2
  tmux new-window -a -n p$2 -c $1/salt_environments/$2 'git pull; /usr/bin/zsh -i'
}

tmux_psrc()
{
  src_base="/home/atlas.cm.com/jbarnowski/Development/git"
  tmux new-session -s srcp -d -n src -c $src_base
  _envFactory $src_base dev
  _envFactory $src_base lab
  _envFactory $src_base qa
  _envFactory $src_base qar
  _envFactory $src_base uat
  _envFactory $src_base prod
  _envFactory $src_base ops
  _envFactory $src_base master_of_masters
}

start_work()
{
  docucry && masters && tmux_psrc
}

stop_work()
{
  pkill ssh-agent && tmux kill-server
}

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="/usr/local/sbin:$PATH"

