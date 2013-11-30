" --- General ---
" Orders matters here. Nocomp has to go before pathogen.

set nocompatible
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

" --- Sets ---

set autowrite           " Automatically save before commands like :next and :make
set background=dark     " for syntax highlight in dark backgrounds
set bs=2                " This influences the behavior of the backspace option.
set clipboard=unnamed   " Better copy & paste
set display=lastline    " Prvent @ symbols for lines that dont fit on the screen
set expandtab

set foldcolumn=8        " Add a left margin and make sure its the right color
highlight! link FoldColumn Normal

set foldmethod=indent   " Handles code folding.
set foldlevel=99        " Handles code folding.
set formatoptions=c     " c to autowrap remove the default to repeat comment leader after enter
set hidden              " Hide buffers when they are abandoned
set history=700
set hlsearch            " Highlight all on search
set ignorecase          " Do case insensitive matching
set incsearch           " Incremental search
set laststatus=2        " Needed for powerline / airline eye candy
set list                " Place a discreet snowman in the trailing whitespace
set listchars=tab:→\ ,trail:☃
set modeline            " Disabled by default in Ubuntu. Needed for some options.
set mouse=a             " Enable mouse usage (all modes)
let loaded_matchparen = 1   " disable matching [{(
set nowrap
set pastetoggle=<F7>
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set ruler               " This makes vim show the current row and column at the bottom right of the screen.
set shiftwidth=4
set showcmd             " Show (partial) command in status line.
set showmode
set smartcase           " Do smart case matching.
set softtabstop=4
set t_Co=256            " set mode to 256 colors
set tabstop=4
set textwidth=0         " Disable auto text wrapping
set undolevels=700


" --- Toggle between :Code and :Prose ---

command! Prose setlocal linebreak nolist syntax=off wrap wrapmargin=0
command! Code execute "so ~/.vimrc"


" --- Custom keybinds ---

" F1 is annoying, map to esc
map <F1> <Esc>
imap <F1> <Esc>
map <F2> :NERDTreeToggle<CR>
map <F3> :GundoToggle<CR>
map <F4> :setlocal spell! spelllang=en_us<CR>
map <F5> :Prose<CR>
map <F6> :Code<CR>
" Along with pastetoggle and set showmode allows visible toggle for paste
nnoremap <F7> :set invpaste paste?<CR>


" Buffer toggle
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
