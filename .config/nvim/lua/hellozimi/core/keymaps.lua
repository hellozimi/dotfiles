local K = require("hellozimi.core.keymap")

-- keymap.set("n", "<leader>hl", ":nohl<CR>", { desc = "Clear search highlights" })
K.nnoremap("<leader>hl", ":nohl<CR>")

K.vnoremap("K", ":m '<-2<CR>gv=gv")
K.vnoremap("J", ":m '>+1<CR>gv=gv")
K.nnoremap("<C-d>", "<C-d>zz")
K.nnoremap("<C-u>", "<C-u>zz")
K.nnoremap("<leader>d", "\"_d")
K.vnoremap("<leader>d", "\"_d")
K.vnoremap("<leader>p", "\"_dP")

K.nnoremap("j", "gj")
K.nnoremap("k", "gk")
K.nnoremap("n", "nzz")
K.nnoremap("N", "Nzz")

K.nnoremap("<C-?>", ":CodeCompanion")

-- window management
K.nnoremap("<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
K.nnoremap("<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
K.nnoremap("<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
K.nnoremap("<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

K.nnoremap('<leader>?', ':CodeCompanionChat<CR>')
