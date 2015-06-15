" Bootstrap Vundle {{{
" vim --startuptime log.log FILENAME.md
" to troubleshoot

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'beloglazov/vim-online-thesaurus'
Bundle 'bling/vim-airline'
Bundle 'bling/vim-bufferline'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
" Bundle 'ivanov/vim-ipython'
Bundle 'justinmk/vim-sneak'
Bundle 'kshenoy/vim-signature'
Bundle 'nelstrom/vim-markdown-folding'
" Bundle 'reedes/vim-wordy'
Bundle 'reedes/vim-pencil'
Bundle 'terryma/vim-smooth-scroll'
" Bundle 'tpope/vim-commentary'
" Bundle 'tpope/vim-eunuch'
" Bundle 'tpope/vim-obsession'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-vinegar'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'vitalk/vim-simple-todo'

" filetype is causing 1000ms+ lag on startup
" filetype plugin indent off
if has("autocmd")
  filetype plugin indent on
endif

syntax on

" }}}
" Sets and lets {{{

set autowrite                   " Automatically save before commands like :next and :make
set background=dark             " for syntax highlight in dark backgrounds
" set breakindent               " http://article.gmane.org/gmane.editors.vim.devel/46204
" set showbreak=\.\.\.
set backspace=indent,eol,start  " backspace over everything
set clipboard=unnamedplus       " Better copy & paste, needs v. 7.3.74+
set columns=80                  " How many columns to display. Works with textwidth to produce right margin.
set dictionary+=/usr/share/dict/words
set display=lastline            " Prevent @ symbols for lines that dont fit on the scren
set encoding=utf-8
set expandtab
set foldcolumn=2                " Add a left margin
set foldlevelstart=0            " Start with folds closed
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
" the interplay between columns and textwidth produces the right margin
set textwidth=79                " Auto text wrapping width, 0 to disable. 78 seems to be the default
set ttimeout                    " Time out on key codes but not mappings.
set ttimeoutlen=10              " Related to ttimeout and notimeout
set ttyfast                     " better screen update
set undolevels=700
set wrapmargin=0
set wildmenu                    " Fancy autocomplete after :
set wildmode=longest:full,full

" disabled because too many files
" persistent undo
" if exists("&undodir")
"     set undofile
"     let &undodir=&directory
"     set undolevels=500
"     set undoreload=500
" endif

" }}}
" Custom Functions {{{

" Display word count on lower right
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
function! WordCount()
    let s:old_status = v:statusmsg
    let position = getpos(".")
    exe ":silent normal g\<c-g>"
    let stat = v:statusmsg
    let s:word_count = 0
    if stat != '--No lines in buffer--'
        let s:word_count = str2nr(split(v:statusmsg)[11])
        let v:statusmsg = s:old_status
    endif
    call setpos('.', position)
    return s:word_count
endfunction

set foldtext=CustomFoldText()

" better fold text
" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
fu! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile

    if fs > v:foldend
        let line = getline(v:foldstart)
        else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

" evoke these with :call
function! SoftWrap()
    let s:old_fo = &formatoptions
    let s:old_tw = &textwidth
    set fo=
    set tw=999999 " works for paragraphs up to 12k lines
    normal gggqG
    let &fo = s:old_fo
    let &tw = s:old_tw
endfunction

command! Prose call Prose()
" command! Preview :!chromium-browser %<CR>
" command! prose setlocal linebreak nolist wrap wrapmargin=0
command! Code execute "so ~/.vimrc"
function! Prose()

    " autocmd VimResized * if (&columns > 85) | set columns=85 | endif

    " the following automates hardwrap
    " autocmd InsertEnter * set formatoptions+=a
    " autocmd InsertLeave * set formatoptions-=a

    " set columns=80
    setlocal foldcolumn=8
    " that one needs to be in .vim/after/ftpplugin
    " set formatoptions+=tc
    " setlocal linebreak
    "setlocal nolist
    "setlocal nonumber
    "set showbreak="+++"
    setlocal textwidth=79
    "setlocal wrap
    " that one needs to be in .vim/after/ftpplugin
    " set formatoptions+=tc
    "setlocal wrapmargin=0

    " this has to happen after columns are set

    " better navigation for softwrap
    "nnoremap k gk
    "nnoremap j gj
    "nnoremap gk k
    "nnoremap gj j
    "nnoremap 0 g0
    "nnoremap $ g$
    "nnoremap g0 0
    "nnoremap g$ $
    "nnoremap <Space> call SoftWrap()

endfunction END

" }}}
" File types and auto commands {{{

" Force markdown for .md
autocmd BufRead,BufNew *.md set filetype=markdown
autocmd BufRead,BufNew *.md call Prose()

" Spell-check by default for markdown
" autocmd BufRead,BufNewFile *.md setlocal spell
" autocmd FileType markdown set foldmethod=syntax
" autocmd BufRead,BufNew *.md set syntax=OFF

" Set foldmethod to marker for .vimrc
autocmd BufRead,BufNew *.vimrc set foldmethod=marker

" detect YAML front matter for .md
" from wikimatze https://github.com/nelstrom/vim-markdown-folding/issues/3
" not working for now
" autocmd BufRead,BufNewFile *.md syntax match Comment /\%^---\_.\{-}---$/

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

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" a mix between syntax and marker folding
" augroup vimrc
"     au BufReadPre * setlocal foldmethod=syntax
"     au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=marker | endif
" augroup END

" Save fold state
" *.* is better than using just *
" when Vim loads it defaults to [No File], which triggers the BufWinEnter,
" and since there is no file name, an error occurs as it tries to execute.
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" place a dummy sign to make sure sign column is always displayed
" otherwise markers work funny
" the autocmd ensures this works for all new buffers
" sign define dummy
" execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" }}}
" Maps and remaps {{{

" F1 is annoying, map to esc
map <F1> <Esc>
imap <F1> <Esc>

nnoremap <F3> :OnlineThesaurusCurrentWord<CR>
nnoremap <F4> :setlocal spell! spelllang=en_us<CR>
" nnoremap <F5> :Prose<CR>
" nnoremap <F6> :Code<CR>

" Along with pastetoggle and set showmode allows visible toggle for paste
nnoremap <F7> :set invpaste paste?<CR>`

" save session along with buffers and windows
nnoremap <F8> :mksession! .quicksave.vim<CR>
nnoremap <F9> :source .quicksave.vim<CR>

" check syntax group at cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" Buffer toggle
nnoremap  <silent> <S-Tab> :bnext<CR>

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

" hard wrap makes collaboration more difficult
" attempting to switch back to soft wrap
" remap space to reflow hard wrapped paragraph
nnoremap <Space> gwip

" Smooth scrolling remaps
" (distance, duration, speed)
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 40, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 40, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 40, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 40, 4)<CR>

" }}}
" Leader bindings {{{

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
" Colors and Gutters {{{

highlight! link FoldColumn Normal
hi NonText ctermfg=DarkBlue
hi FoldColumn ctermbg=Black ctermfg=Black
hi SignColumn ctermbg=Black
hi Folded ctermbg=Black
highlight LineNr ctermfg=DarkGrey

" Spell check colors
if version >= 700
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellRare
    hi clear SpellLocal
    hi SpellBad ctermfg=red cterm=underline
    hi SpellCap ctermfg=3 cterm=underline
    hi SpellRare ctermfg=13 cterm=underline
    hi SpellLocal  cterm=None
endif

" }}}
" Plugin specific stuff {{{

" Markdown folding
let g:markdown_fold_style = 'nested'
let g:markdown_fold_override_foldtext = 0

" Speedup the Pandoc Bundle plugin
let g:pandoc_no_folding = 1
let g:pandoc_no_spans = 1
let g:pandoc_no_empty_implicits = 1
" Least viable modules to get biblio to work. Dont need anything else.
" this plugin is bloated.
let g:pandoc#modules#enabled = ["bibliographies", "completion", "command"]

" Airline / Powerline
let g:airline_theme = 'simple'
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline_detect_modified = 0
let g:bufferline_show_bufnr = 0
" Display wordcount in the section of airline
let g:airline_section_z = '%p%% %{WordCount()} words'

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
" let g:livedown_open = 1

" the port on which Livedown server will run
" let g:livedown_port = 8080
" map gm :call LivedownPreview()<CR>

" }}}
