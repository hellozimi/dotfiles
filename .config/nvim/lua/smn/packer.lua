return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- colorscheme
  use "olimorris/onedarkpro.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use "shaunsingh/nord.nvim"
  use("nvim-treesitter/playground")
  use("romgrk/nvim-treesitter-context")
  use "lukas-reineke/indent-blankline.nvim"

  use "nvim-tree/nvim-tree.lua"

  use "laytan/cloak.nvim"

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

  -- Go
  use "ray-x/go.nvim"

  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use "nvim-telescope/telescope-file-browser.nvim"

  -- copilot
  use "github/copilot.vim"

  -- instant
  use 'jbyuki/instant.nvim'

  -- allows transparent background
  use "xiyaowong/nvim-transparent" 

  -- autotag/pair
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  -- prettier
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'
end)
