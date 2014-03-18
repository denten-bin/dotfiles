" --- Bootstrap ---
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
set foldcolumn=8        " Add a left margin
set foldmethod=indent   " Handles code folding.
set foldlevel=99        " Handles code folding.
set formatoptions=co    " Not sure if working
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
set splitbelow          " Better split defaults
set splitright
set softtabstop=4
set t_Co=256            " set mode to 256 colors
set tabstop=4
set textwidth=0         " Disable auto text wrapping
set undolevels=700
set wildmenu            " Fancy autocomplete after :
set wildmode=longest:full,full


" --- Extension Specific
" Disable default online-thesaurus keys
let g:online_thesaurus_map_keys = 0

" Spell-check by default for markdown
" autocmd BufRead,BufNewFile *.md setlocal spell

" --- Format Options ---
" c= auto-wrap comments to text width
" r= insert comment leader after enter
" o= insert comment leader with 'o'
" use :set formatoptions? to check current defaults
" unset separately, one at a time as done here
" :help fo-table for more infos

au FileType * setlocal formatoptions-=c formatoptions-=o


" --- Commands ---
command! Prose setlocal linebreak nolist syntax=off wrap wrapmargin=0
command! Code execute "so ~/.vimrc"
command! Preview :!chromium-browser %<CR>


" --- Custom keybinds ---
" F1 is annoying, map to esc
map <F1> <Esc>
imap <F1> <Esc>

" map <F2> :NERDTreeToggle<CR>
map <F3> :OnlineThesaurusCurrentWord<CR>
map <F4> :setlocal spell! spelllang=en_us<CR>
map <F5> :Prose<CR>
map <F6> :Code<CR>

" Along with pastetoggle and set showmode allows visible toggle for paste
nnoremap <F7> :set invpaste paste?<CR>`
map <F8> :Preview<CR>

" Buffer toggle
nnoremap  <silent> <S-Tab> :bnext<CR>

" kj by line for softwrapped files
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Insert python breakpoints
map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
map <silent> <leader>B Oimport pdb; pdb.set_trace()<esc>

" in case you forgot to sudo
cmap w!! %!sudo tee > /dev/null %

" --- Colors ---
highlight! link FoldColumn Normal
highlight NonText ctermfg=DarkBlue


" --- Plugin specific stuff ---
" Calendar
" let g:calendar_google_calendar = 1
" let g:calendar_google_task = 1
" let g:calendar_frame = 'unicode'

" Speedup the Pandoc Bundle plugin
let g:pandoc_no_folding = 1
let g:pandoc_no_spans = 1
let g:pandoc_no_empty_implicits = 1

" Airline / Powerline
" auto display all buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

" Custom surrounds for Markdown
let g:surround_98 = "**\r**"

" Easymotion
let g:EasyMotion_mapping_f = 'f'
