map <c-]> :call jedi#goto_assignments()<CR>
vmap <Tab> <c-v>I<Tab><Esc>
vmap = <Esc>:!autopep8 --in-place --aggressive --aggressive %<CR>
" nmap <C-i> :call LoadTemplate("main.py")<CR>
imap <expr><c-n> pumvisible()?"\<c-n>":"\<Tab>"
function! LoadTemplate(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIM."/vimfiles/".a:filename
    sil! exec "%s/<FILE_NAME>/".expand("%:t")."/g"
    sil! exec "%s/<FUN_NAME>/".expand("%:t:r")."/g"
    sil! exec "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! exec "15"
endfunction
if line("$")==1
    call LoadTemplate("py_main.template")
endif
if match( getline(1),"django" )!=-1||match(getline(3),"django")!=-1
    set ft=python.django " For SnipMate
    map <F9> :Dmanage runserver<cr>
endif
if match( getline(10),"scrapy" )!=-1||match(getline(6),"scrapy")!=-1
    map <F9> :!python main.py<cr>
endif

set fileformat=unix
