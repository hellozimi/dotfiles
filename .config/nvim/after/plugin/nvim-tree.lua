vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,

  hijack_directories   = {
    enable = true,
    auto_open = true,
  },

  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  sync_root_with_cwd  = true,
  respect_buf_cwd     = true,
  diagnostics         = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  view = {
    adaptive_size = true,
    centralize_selection =true,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {}
    },
    float = {
      enable = true
    }
  },
  actions = {
    open_file = {
      quit_on_open = true,
      resize_window = true,
    }
  }
}
