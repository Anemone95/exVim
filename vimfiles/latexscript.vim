" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" nmap <F9> :call Tex_CompileLatex()<CR>

nmap <F10> :call Tex_ViewLaTeX()<CR>
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
filetype indent on
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" imap <c-k> <F7>
nmap <c-j> <c-w>j
let g:Tex_SmartKeyBS=0

inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"

nmap <Leader>fa :%s/\./。/gc<cr>
nmap <Leader>fb :%s/,/，/gc<cr>
" :%s/,/，/gc


call SingleCompile#SetCompilerTemplate('tex', 'xelatex', 'XeLatex',
            \ 'xelatex', '-interaction=nonstopmode -synctex=1 -file-line-error-style',
            \ SingleCompile#GetDefaultOpenCommand() .
            \ ' "$(FILE_TITLE)$.pdf"')
" call SingleCompile#SetOutfile('filetype', 'compiler', 'out_file')
call SingleCompile#ChooseCompiler('tex', 'xelatex')
nmap <F9> :SCCompile<cr>
imap <F9> :SCCompile<cr>
set list lcs=tab:\¦\
let g:neosnippet#snippets_directory='$VIM/vimfiles/latexsnip'
