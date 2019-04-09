#!/bin/bash
# https://github.com/Valloric/YouCompleteMe#full-installation-guide
set -e
mkdir $HOME/.ycm_build
cd $HOME/.ycm_build
cmake -G "Unix Makefiles" . $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core
