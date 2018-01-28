set nocompatible      " required
filetype off          " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
" Plugin 'vim-scripts/indentpython.vim'
Plugin 'Bundle'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'                                                              
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



" tabbing
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" search
set hlsearch          " highlight search
set ignorecase 	      " case-insensitive matching w/ search
set incsearch         " incremental highlighting in search
set smartcase         " case-sensitive w/ capital letter
let g:ackprg = 'ag --nogroup --nocolor --column'

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
" nnoremap <space> za

" Flagging Unnecessary Whitespace
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

" python syntax highlighting
let python_highlight_all=1
syntax on

" Line Numbering
set nu

set clipboard=unnamed

"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" NERDTree Automatic Open with No File Specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" More powerful backspace
:set backspace=indent,eol,start

" Enable Solorized Theme
syntax enable
set background=dark
" colorscheme solarized



