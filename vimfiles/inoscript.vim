python << EOF

# import time
# import threading
# import win32api
# import win32con

# def startCompile():
#     time.sleep(2.0)
#     win32api.keybd_event(17,0,0,0)
#     win32api.keybd_event(16,0,0,0)
#     win32api.keybd_event(77,0,0,0)
#     win32api.keybd_event(77,0,win32con.KEYEVENTF_KEYUP,0)
#     win32api.keybd_event(16,0,win32con.KEYEVENTF_KEYUP,0)
#     win32api.keybd_event(17,0,win32con.KEYEVENTF_KEYUP,0)
#
#
#     win32api.keybd_event(18,0,0,0)
#     win32api.keybd_event(9,0,0,0)
#     win32api.keybd_event(9,0,win32con.KEYEVENTF_KEYUP,0)
#     win32api.keybd_event(18,0,win32con.KEYEVENTF_KEYUP,0)
#
#     win32api.keybd_event(17,0,0,0)
#     win32api.keybd_event(85,0,0,0)
#     win32api.keybd_event(85,0,win32con.KEYEVENTF_KEYUP,0)
#     win32api.keybd_event(17,0,win32con.KEYEVENTF_KEYUP,0)
EOF

function! Compile()
    let file=getcwd().'/'.getreg('%')
    py t1=threading.Thread(target=startCompile,args=())
    py t1.start()
    exec "!arduino \"".file."\""
endfunction

function! LoadMain(filename)
    "let s:test=input("Please input:")
    exec "0r ".$VIM."/vimfiles/".a:filename
    """echo "0r ".$VIMFILES."/py-support/".a:filename
	sil! execute "%s/<FILE_NAME>/".expand("%:t")."/g"
    sil! execute "%s/<FUN_NAME>/".expand("%:t:r")."/g"
	sil! execute "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    sil! execute "10"
endfunction

nmap <C-i>   :call LoadTemplate("main.ino")<CR>
" noremap <F9> :w<cr>:call Compile()<CR>

if line("$")==1
    call LoadMain("ino_main.template")
endif
