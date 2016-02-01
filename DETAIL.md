# exVim 增强配置(支持Windows)

(http://ww1.sinaimg.cn/large/0060lm7Tgw1f0j4d3hyo4j31hk0u0adx.jpg)

基于exVim进行配置,仅更改.vimrc.local和.vimrc.plugin.local文件.支持C/C++,Java,Python,PHP,Matlab,Arduino等语言.对界面,字体进行美化调整,改变部分案件映射,同时对Windows进行优化.另外,vim.local文件可以改名为.vimrc文件提供一个无插件的轻型vim配置文件.

# 安装
**以下流程仅适用于Windows用户**
1. 安装[exVim](https://github.com/vim/vim-win3c2-installer/releases).**建议安装x86版本,同时需要将exVim安装在C盘根目录下,如c:\exVim.否则需要修改reg文件**
2. 运行cmd_here.reg,edit_with_vim.reg,new_project.reg.
3. 检查vim.exe是否在环境变量内,并将newProject.vbs放入环境变量中.
4. 安装[Git](http://git-scm.com/download/),检查环境变量.
5. 安装[Python](https://www.python.org/),[Lua](http://www.lua.org/download.html),填写环境变量.
6. 安装youyuan字体.
7. 运行exVim,无视错误,输入 :BundleUpdate,安装插件.

# 特性
## 原版功能

保留exVim的配置,支持最新版exVim的一切插件功能

## vimrc.local

* 共享剪切板

        set clipboard=unnamed
* 指定窗口出现的位置,坐标原点在屏幕左上角

        winpos 100 10
* 换行时自动缩进宽度,可更改(宽度同tabstop)

        set shiftwidth=4
* 指定按一次backspace就删除shiftwidth宽度

        set smarttab

* 启用折叠(大于200行)

        if line("$")>200
            set foldenable
            set foldmethod=syntax
        endif

* 常规模式下用空格键来开关光标行所在折叠（注：zR 展开所有折叠，zM 关闭所有折叠）

        nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zO')<CR>

* 当文件在外部被修改，自动更新该文件

        set autoread

* 常规模式下输入 cS 清除行尾空格

        nmap cl :%s/\s\+$//g<CR>:noh<CR>:set fileencoding=utf-8<cr>:%s/\t/<space><space><space><space>/g<CR>

* 常规模式下输入 cM 清除行尾 ^M 符号

        nmap cm :%s/\r$//g<CR>:noh<CR>:set fileencoding=gbk<cr>

* 突出显示当前行

        set cursorline

* 设置不自动换行

        set wrap
* 光标距离底部5行
    set scrolloff=5

* Ctrl+h/j/k/l切换窗口

        noremap <c-k> <c-w>k
        noremap <c-j> <c-w>j
        noremap <c-h> <c-w>h
        noremap <c-l> <c-w>l

* 隐藏滚动条

        set guioptions-=L " 隐藏左侧滚动条
        set guioptions-=r " 隐藏右侧滚动条
        set guioptions-=b " 隐藏底部滚动条

* 关闭系统警告声

        set noeb
        set vb
* 外部更改

        set autoread
* 字体配置

        set guifontwide=YouYuan:h10.5:cGB2312

* Qfix 乱码问题

        function QfMakeConv()
            let qflist = getqflist()
            for i in qflist
               let i.text = iconv(i.text, "cp936", "utf-8")
            endfor
            call setqflist(qflist)
        endfunction
        au QuickfixCmdPost make call QfMakeConv()

* 解决consle输出乱码

        language messages zh_CN.utf-8
* 个性化设置 可以删除

        autocmd BufNewFile,BufRead *.h source $VIM/vimfiles/hscript.vim
        autocmd BufNewFile,BufRead *.c source $VIM/vimfiles/cscript.vim
        autocmd BufNewFile,BufRead *.cpp source $VIM/vimfiles/cppscript.vim
        autocmd FileType python source $VIM/vimfiles/pyscript.vim
        autocmd FileType arduino source $VIM/vimfiles/inoscript.vim
        autocmd FileType matlab source $VIM/vimfiles/matlabscript.vim
        autocmd FileType asm source $VIM/vimfiles/asmscript.vim
        autocmd FileType php source $VIM/vimfiles/phpscript.vim
        autocmd FileType java source $VIM/vimfiles/javascript.vim

        map w e
        imap ]] {<CR>
        cmap W w
        imap jj <ESC>
        imap kk <ESC>la

## vimrc.plugin.local
* 纵向对齐线插件

        Bundle 'Yggdroot/indentLine'
* Python字典增强

        Bundle 'pydiction'
根据需要修改pydiction的路径

        let g:pydiction_location = $VIM."/vimfiles/bundle/pydiction/complete-dict"
根据新的库生成新的字典

        python pydiction.py <module> [module]
        # 例如
        python pydiction.py requests
* 多语言一键编译&运行

        Bundle 'xuhdev/SingleCompile'
        " 这里我定义的是F9
        nmap <F9> :w<cr>: SCCompileRun<CR>
        imap <F9> <ESC>:w<CR>:SCCompileRun<CR>
* matlab 增强插件

        Bundle 'lazywei/vim-matlab'
* php 自动注释

        Bundle 'vim-scripts/PDV--phpDocumentor-for-Vim'
* java 补全增强

  我试了javacomplete,javacomplete2,vjde.还是vjde最好用

        Bundle 'cespare/vjde'

* 括号自动补全

        Bundle 'jiangmiao/auto-pairs'

* 多语言模板补全

        Plugin 'Shougo/neosnippet-snippets'
        Plugin 'Shougo/neosnippet.vim'
Ctrl+k用来选择以及跳到下一处

        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)

* 自动补全

        Bundle 'Shougo/neocomplete.vim'
        let g:neocomplete#enable_debug = 0 "关闭错误提示
        let g:acp_enableAtStartup = 0 "关闭Autocompop
        let g:neocomplete#enable_at_startup = 1 "自动运行
        let g:neocomplete#enable_smart_case = 1 "自动加前括号
        let g:neocomplete#enable_auto_select = 0 "关闭自动选择功能
        let g:neocomplete#sources#syntax#min_keyword_length = 4 "未知
        let g:neocomplete#sources#auto_completion_start_length = 4 "4个字后开始补全
        " 这里很重要 设置根据字典自动补全
        let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'arduino' : $VIM.'/vimfiles/dict/arduino.dict',
            \ 'c' : $VIM.'/vimfiles/dict/c.dict',
            \ 'cpp' : $VIM.'/vimfiles/dict/cpp.dict',
            \ 'css' : $VIM.'/vimfiles/dict/css.dict',
            \ 'java' : $VIM.'/vimfiles/dict/java.dict',
            \ 'javascript' : $VIM.'/vimfiles/dict/javascript.dict',
            \ 'php' : $VIM.'/vimfiles/dict/php.dict',
            \ 'vim' : $VIM.'/vimfiles/dict/vim.dict',
            \ 'matlab' : $VIM.'/vimfiles/dict/matlab.dict',
        \ }
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " 设置万能补全
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
* 目录树

    F2为打开/关闭目录树
    vimrc.plugin 里已经开启这个插件,这里只做配置工作

        " Bundle 'scrooloose/nerdtree'
        map <F2> :NERDTreeToggle<CR>
* 历史操作列表

    F3为打开/关闭历史操作列表
    vimrc.plugin 里已经开启这个插件,这里只做配置工作

        " Plugin 'mbbill/undotree'
        nnoremap <F3> :UndotreeToggle<CR>
* 快速在首尾添加括号

    在块模式下 按下],},)和" 会自动在选中的左右添加括号
    surround还有其他用法,详情请见github该项目.
    vimrc.plugin 里已经开启这个插件,这里只做配置工作

        " Plugin 'tpope/vim-surround'
        xmap ) S(
        xmap ] S[
        xmap } S{
        " xmap ' S'
        xmap " S"


## Windows
* 右键文件以Vim编辑--"Edit with Vim"
* 右键文件夹空白处在此处打开Cmd--"Cmd here"
* 右键文件夹空白处新建项目--"New Project"


# Q&A
## 提示Python或Lua出现问题
由于有的插件需要vim有+python和+lua支持.Windows用户,请下载最新版的exVim,之后再下载对应版本的python和lua,并加入环境变量.注意一点,对应版本不止是x86/x64,还指python和lua自身版本,据我所知以前的vim不支持最新的python和lua.
## exVim的全局搜索功能无法使用
重装[id-utils](http://gnuwin32.sourceforge.net/packages/id-utils.htm),并将路径指定到非系统目录,并添加到环境变量中.重启系统

# 其他
联系方式:x565178035@126.com

Github仓库:https://github.com/x565178035/exvim

Windows完整版:http://pan.baidu.com/s/1o6Yhbaa 密码：lvsv

感谢exVim项目,以及以前帮助过我的人
