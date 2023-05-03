local nnoremap = require("smn.keymap").nnoremap
local builtin = require("telescope.builtin")
nnoremap("<leader>ff", builtin.find_files, {})
nnoremap("<leader>fb", builtin.buffers, {})
nnoremap("<leader>fB", builtin.git_branches, {})
nnoremap("<leader>fg", builtin.live_grep, {})
nnoremap("<leader>fh", builtin.help_tags, {})
nnoremap("<leader>vrr", builtin.lsp_references, {})
nnoremap("<leader>vws", builtin.lsp_dynamic_workspace_symbols, {})

require("telescope").load_extension "file_browser"

require("telescope").setup {
  defaults = {
   file_ignore_patterns = {"node_modules"},
    mappings = {
      n = {
    	  ['<C-d>'] = require('telescope.actions').delete_buffer
      },
      i = {
        ["<C-h>"] = "which_key",
        ['<C-d>'] = require('telescope.actions').delete_buffer
      }
    }
  }
}

nnoremap("<leader>fd", require "telescope".extensions.file_browser.file_browser)
