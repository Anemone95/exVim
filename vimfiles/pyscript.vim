" noremap    <buffer>  <silent>  <LocalLeader>rr         :w<enter>:!python %<enter>
 " map  <buffer>  <silent>  <F9>       :w<CR>:!python %<CR>
" imap  <buffer>  <silent>  <F9>  <C-C>:w<CR>:!python %<CR>
"map <C-i> ggO#!/usr/bin/env python<CR>#coding=utf-8<CR>#Edit by Anemone at :<cr><esc>I#<esc>o#E-mail:x565178035@126.com<esc>oif __name__ == '__main__':<cr>main(<esc>2kodef main(<esc>la:<cr>
"autocmd BufNewFile ggO#!/usr/bin/env python<CR>#coding=utf-8<CR>#Edit by Anemone at :<esc>:r !date <esc>I#<esc>o#E-mail:x565178035@126.com<esc>oif __name__ == '__main__':<cr>main(<esc>2kodef main(<esc>la:<cr>
vmap <Tab> <c-v>I<Tab><Esc>
nmap <C-i> :call LoadTemplate("main.py")<CR>
function! LoadTemplate(filename)
    "let s:test=input("Please input:")
    sil! exec "0r ".$VIM."/vimfiles/py-support/".a:filename
    sil! exec "%s/<FILENAME>/".expand("%:t")."/g"
    sil! exec "%s/<FUN_NAME>/".expand("%:t:r")."/g"
    sil! exec "%s/<DATE>/".strftime("%Y-%m-%d %H:%M")."/g"
    call search("<CU","W")
    sil! exec "normal \"adf>"
    sil! exec "startinsert!"
    "call TemplateReplTags()
endfunction
if line("$")==1
    call LoadTemplate("main.py")
endif

imap <c-n> <Tab>
