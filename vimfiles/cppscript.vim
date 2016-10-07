set cindent
vmap <F2> 0<c-v>I//<esc>
vmap <F3> <c-v>llx
set foldmethod=syntax
inoremap [[ <cr>{}<esc>i<cr><esc>kA<cr>
nmap gm :call search("int main")<cr>k
nmap gi :call search("#include","b")<cr>

function! s:FirstUpper(string)
    return toupper(a:string[0]).a:string[1:]
endfunction
function! Note()
    "sil! execute "normal I//"
    sil! execute "normal llx"

endfunction
function! LoadMain(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIM."/vimfiles/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
	sil! execute "%s/<FILE_NAME>/".expand("%:t")."/g"
	sil! execute "%s/<FUN_NAME>/".expand("%:t:r")."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! execute "18"
    "call TemplateReplTags()
endfunction

function! AddAnyCase()
    let l:prePos=getpos(".")
    let l:endpos=search("}.*end of")
    let l:notify=split(getline(l:endpos))
    let l:decFunLine=searchpair("{","","}","b")-1
    let l:decFunLine_1=l:decFunLine-1
    let l:decFun=getline(l:decFunLine)
    let l:decFun_1=getline(l:decFunLine_1)
    let l:isFun=index(l:notify,"function")
    echo len(l:notify)
    if l:isFun!=-1
        call FunctionDeclare(l:decFun,l:decFun_1,l:endpos)
    elseif len(l:notify)==9
        call Mutators(l:decFun,l:decFun_1,l:endpos)
    elseif match(l:notify,"operator")!=-1
        call Operators(l:decFun,l:decFun_1,l:endpos)
    else
        call LifeCycle(l:decFun,l:decFun_1,l:endpos)
    endif
endfunction

function! LifeCycle(decFun,decFun_1,endpos)
    let l:describe=split(getline(a:endpos),"  ")[3][1:-2]
    let l:head=split(a:decFun,"::")
    let l:className=l:head[0]
    let l:funName=l:head[1]
    let l:classPos=search("class ".l:className)
    let l:insertPos=search("ACCESSORS")
    call append(l:insertPos-2,"\t\t".l:funName.";\t\t/* ".l:describe." */")
endfunction

function! Mutators(decFun,decFun_1,endpos)
    let l:head=split(a:decFun,"::")
    let l:partOne=split(l:head[0])
    let l:partTwo=split(l:head[1])
    let l:className=l:partOne[-1]
    let l:funType=join(l:partOne[:-2]," ")
    let l:funName=l:funType." ".l:head[1]
    let l:describe=l:partTwo[0]." method"

    let l:classPos=search("class ".l:className)
    let l:insertPos=search("OPERATORS")
    call append(l:insertPos-2,"\t\t".l:funName.";\t\t/* ".l:describe." */")
endfunction

function! Operators(decFun,decFun_1,endpos)
    let l:head=split(a:decFun,"::")
    let l:partOne=split(l:head[0])
    let l:partTwo=split(l:head[1])
    let l:className=l:partOne[-1]
    let l:funType=join(l:partOne[:-2]," ")
    let l:funName=l:funType." ".l:head[1]
    let l:describe=l:partTwo[0][-1:-1]." ".l:partTwo[0][:-2]

    let l:classPos=search("class ".l:className)
    let l:insertPos=search("DATA MEMBERS")
    call append(l:insertPos-2,"\t\t".l:funName.";\t\t/* ".l:describe." */")
endfunction

function! InsertClassX()
    let s:classname=C_Input("CLASS NAME (-> capitalize) : ","")
    if s:classname!=""
        let l:mainPos=search("int main")-1
        "sil! exec l:mainPos."r ".$VIMFILES."/c-support/templates/class_x_implementation.cpp"
        sil! exec l:mainPos."r ".$VIMFILES."/c-support/templates/class_x_definition.cpp"
        "echo "0r ".$VIMFILES."/c-support/templates/class_x_definition.cpp"
        let l:last=line("$")-1
        echo l:last."r ".$VIMFILES."/c-support/templates/class_x_implementation.cpp"
        "
	    sil! exec "%s/<CLASSNAME>/".s:FirstUpper(s:classname)."/g"
        call search("<CU","w")
        sil! execute "normal df>"
        sil! execute "startinsert!"
    endif
endfunction

function! FunctionDeclare(decFun,decFun_1,endpos)
    let l:usingPos=search(".*int main.*")
    if a:decFun_1!="    template <class T>"
        call append(l:usingPos-2,a:decFun.";")
    else
        call append(l:usingPos-2,a:decFun_1[4:].a:decFun.";")
    endif
endfunction

function! AddAccessor()
    let s:classname=C_Input("CLASSNAME : ","")
    let s:classname=s:FirstUpper(s:classname)
    let s:attribute=C_Input("ATTRIBUTE : ","")
    call search("class ".s:classname)
    if search("class ".s:classname)==0
        echohl WarningMsg
        echo "\n".s:classname." is not exist!!"
        echohl None
    else 
        let s:endPos=search("};.*end of class")
        let s:startPos=search("DATA MEMBERS")
        let s:exist=search(".* ".s:attribute.";","",s:endPos)
        let s:attName=getline(s:exist)
        if s:exist!=0
            let s:attType=join(split(s:attName)[:-2]," ")
            call search("MUTATORS","b")
            call append(line(".")-2,"\t\t".s:attType." get".s:FirstUpper(s:attribute)."() { return ".s:attribute."; };\t\t/* get assessor of ".s:attribute." */")
            call append(line(".")-2,"\t\tint set".s:FirstUpper(s:attribute)."(".s:attType." value) { this->".s:attribute."=value; return 0; };\t\t/* set assessor of ".s:attribute." */")
        else
            echohl WarningMsg
            echo "\n".s:attribute." is not exist!!"
            echohl None
        endif
    endif
endfunction

function! LinkRun()
    call delete(expand("%:r").".exe")
    set makeprg=g++\ -std=c++0x\ -Wall\ *.cpp\ -o\ %:r
    make
    if	executable(expand("%:r").".exe")
        if s:MSWIN
                exec "!\"".expand("%:r")."\""
			else
				exec "!".expand("%:r")
			endif
	else
		echomsg "file ".expand("%:r")." does not exist / is not executable"
        cw
	endif
endfunction
function! AutoFill()
    if line("$")==1
        call LoadMain("cpp_main.template")
    endif
endfunction

"autocmd FileType c inoremap <C-i> :call LoadMain("main.c")<cr>
"nmap <C-i> :call LoadMain("main.c")<cr>
call AutoFill()
nmap <C-i> :call AutoFill()<cr>
 noremap <F10> :call LinkRun()<cr>
inoremap <F10> :call LinkRun()<cr>
" noremap    <buffer>  <silent>  <LocalLeader>if         :call C_InsertTemplate("idioms.function")<CR>
"vnoremap    <buffer>  <silent>  <LocalLeader>if    <Esc>:call C_InsertTemplate("idioms.function", "v")<CR>
inoremap    <buffer>  <silent>  <LocalLeader>if     <Esc>:call C_InsertTemplate("idioms.function")<CR>
 noremap    <buffer>  <silent>  <LocalLeader>xi         :call InsertClassX()<CR>
inoremap    <buffer>  <silent>  <LocalLeader>xi    <Esc>:call InsertClassX()<CR>
 noremap    <buffer>  <silent>  <LocalLeader>ai    <Esc>:call AddAccessor()<CR>
inoremap    <buffer>  <silent>  <LocalLeader>ai         :call AddAccessor()<CR>
 noremap    <buffer>  <silent>  <LocalLeader>add         :call AddAnyCase()<CR>
inoremap    <buffer>  <silent>  <LocalLeader>add    <Esc>:call AddAnyCase()<CR>
" call SingleCompile#ChooseCompiler('cpp', 'g++')
