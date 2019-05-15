filetype plugin indent on
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2

if &rtp =~ 'vim-terraform'
    autocmd! BufWritePost *.tf TerraformFmt
endif
