local K = require("smn.keymap")
local xnoremap = K.xnoremap
local vnoremap = K.vnoremap
local nnoremap = K.nnoremap
local nmap = K.nmap

xnoremap("<leader>p", "\"_dP")

vnoremap("K", ":m '<-2<CR>gv=gv")
vnoremap("J", ":m '>+1<CR>gv=gv")

nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

nmap("<C-j>", "<C-W>j")
nmap("<C-k>", "<C-W>k")
nmap("<C-h>", "<C-W>h")
nmap("<C-l>", "<C-W>l")

nnoremap("j", "gj")
nnoremap("k", "gk")

nnoremap("n", "nzz")
nnoremap("N", "Nzz")

