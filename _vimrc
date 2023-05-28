"iMproved, required
set nocompatible
scriptencoding utf-8

" -----------------------------------------------------------------------------
" Desc: 设置系统类型
" -----------------------------------------------------------------------------
let g:IS_MACOS=0
let g:IS_LINUX=0
let g:IS_WINDOWS=0
if has('macunix')
    let g:IS_MACOS=1
elseif has('unix') || has('macunix') || has('win32unix')
    let g:IS_LINUX=1
elseif has('win16') || has('win32') || has('win64')
    let g:IS_WINDOWS=1
endif

let proc_version=system("cat /proc/version")
function! s:is_wsl()
    let l:proc_version=system("cat /proc/version")
    if match(l:proc_version,"Microsoft")==-1 && match(l:proc_version,"microsoft")==-1
    return 0
    else
    return 1
    endif
endfunction
let g:IS_WSL=<SID>is_wsl()

" ---------------------------------------------------------------------------
" Desc: windows适配python3
"----------------------------------------------------------------------------
if g:IS_WINDOWS
    let &pythonthreedll = 'python37.dll'
    py3 import os; sys.executable=os.path.join(sys.prefix, 'python.exe')
elseif g:IS_MACOS
    set pythonthreedll=/opt/homebrew/Frameworks/Python.framework/Versions/3.10/lib/libpython3.10.dylib
endif

" -----------------------------------------------------------------------------
" Desc: 永远使用英文菜单
" -----------------------------------------------------------------------------
set langmenu=none
if g:IS_WINDOWS
    silent exec 'language english'
elseif g:IS_MACOS
    silent exec 'language en_GB.UTF-8'
else
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
    " in mac-terminal
    silent exec 'language en_US'
    else
    " in linux-terminal
    silent exec 'language en_US.utf8'
    endif
endif
"解决consle输出乱码
if g:IS_WINDOWS
    language messages zh_CN.utf-8
endif




" -----------------------------------------------------------------------------
" Desc: VIM配置文件位置
" -----------------------------------------------------------------------------
if g:IS_WINDOWS
    let g:VIMFILES_PATH=$VIM.'/vimfiles'
    let g:VIM_PLUG_FILE=$VIM.'/_vimrc.plugins'
    let g:VIM_GUI_FILE=$VIM.'/_vimrc.gui'
else
    let g:VIMFILES_PATH='~/.vim'
    let g:VIM_PLUG_FILE='~/.vimrc.plugins'
    let g:VIM_GUI_FILE=$VIM.'/.vimrc.gui'
end

" -----------------------------------------------------------------------------
" Desc: 剪切板
" -----------------------------------------------------------------------------
set clipboard=unnamed,unnamedplus


" -----------------------------------------------------------------------------
" Desc: Vim UI preference
" -----------------------------------------------------------------------------
colorscheme molokai

" turn on wild menu, try typing :h and press <Tab>
set wildmenu
" display incomplete commands
set showcmd
" 1 screen lines to use for the command-line
set cmdheight=1
" show the cursor position all the time
set ruler
" allow to change buffer without saving
set hidden
" shortens messages to avoid 'press a key' prompt
set shortmess=aoOtTI
" do not redraw while executing macros (much faster)
set lazyredraw
" for easy browse last line with wrap text
set display+=lastline
" always have status-line
set laststatus=2
set titlestring=%t\ (%{expand(\"%:p:.:h\")}/)
" show tag with function protype.
set showfulltag

" 突出显示当前行
set cursorline
if has('multi_byte_ime')
    hi Cursor guifg=bg guibg=White gui=NONE
    hi CursorIM guifg=NONE guibg=Skyblue gui=NONE
    set iminsert=0 imsearch=0
endif

" 指定窗口出现的位置，坐标原点在屏幕左上角
winpos 100 10

" 当文件在外部被修改，自动更新该文件
set autoread

" 0 second to show the matching paren ( much faster )
set matchtime=0

" show line number
set nu

" 设置不自动换行
set wrap

" 下方保留5行
set scrolloff=5


" -----------------------------------------------------------------------------
" Desc: Vim GUI preference
" -----------------------------------------------------------------------------
if has('gui_running')
    " set window's width to 130 columns and height to 40 rows
    if exists('+lines')
    set lines=40
    endif
    if exists('+columns')
    set columns=130
    endif
endif

" 字体
if g:IS_WINDOWS
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11:cANSI
    set guifontwide=YouYuan:h10.5:cGB2312
elseif g:IS_LINUX
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
    set guifontwide=WenQuanYi\ Micro\ Hei\ 11
    " set guifontwide=DejaVu\ Sans\ Mono\ for\ Powerline\ 11.5\ GB2312
elseif g:IS_MACOS
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13
end

" 隐藏滚动条
set guioptions-=L " 隐藏左侧滚动条
set guioptions-=r " 隐藏右侧滚动条
set guioptions-=b " 隐藏底部滚动条
" disable menu & toolbar
set guioptions-=m
set guioptions-=T

" 关闭系统警告声
set noeb
set vb

set termguicolors
set t_Co=256 " make sure our terminal use 256 color

if v:version >= 703
    set noacd " no autochchdir
endif
" -----------------------------------------------------------------------------
" bachup config
" -----------------------------------------------------------------------------
set backup " make backup file and leave it around

" setup back and swap directory
let data_dir = $HOME.'/.data/'
let backup_dir = data_dir . 'backup'
let swap_dir = data_dir . 'swap'
if finddir(data_dir) == ''
    silent call mkdir(data_dir)
endif
if finddir(backup_dir) == ''
    silent call mkdir(backup_dir)
endif
if finddir(swap_dir) == ''
    silent call mkdir(swap_dir)
endif
unlet backup_dir
unlet swap_dir
unlet data_dir

set backupdir=$HOME/.data/backup " where to put backup file
set directory=$HOME/.data/swap " where to put swap file

" -----------------------------------------------------------------------------
" 关闭上方自动补全提示窗口
" -----------------------------------------------------------------------------
setlocal completeopt-=preview


" ------------------------------------------------------------------
" Desc: Fold text
" ------------------------------------------------------------------
set foldmethod=syntax
set foldenable
if line("w$")>700
    set foldlevelstart=0
else
    set foldlevelstart=9999
endif

" -----------------------------------------------------------------------------
" Desc: File encoding
" -----------------------------------------------------------------------------
set encoding=utf-8                                    "设置gvim内部编码，默认不更改
set fileencodings=utf-8,ucs-bom,gbk,cp936,latin-1     "设置支持打开的文件的编码
" 默认改变文件件格式为unix
function! FormatUnix()
    if &modifiable==1
    set fileformat=unix
    set fileencoding=utf-8
    endif
endfunction
autocmd! BufNewFile,BufRead * call FormatUnix()

" ------------------------------------------------------------------
" Desc: Search
" ------------------------------------------------------------------

set showmatch " show matching paren
set incsearch " do incremental searching
set hlsearch " highlight search terms
set ignorecase " set search/replace pattern to ignore case
set smartcase " set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.


" -----------------------------------------------------------------------------
" Desc: Text edit Preference
" -----------------------------------------------------------------------------
" TAB
" 换行时自动缩进宽度，可更改（宽度同tabstop）
set tabstop=4
set expandtab
set cindent shiftwidth=4 " set cindent on to autoinent when editing c/c++ file, with 4 shift width
" 指定按一次backspace就删除shiftwidth宽度
set smarttab
autocmd! BufRead,BufNewFile,BufEnter *.facts setlocal noexpandtab
autocmd! FileType ocaml setlocal tabstop=2 shiftwidth=2

" autoindent
set ai
" smartindent
set si
" indent options
" see help cinoptions-values for more details
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,l0,b0,g0,hs,ps,ts,is,+s,c3,C0,0,(0,us,U0,w0,W0,m0,j0,)20,*30

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" set Number format to null(default is octal) , when press CTRL-A on number
" like 007, it would not become 010
set nf=

" 当前行隐藏特殊字符
autocmd BufEnter * set concealcursor=

set ve=block " in visual block mode, cursor can be positioned where there is no actual character

" official diff settings
set diffexpr=g:MyDiff()
function! g:MyDiff()
    let opt = '-a --binary -w '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    silent execute '!' .  'diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
endfunction


"/////////////////////////////////////////////////////////////////////////////
" 设置 vim-plug 加载插件
"/////////////////////////////////////////////////////////////////////////////
call plug#begin(g:VIMFILES_PATH."/plugged")
if filereadable(expand(g:VIM_PLUG_FILE))
    exec 'source ' . fnameescape(g:VIM_PLUG_FILE)
endif
call plug#end()


" ------------------------------------------------------------------
" Desc: Key map
" ------------------------------------------------------------------
"
" 常规模式下用空格键来开关光标行所在折叠（注：zR 展开所有折叠，zM 关闭所有折叠）
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zO')<CR>
nnoremap zo zO
nnoremap zz zc
nnoremap za zM


" 设置coding为utf8
nmap su :set fileencoding=utf-8<cr>:set fileformat=unix<cr>
" 设置coding为gbk
nmap sg :set fileencoding=gbk<cr>:set fileformat=dos<cr>

" Ctrl+h/j/k/l切换窗口
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" autohotkey
noremap <Up> <c-w>k
noremap <Down> <c-w>j
noremap <Left> <c-w>h
noremap <Right> <c-w>l

imap ]] {<CR>
cmap W w
cmap ww w !sudo tee %
map <C-a> ggVG

" 自动隐藏特殊字符
nmap <leader>v :call ToggleConcealLevel()<CR>
function! ToggleConcealLevel()
    if &conceallevel==0
    set conceallevel=2
    else
    set conceallevel=0
    endif
endfunction

" 函数跳转
" nmap gi <c-]><esc>
nmap go <c-t>

" bash
if has('nvim')
    fu! OpenTerminal()
    bot split
    resize 15
    :terminal
    endf
else
    fu! OpenTerminal()
    bot split
    resize 15
    if g:IS_WINDOWS
        :call term_start('cmd', {'curwin' : 1, 'term_finish' : 'close'})
    else
        :call term_start('zsh', {'curwin' : 1, 'term_finish' : 'close'})
    endif
    endf
endif
nnoremap <F3> :call OpenTerminal()<CR>
tnoremap <Esc> <C-\><C-N>
" nnoremap <leader>R :source $MYVIMRC<CR>

" ------------------------------------------------------------------
" Desc: 文件类型配置
" ------------------------------------------------------------------
autocmd FileType python exec 'source '.g:VIMFILES_PATH."/pyscript.vim"
autocmd FileType arduino exec 'source '.g:VIMFILES_PATH."/inoscript.vim"
autocmd FileType smali set foldmethod=indent
" autocmd FileType javascript setlocal equalprg=js-beautify -p\ --stdin

" ------------------------------------------------------------------
" Desc: 其他个人配置
" ------------------------------------------------------------------
if g:IS_WINDOWS
    let g:VIM_LOCAL_FILE=$VIM.'/_vimrc.local'
else
    let g:VIM_LOCAL_FILE='~/.vimrc.local'
endif

if filereadable(expand(g:VIM_LOCAL_FILE))
    exec 'source ' . fnameescape(g:VIM_LOCAL_FILE)
endif


" 缩进后保持visual
vnoremap > >gv
vnoremap < <gv

hi comment guifg=grey
hi comment ctermfg=grey
hi visual guibg=#666666
hi visual ctermfg=242

" options key
set macmeta

set mouse=a
" 默认在右边/下边打开新窗口
set splitright
set splitbelow
