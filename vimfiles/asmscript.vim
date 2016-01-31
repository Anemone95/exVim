let g:syntastic_asm_checkers = [ 'masm' ]
function! Compile()
    " exec "!ml %"
    let l:filename=expand("%:p")
python <<EOF
import vim
import os

fileName=vim.eval("l:filename")
fileName=fileName.split("\\")

str_="""cd {2}
ml {0}
{1}
""".format(fileName[-1],fileName[-1][:-4],fileName[-2])
file_=open(r"D:\Store\document\all_my_work\assembly\8086\masm\compile.bat",'w')
file_.write(str_)
file_.close()
os.system(r"C:\DOSBox.lnk")

EOF
endfunction

" call SingleCompile#SetCompilerTemplate('asm', 'ml', 'ml', 'ml', '$(FILE_NAME)$', '')
" call SingleCompile#SetOutfile('asm', 'ml', '$(FILE_TITLE)$.exe')
" call SingleCompile#ChooseCompiler('asm', 'ml')

function! LoadTemplate(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIMFILES."/asm-support/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
    sil! execute "%s/<FILENAME>/".expand("%")."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
	"sil! execute "%s/<DATE>/"."hello"."/g"
    call search("<CU","W")
    sil! execute "normal df>"
    sil! execute "startinsert!"
    "call TemplateReplTags()
endfunction

nmap <C-i>   :call LoadTemplate("main.asm")<CR>
noremap <F9> :w<cr>:call Compile()<CR>

if line("$")==1
    call LoadTemplate("main.asm")
endif
