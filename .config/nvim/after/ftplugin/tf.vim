setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2

autocmd! BufWritePost *.tf TerraformFmt
