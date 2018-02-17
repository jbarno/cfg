alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore
git clone --bare git@github.com:jbarno/cfg.git $HOME/.cfg
config status
config checkout
config status
config submodule status
config submodule init
config submodule update
config status
config config --local status.showUntrackedFiles no
