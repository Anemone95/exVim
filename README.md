# vim 配置(支持Windows)
本人vim配置，支持Windows(甚至WSL)、Linux和Mac，需要Vim版本>=8.2

# 安装
## Windows
1. 安装[vim](https://github.com/vim/vim-win32-installer/releases).**建议安装x64版本,同时需要将vim安装在C盘根目录下,如c:\vim.否则需要修改reg文件**
2. 运行cmder_here.reg(当前文件夹下打开命令行), edit_with_vim.reg（右键用 vim 打开）.
3. 检查vim.exe是否在环境变量内，并且添加`C:\Vim\bin`环境变量.
4. 安装[Git](http://git-scm.com/download/),检查环境变量.
5. 安装[Python](https://www.python.org/), [Lua](http://www.lua.org/download.html),填写环境变量 %PYTHONHOME%,PATH=%PATH%;%PYTHONHOME%;%PYTHONHOME%/Script，（注意，如果使用conda版本python，需要额外安装python for windows launcher, 在install/launchwin.amd64.msi可以找到该文件）
6. 安装youyuan、DejaVu Sans Mono for Powerline字体.
7. 运行gvim,无视错误,输入 :Plugin,安装插件.
7. 运行gvim,无视错误,coc.nvim 会自动安装补全插件.

注意，WSL用户参照linux安装方法，最后运行`vim/install/edit_with_wsl_vim.reg`可以实现右键使用vim编辑.

## Linux
```bash
cd ~
git clone https://github.com/Anemone95/exVim.git
bash ./exVim/install/install.sh
```

运行gvim,无视错误,输入 :PluginInstall, 安装插件，再次启动gvim，coc.nvim自动安装其他补全插件

# 特性
## vimrc.local

* 共享剪切板

* 指定窗口出现的位置,坐标原点在屏幕左上角

* 换行时自动缩进宽度,可更改(宽度同tabstop)

* 指定按一次backspace就删除shiftwidth宽度

* 启用折叠(大于200行)

* 常规模式下用空格键来开关光标行所在折叠（注：zo 展开当前折叠，zz 关闭当前折叠）

* 当文件在外部被修改，自动更新该文件

* 常规模式下输入 cS 清除行尾空格

* 常规模式下输入 cM 清除行尾 ^M 符号

* 突出显示当前行

* 设置不自动换行

* 光标距离底部5行

* Ctrl+h/j/k/l切换窗口

* 隐藏滚动条

* 关闭系统警告声

* 外部更改自动刷新

* 字体配置

* Qfix 乱码问题

* 解决consle输出乱码

* 个性化设置 可以删除

## vimrc.plugin
* 纵向对齐线插件


* 多语言F9一键编译&运行

* matlab 增强插件【TODO】

* 括号自动补全

* 自动补全【coc.nvim】

* 目录树【Nerdtree】

    F2为打开/关闭目录树
    
* 快速在首尾添加括号

    在块模式下 按下],},)和" 会自动在选中的左右添加括号
    surround还有其他用法,详情请见github该项目.
    vimrc.plugin 里已经开启这个插件,这里只做配置工作

## Windows
* 右键文件以Vim编辑--"Edit with Vim"
* 右键文件夹空白处在此处打开Cmd--"Cmd here"
* 右键文件夹空白处新建项目--"New Project"


# Q&A
## 提示Python或Lua出现问题
由于有的插件需要vim有+python和+lua支持.Windows用户,请下载最新版的exVim,之后再下载对应版本的python和lua,并加入环境变量.注意一点,对应版本不止是x86/x64,还指python和lua自身版本,据我所知以前的vim不支持最新的python和lua.
## Linux中字体问题
git https://github.com/powerline/fonts
sh fonts/install.sh

## Windows上闪退，装的是conda的python

由于Conda没有填%PYTHONHOME%变量，这就很麻烦了，因为如果设置了全局%PYTHONHOME%，那么conda env会失效，现在想到的方法是(1)在win中设置%CONDA_HOME%变量，同时保证环境变量中%VIM%/bin要在%VIM%/vim81之前。(2)启动时启动bin/gvim.bat，在bat中设置环境变量。


