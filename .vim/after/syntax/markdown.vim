" If you are mostly satisfied with an existing syntax file, but would like to
" add a few items or change the highlighting, follow these steps:
" 1. Create your user directory from 'runtimepath', see above.
" 2. Create a directory in there called "after/syntax".  For Unix:
"     mkdir ~/.vim/after
"     mkdir ~/.vim/after/syntax
" 3. Write a Vim script that contains the commands you want to use.  For
"    example, to change the colors for the C syntax:
"     highlight cComment ctermfg=Green guifg=Green
" 4. Write that file in the "after/syntax" directory.  Use the name of the
"    syntax, with ".vim" added.  For our C syntax:
"     :w ~/.vim/after/syntax/c.vim
"
" Some possible groups:
" :help group-name for more
" Comment     | Comments within a program
" Constant    | Program constants, such as numbers, quoted strings, or true/false
" Identifier  | Variable identifier names
" Statement   | A programming language statement, usually a keyword like "if" or "while"
" PreProc     | A preprocessor, such as "#include" in C
" Type        | A variable datatype, such as "int"
" Special     | A special symbol, usually used for special characters like "\n" in strings
" Underlined  | Text that should be underlined
" Error       | Text which contains a programming language error

" Possible keys and values
" term,cterm, gui     | bold, underline, reverse, italic, none
" ctermfg, ctermbg    | red, yellow, green, blue, magenta, cyan, white, black, gray
" guifg, guibg        | full #rrggbb support

" Usage: hightlight Group key=value
highlight Comment ctermfg=white
highlight Constant ctermfg=white
highlight Identifier ctermfg=white
" this covers gutter markers
highlight Statement ctermfg=yellow
highlight Preproc ctermfg=white
highlight Type ctermfg=white
highlight Special ctermfg=white
highlight Underlined ctermfg=white
highlight Error ctermfg=white
" covers H1-4
highlight Title ctermfg=white
