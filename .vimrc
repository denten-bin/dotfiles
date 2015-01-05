" Bootstrap Vundle ------------------------------------------------------------------ {{{

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Bundle 'altercation/vim-colors-solarized'
Bundle 'beloglazov/vim-online-thesaurus'
Bundle 'bling/vim-airline'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
" Bundle 'ironcamel/vimchat'
" Bundle 'ivanov/vim-ipython'
" Bundle 'junegunn/vim-easy-align'
Bundle 'justinmk/vim-sneak'
" Bundle 'mattn/emmet-vim'
Bundle 'nelstrom/vim-markdown-folding'
" Bundle 'plasticboy/vim-markdown'
" Bundle 'shime/vim-livedown'
" Bundle 'reedes/vim-pencil'
Bundle 'reedes/vim-wordy'
" Bundle 'suan/vim-instant-markdown'
Bundle 'terryma/vim-smooth-scroll'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-eunuch'
" Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
" Bundle 'tpope/vim-tbone'
Bundle 'tpope/vim-vinegar'
" Bundle 'vim-pandoc/vim-pandoc'
" Bundle 'vim-pandoc/vim-pandoc-syntax'
" Bundle 'terryma/vim-expand-region'
" syntax range needed for vimdeck
Bundle 'vim-scripts/SyntaxRange'
" Bundle 'xolox/vim-session'
" Bundle 'xolox/vim-misc'

filetype plugin indent on
syntax on
syntax enable

" }}}
" Sets and lets ----------------------------------------------------------------------------- {{{

set autowrite                   " Automatically save before commands like :next and :make
set background=dark             " for syntax highlight in dark backgrounds
" set breakindent                 " http://article.gmane.org/gmane.editors.vim.devel/46204
" set showbreak=\.\.\.
set bs=2                        " This influences the behavior of the backspace option.
set clipboard=unnamed           " Better copy & paste
set dictionary+=/usr/share/dict/words
set display=lastline            " Prvent @ symbols for lines that dont fit on the screen
set expandtab
set foldcolumn=8                " Add a left margin
set foldlevelstart=1            " Start with first-level folds open, fold state saves in au section
set foldlevel=99                " Handles code folding.
set hidden                      " Hide buffers when they are abandoned
set history=700
set hlsearch                    " Highlight all on search
set ignorecase                  " Do case insensitive matching
set incsearch                   " Incremental search
set laststatus=2                " Needed for powerline / airline eye candy
set list                        " Place a discreet snowman in the trailing whitespace
set listchars=tab:→\ ,trail:☃
set modeline                    " Disabled by default in Ubuntu. Needed for some options.
set mouse=a                     " Enable mouse usage (all modes)
let loaded_matchparen = 1       " disable matching [{(
set notimeout                   " Time out on key codes but not mappings.
set nowrap                      " disable soft-wrap
set pastetoggle=<F7>
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set ruler                       " This makes vim show the current row and column at the bottom right of the screen.
set scrolloff=9                 " determines #of context lines visible above and below the cursor
set shiftwidth=4
set showcmd                     " Show (partial) command in status line.
set showmode
set smartcase                   " Do smart case matching.
set splitbelow                  " Better split defaults
set splitright
set softtabstop=4
set synmaxcol=800               " Don't try to highlight lines longer than 800 characters.
set t_Co=256                    " set mode to 256 colors
set tabstop=4
set textwidth=79                " Auto text wrapping width, 0 to disable, 0 default
set ttimeout                    " Time out on key codes but not mappings.
set ttimeoutlen=10              " Related to ttimeout and notimeout
set undolevels=700
set wildmenu                    " Fancy autocomplete after :
set wildmode=longest:full,full

" }}}
" Commands and auto commands ------------------------------------------------------------ {{{

" Spell-check by default for markdown
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.md syntax off

" detect YAML front matter for .md
" from wikimatze https://github.com/nelstrom/vim-markdown-folding/issues/3
" not working for now
" autocmd BufRead,BufNewFile *.md syntax match Comment /\%^---\_.\{-}---$/

" Force markdown for .md
" autocmd BufRead,BufNew *.md set filetype=markdown

" Save when losing focus
au FocusLost * :silent! wall

" --- Format Options ---
" :help fo-table
" c= auto-wrap comments to text width
" a= auto-wrap paragraphs
" r= insert comment leader after enter
" o= insert comment leader with 'o'
" use :set formatoptions? to check current defaults
" unset separately, one at a time as done here
" :help fo-table for more infos
au FileType * setlocal formatoptions-=c fo-=o fo+=t fo-=a

" command! Prose setlocal linebreak nolist syntax=off wrap wrapmargin=0
" command! Preview :!chromium-browser %<CR>
" command! Prose setlocal linebreak nolist wrap wrapmargin=0
" command! Code execute "so ~/.vimrc"

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" a mix between syntax and marker folding
augroup vimrc
  au BufReadPre * setlocal foldmethod=syntax
  au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=marker | endif
augroup END

" Save fold state
" *.* is better than using just *
" when Vim loads it defaults to [No File], which triggers the BufWinEnter,
" and since there is no file name, an error occurs as it tries to execute.
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" }}}
" Maps and remaps --------------------------------------------------------- {{{

" F1 is annoying, map to esc
map <F1> <Esc>
imap <F1> <Esc>

nnoremap <F3> :OnlineThesaurusCurrentWord<CR>
nnoremap <F4> :setlocal spell! spelllang=en_us<CR>
nnoremap <F5> :FoldToggle<CR>
" nnoremap <F5> :Prose<CR>
" nnoremap <F6> :Code<CR>

" Along with pastetoggle and set showmode allows visible toggle for paste
nnoremap <F7> :set invpaste paste?<CR>`
map <F8> :Preview<CR>

" Buffer toggle
nnoremap  <silent> <S-Tab> :bnext<CR>

" kj by line for softwrapped files
" nnoremap k gk
" nnoremap j gj
" nnoremap gk k
" nnoremap gj j

" simpler folds
" zo opens all folds
" zc closes all folds
" za to toggle each fold
nnoremap zo zR
nnoremap zc zM

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" in case you forgot to sudo
cmap w!! %!sudo tee > /dev/null %

" faster colon
nnoremap ; :
nnoremap : ;

" remap zG to add the current word to a file called oneoff.utf-8.add
" vanilla zG is temporary and does not write to a file
nnoremap zG 2zg

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

" Keep search matches in the middle of the window. Brilliant!
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.


" }}}
" Leader bindings --------------------------------------------------------- {{{

" Open a quickfix window for the last search
nnoremap <silent> <leader>f :execute 'vimgrep /'.@/."/g %"<CR>:copen<CR>

" quickfix window
nnoremap <silent> <leader>n :cn<CR>
nnoremap <silent> <leader>p :cN<CR>
nnoremap <silent> <leader>d :ccl<CR>

" Insert python breakpoints
map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>


" }}}
" Colors --- {{{

highlight! link FoldColumn Normal
hi NonText ctermfg=DarkBlue
hi FoldColumn ctermbg=Black ctermfg=Black

" Spell check colors 
if version >= 700
  hi clear SpellBad
  hi clear SpellCap
  hi clear SpellRare
  hi clear SpellLocal
  hi SpellBad ctermfg=9 cterm=underline
  hi SpellCap ctermfg=3 cterm=underline
  hi SpellRare ctermfg=13 cterm=underline
  hi SpellLocal  cterm=None
endif

" }}}
" Plugin specific stuff --------------------------------------------------------- {{{

" Markdown folding
let g:markdown_fold_style = 'nested'

" Speedup the Pandoc Bundle plugin
let g:pandoc_no_folding = 1
let g:pandoc_no_spans = 1
let g:pandoc_no_empty_implicits = 1

" Airline / Powerline
" auto display all buffers
" let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

" Custom surrounds for Markdown
let g:surround_98 = "**\r**"

" Disable default online-thesaurus keys
let g:online_thesaurus_map_keys = 0

" Sneak
" replace f/F with sneak
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S

let g:sneak#streak = 1

" Vimdown
" should the browser window pop-up upon starting Livedown
let g:livedown_open = 1

" the port on which Livedown server will run
let g:livedown_port = 8080
map gm :call LivedownPreview()<CR>
