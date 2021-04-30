set nocompatible " be iMproved, required
let g:SYSTEM=-1
let g:MACOS=0
let g:LINUX=0
let g:WINDOWS=0
if !has('macunix')
    let g:MACOS=1
elseif !has('unix') && !has('macunix') && !has('win32unix')
    let g:LINUX=1
elseif !has('win16') || !has('win32') || !has('win64')
    let g:WINDOWS=1
endif

let proc_version=system("cat /proc/version")
if match(proc_version,"Microsoft")==-1
    let g:is_wsl=0
else
    let g:is_wsl=1
endif

" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if WINDOWS()
    let g:exvim_custom_path=$VIM
end
if !exists('g:exvim_custom_path')
    if WINDOWS()
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif
endif

" 剪切板
if WINDOWS()
    set clipboard+=unnamed
elseif OSX()
    set clipboard=unnamed
else
    set clipboard+=unnamedplus
endif

" Set vim-plug
call plug#begin('~/.vim/plugged')
