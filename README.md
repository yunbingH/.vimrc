syntax on
set relativenumber        "相对行号
set number                "行号  
set autoindent            "自动缩进
set cursorline
set ignorecase              "搜索忽略大小写
set mouse=                  "鼠标
set expandtab               "tab键
set tabstop=4
set shiftwidth=4
set showcmd                 "显示命令
set encoding=utf-8
set t_Co=256
set laststatus=2            "状态栏
set showmatch               "高亮括号
set hlsearch                "高亮匹配结果

"set encoding
set encoding=utf-8
set fileencodings=utf-8,gb18030,gbk
set fileencoding=utf-8





"Vundle
set nocompatible
filetype indent on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'DfrankUtil'
Plugin 'vimprj'
Plugin 'indexer.tar.gz'
call vundle#end()
filetype plugin indent on




"YCM
let mapleader = ','
let g:ycm_confirm_extra_conf=0
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_tag_files=1
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
nnoremap <leader>] :YcmCompleter GoToDefinitionElseDeclaration<CR>



map<F6> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec '!clang % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'cpp'
        exec '!clang++ % -o %<'
        exec '!time ./<'
    elseif &filetype == 'python'
        exec '!time python %'
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'java'
        exec '!java %<'
    endif
endfunc

"自动补全符号
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 return a:char
 elseif line[col - 1] == a:char
 return "\<Right>"
 else
 return a:char.a:char."\<Esc>i"
 endif
endf

