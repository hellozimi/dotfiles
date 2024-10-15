return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules" },
        mappings = {
          n = {
            ['<C-d>'] = require('telescope.actions').delete_buffer
          },
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-h>"] = "which_key",
            ['<C-d>'] = require('telescope.actions').delete_buffer,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps

    local K = require("hellozimi.core.keymap")
    K.nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    K.nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    K.nnoremap("<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    K.nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    K.nnoremap("<leader>fr", "<cmd>Telescope lsp_references<cr>", {})
    K.nnoremap("<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>", {})
    K.nnoremap("<leader>fws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", {})
  end,
}
