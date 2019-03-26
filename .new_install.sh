alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare --depth 1 https://github.com/jbarno/cfg.git $HOME/.cfg
config reset HEAD --hard
config submodule update --init --recursive
config config --local status.showUntrackedFiles no
