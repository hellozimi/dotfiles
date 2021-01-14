" disables vi mode
set nocompatible

" number of lines vim remebers in history
set history=700

" enable filetype plugins
filetype plugin on
filetype indent on

" read changes to file from the outside
set autoread

" neovim: auto-create undo directory
set undofile

set ffs=unix,dos,mac

set nobackup        " ┐
set nowritebackup   " │ no backup
set noswapfile      " ┘

" mouse
set mouse=nv

" =========
"  Install
" =========

call plug#begin('~/.local/share/nvim/plugged')
" General
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'

" Productivity
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jparise/vim-graphql'
Plug 'shime/vim-livedown'
Plug 'vim-scripts/paredit.vim', { 'for': ['clojure', 'scheme'] }
Plug 'kien/rainbow_parentheses.vim'
Plug 'hashivim/vim-terraform'

" Programming
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'
call plug#end()

" ========
"  Colors
" ========

" dark background color
set background=dark

" jellybeans colorscheme
colorscheme base16-ocean

" true color for neovim
set termguicolors

" enable syntax highlighted
set syntax=on

" set italics
highlight Comment gui=italic
set t_ZH=^[[3m
set t_ZR=^[[23m

" utf8 as default encoding
set encoding=utf8

" =========
"  General
" =========

" ignore casing
set ignorecase

" be smart about cases
set smartcase

" highlight search
set hlsearch

" incremental search
set incsearch

" highlight matching
set showmatch

" shows cursorline
set cursorline

" use system clipboard
if has("gui_running")
    if g:os == "Darwin"
        set clipboard=unnamed
    elseif g:os == "Linux"
        set clipboard+=unnamedplus
    endif
endif

" /g default on substitutions
set gdefault

" only redraw when needed to
set lazyredraw

" shows cmd in bottom
set showcmd

" visual autocomplete for command menu, tab autocompletion
set wildmenu
set wildmode=list:full
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap file

set t_ut=
set noshowmode

" shows line numbers
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if !(bufname("%") =~ "NERD_Tree_") | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter * if !(bufname("%") =~ "NERD_Tree_") | set norelativenumber | endif
augroup END

" Always show signcolumn
set signcolumn=yes

" return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

set noerrorbells    " ┐
set novisualbell    " │ disable error
set t_vb=           " │ sounds
set tm=500          " ┘

" creates dir if not exists
function s:MkNonExDir(file, buf)
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

" ======
"  Text
" ======

" uses spaces instead of tabs
set expandtab

" be smart when using tabs
set smarttab

" indent by 4 by default
set shiftwidth=4
set tabstop=4

" automatically indents
set autoindent

" smart indent
set smartindent

" wraps lines
set wrap

" make vim handle long lines nicely
set textwidth=79
set formatoptions=qrn1

" =========
"  Keymaps
" =========

let mapleader=","

" smart movement between panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" maps ctrl-p to :files
map <C-p> :GFiles<CR>

" smarter when moving through wrapped lines
noremap j gj
noremap k gk

" centers search results when browsing results
nnoremap n nzzzv
nnoremap N Nzzzv

" centers cursor when moving up and down
noremap <C-d> <C-d>zz<CR>
noremap <C-u> <C-u>z<CR>

" move lines with alt+j/k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" clears search
map <Leader>h :nohl<CR>

" NerdTree: key mapping
map <Leader>tt <esc>:NERDTreeToggle<CR>


" =========
"  Plugins
" =========

set completeopt+=noselect
set completeopt-=preview

" deoplete: enables as start up
let g:deoplete#enable_at_startup=1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_doc_popup_window = 1

let g:go_auto_type_info = 1

let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1

" vim-go: uses goimports as formatting tool
let g:go_fmt_command = "goimports"

let $NVIM_TUI_ENABLE_TRUE_COLOR=1


" LightLine: settings
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'readonly': 'MyReadonly',
    \   'modified': 'MyModified',
    \   'filename': 'MyFilename'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }

" LightLine: Will add `+` next to file name when file has changed
function! MyModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

" LightLine: Will show `` when file is Read Only
function! MyReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return ""
    else
        return ""
    endif
endfunction

" LightLine: Will make use of plugin Fugitive to show branch and `` icon
function! MyFugitive()
    if exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? ' '._ : ''
    endif
    return ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

" NerdTree: settings
let NERDTreeIgnore=['\.vim$', '\~', '.swp$', '.*\.pyc$', '^\.git$', '^\.$', '^\.\.$', '^\.sass-cache$', '^__pycache__$']
let NERDTreeShowBookmarks=0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeChDirMode=2

" VimTerraform: settings
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" GitGutter: settings
autocmd BufWritePost * GitGutter
