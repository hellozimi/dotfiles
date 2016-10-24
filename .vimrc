set nocompatible	" no vi mode
filetype off		" disable default filetype detection

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin('~/.vim/plugins')
    Plugin 'kien/ctrlp.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'bling/vim-airline'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'apple/swift', {'rtp': 'utils/vim/'}
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'chriskempson/base16-vim'
    Plugin 'Xuyuanp/nerdtree-git-plugin'
    Plugin 'JamshedVesuna/vim-markdown-preview'
    Plugin 'Shougo/neocomplete.vim'
    Plugin 'fatih/vim-go'
    Plugin 'jiangmiao/auto-pairs'
call vundle#end()

filetype plugin indent on
syntax on

if has('autocmd')
    filetype plugin indent on
endif

set exrc " use local .vimrcs
set secure

set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8

set background=dark

set guitablabel=%M\ %t
set t_Co=256		" Full-color support
if !has("gui_running")
    set term=xterm-256color
endif
if has('mouse')
    set mouse=a
endif

colorscheme base16-ocean
set guifont=MesloLGMDZ-RegularForPowerline:h15 " font

autocmd! bufwritepost .vimrc source ~/.vimrc

set autoindent      " auto indent
set smartindent     " smart indent

set hidden          " no overwrite on new files
set clipboard=unnamed " use system clipboard
set paste           " paste without auto indentation

set hlsearch        " highlight search
set incsearch       " incremental search

set ignorecase      " ignore casing
set infercase       " infer casing
set smartcase       " be smart with cases

set gdefault        " /g default on substitutions

set lazyredraw      " only redraw when needed

set magic
set wildmenu

set softtabstop=4	" ┐
set shiftwidth=4    " │ default tab width and
set tabstop=4		" │ set tabs with spaces
set expandtab		" ┘

set number          " line numbers
set cursorline      " show cursor line

set guioptions-=r   " ┐ don't show
set guioptions-=L   " ┘ scroll bars

set laststatus=2    " show statusline

set noerrorbells    " ┐
set novisualbell    " │ disable error
set t_vb=           " │ sounds
set tm=500          " ┘

set encoding=utf8
set ffs=unix,dos,mac

set nobackup        " ┐
set nowritebackup   " │ no backup
set noswapfile      " ┘

set foldenable          " enable folding
set foldlevelstart=10   " start at max
set foldnestmax=10      " fold max 10
set foldmethod=syntax   " fold based on indent

set splitbelow " open new windows below

set undofile            " ┐
set undodir=~/.vim/undo " ┘ store undo state between sessions

set backspace=indent,eol,start " set backspace options

set shortmess+=I        " disable startup message

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

"---------------------
" plugins
"---------------------

if filereadable(glob('~/.vim/.plugins.vim'))
    source ~/.vim/.plugins.vim
endif

"---------------------
" plugins
"---------------------

autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,} " folding for sass

" remove trailing whitespaces and ^M chars
autocmd FileType c,h,m,swift,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

function! NeatFoldText() "{{{2
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2

"----------------------------------------
" functions
"----------------------------------------

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Function to create folders when writing
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" trim white space (http://www.bestofvim.com/tip/trailing-whitespace/)
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" auto clear whitespace
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

"----------------------------------------
" key mappings
"----------------------------------------

call togglebg#map("<F5>")

let mapleader=","

" indent all lines
map <Leader>i <esc>gg=G

" toggle nerdtree
map <Leader>tt <esc>:NERDTreeToggle<CR>

" map pane switching
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" 0 steps to first non blank character
map 0 ^

" Buffer handling
nmap <Leader>t :enew<CR>
nmap <Leader>n :bprevious<CR>
nmap <Leader>m :bnext<CR>
nmap <Leader>bd :bp <BAR> bd #<CR>

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" remove search highlight
map <Leader>h :nohl<CR>

" fold code
nnoremap <space> za

" paste on next line
nmap <Leader>p o<esc>p

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
