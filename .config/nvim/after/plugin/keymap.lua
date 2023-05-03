local K = require("smn.keymap")
local xnoremap = K.xnoremap
local vnoremap = K.vnoremap
local nnoremap = K.nnoremap
local nmap = K.nmap

vnoremap("K", ":m '<-2<CR>gv=gv")
vnoremap("J", ":m '>+1<CR>gv=gv")

nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

nmap("<C-h>", "<cmd>TmuxNavigateLeft<CR>")
nmap("<C-j>", "<cmd>TmuxNavigateDown<CR>")
nmap("<C-k>", "<cmd>TmuxNavigateUp<CR>")
nmap("<C-l>", "<cmd>TmuxNavigateRight<CR>")

nnoremap("<leader>tt", "<cmd>NvimTreeToggle<CR>")

nnoremap("j", "gj")
nnoremap("k", "gk")

nnoremap("n", "nzz")
nnoremap("N", "Nzz")

