return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- colorscheme
  use "olimorris/onedarkpro.nvim"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use("nvim-treesitter/playground")
  use("romgrk/nvim-treesitter-context")

  -- git
  use "tpope/vim-fugitive"

  -- statusline
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  })

  -- tmux
  use 'christoomey/vim-tmux-navigator'

  -- lsp
  use "neovim/nvim-lspconfig"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/nvim-cmp"
  use "onsails/lspkind-nvim"
  use "simrat39/symbols-outline.nvim"
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      local saga = require("lspsaga")

      saga.init_lsp_saga({
        -- your configuration
      })
    end,
  })

  -- fuzzy finder
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.0",
    requires = { {"nvim-lua/plenary.nvim"} }
  }
  use "nvim-telescope/telescope-file-browser.nvim"

  -- allows transparent background
  use "xiyaowong/nvim-transparent" 
end)
