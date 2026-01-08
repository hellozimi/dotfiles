local K = require("hellozimi.core.keymap")

K.nnoremap("<leader>hl", ":nohl<CR>")

K.vnoremap("K", ":m '<-2<CR>gv=gv")
K.vnoremap("J", ":m '>+1<CR>gv=gv")
K.nnoremap("<C-d>", "<C-d>zz")
K.nnoremap("<C-u>", "<C-u>zz")
K.nnoremap("<leader>d", "\"_d")
K.vnoremap("<leader>d", "\"_d")
K.vnoremap("<leader>p", "\"_dP")

K.nnoremap("<leader>s", "<cmd>up<cr>")

K.nnoremap("j", "gj")
K.nnoremap("k", "gk")
K.nnoremap("n", "nzz")
K.nnoremap("N", "Nzz")

-- window management
K.nnoremap("<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
K.nnoremap("<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
K.nnoremap("<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
K.nnoremap("<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- git mappings
K.nnoremap("<leader>gl", ":Git log --oneline -75<CR>", { desc = "oneline git log the last 75 commits" })
K.nnoremap("<leader>gB", ":GBrowse!<CR>", { desc = "Copies github permalink at line" })
K.vnoremap("<leader>gB", ":GBrowse!<CR>", { desc = "Copies github permalink for selected lines" })
