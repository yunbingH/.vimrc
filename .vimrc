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

"lsp补全python
call plug#begin()
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
                \ 'name': 'pyls',
                \ 'cmd': {server_info->['pyls']},
                \ 'allowlist': ['python'],
                \ })
endif


"快捷执行F6
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


