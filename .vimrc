" Bootstrap Vundle {{{
" vim --startuptime log.log FILENAME.md
" to troubleshoot

set nocompatible
filetype off
" set rtp+=~/.vim/bundle/Vundle.vim/
set rtp+=/home/denten/.vim/bundle/Vundle.vim/
call vundle#rc()
Plugin 'beloglazov/vim-online-thesaurus'
" Plugin 'bling/vim-airline'
" Plugin 'bling/vim-bufferline'
Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular'
" Plugin 'ivanov/vim-ipython'
Plugin 'junegunn/goyo.vim'
" sneak is the lightweight alternative to easymotion
Plugin 'justinmk/vim-sneak'
Plugin 'kien/ctrlp.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'nelstrom/vim-markdown-folding'
" Plugin 'reedes/vim-pencil'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-pandoc/vim-pandoc'

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
set confirm                     " safer file override
set nocursorcolumn              " this is the default, but good to know
set nocursorline                " this is the default, but good to know
set dictionary+=/usr/share/dict/words
set display=lastline            " Prevent @ symbols for lines that dont fit on the scren
set encoding=utf-8              " force utf encoding
set expandtab                   " expand tabs to spaces
set foldcolumn=2                " Add a left margin
set foldlevelstart=0            " Start with folds closed
set foldlevel=99                " Handles code folding
set hidden                      " Hide buffers when they are abandoned
set history=700                 " length of history
set hlsearch                    " Highlight all on search
set ignorecase                  " Do case insensitive matching
set incsearch                   " Incremental search
set laststatus=0                " 0 to disable power bar, 2 for powerline
set list                        " Place a discreet snowman in the trailing whitespace
set listchars=tab:→\ ,trail:☃
set modeline                    " Disabled by default in Ubuntu. Needed for some options.
set mouse=a                     " Enable mouse usage (all modes)
let loaded_matchparen = 1       " disable matching [{(
set notimeout                   " Time out on key codes but not mappings.
set nowrap                      " disable soft-wrap
set pastetoggle=<F7>
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set regexpengine=2              " use 7.4+ NFA regex for better performance
set ruler                       " This makes vim show the current row and column at the bottom right of the screen.
set scrolloff=9                 " determines #of context lines visible above and below the cursor
set shiftwidth=4                " sets the tabwidth
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

" }}}
" Custom Functions {{{

" Display word count on lower right
" http://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
" not using currently
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

" Create Code and Prose modes
command! Prose call Prose()
command! Code execute "so ~/.vimrc"

function! Prose()

   set foldcolumn=0
   set formatoptions=l                         " needed for softwrap
   set linebreak textwidth=0 wrapmargin=0      " softwrap mode
   set list
   set listchars=eol:¬
   set numberwidth=6
   set wrap

    " use unix par to format paragraphs
    " works better than the built in one
    setlocal formatprg=par

    "setlocal wrap
    " that one needs to be in .vim/after/ftpplugin
    " set formatoptions+=tc
    "setlocal wrapmargin=0

    " this has to happen after columns are set

    " better navigation for softwrap
    nnoremap k gk
    nnoremap j gj
    nnoremap gk k
    nnoremap gj j
    nnoremap 0 g0
    nnoremap $ g$
    nnoremap g0 0
    nnoremap g$ $
    " join hard wraps
    nnoremap <Space> vipJ

endfunction END

" }}}
" File types and auto commands {{{

" Force markdown for .md
autocmd BufRead,BufNew *.md set filetype=pandoc
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
" Custom keybindings {{{

" F1 is annoying, map to esc
" ZQ is dangerous, quits without saving

nnoremap <F1> <Esc>
nnoremap ZQ <nop>

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

" move to the end of the fold
nmap z] zo]z
nmap z[ zo[z

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" hard wrap makes collaboration more difficult
" attempting to switch back to soft wrap
" remap space to reflow hard wrapped paragraph
" this is remapped in Prose mode
nnoremap <Space> gwip

" Smooth scrolling remaps
" (distance, duration, speed)
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 40, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 40, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 40, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 40, 4)<CR>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

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
hi SignColumn ctermbg=Black ctermfg=Yellow
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

" }}}
