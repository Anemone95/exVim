function! LoadTemplate(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".g:VIMFILES_PATH."/".a:filename
    sil! exec "%s/<FILE_NAME>/".expand("%:t")."/g"
    sil! exec "%s/<FUN_NAME>/".expand("%:t:r")."/g"
    sil! exec "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! exec "15"
endfunction
if line("$")==1
    call LoadTemplate("py_main.template")
endif

func! FoldIndent() abort
    let indent = indent(v:lnum)/&sw
    let indent_next = indent(nextnonblank(v:lnum+1))/&sw
    if indent_next > indent && getline(v:lnum) !~ '^\s*$'
        return ">" . (indent+1)
    elseif indent != 0
        return indent
    else 
        return -1
    endif
endfunc
setlocal foldexpr=FoldIndent()
setlocal foldmethod=expr
