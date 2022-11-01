local nnoremap = require("smn.keymap").nnoremap
local builtin = require("telescope.builtin")
nnoremap("<leader>ff", builtin.find_files, {})
nnoremap("<leader>fb", builtin.buffers, {})
nnoremap("<leader>fg", builtin.live_grep, {})
nnoremap("<leader>fh", builtin.help_tags, {})

require("telescope").load_extension "file_browser"

nnoremap("<leader>fd", require "telescope".extensions.file_browser.file_browser)
