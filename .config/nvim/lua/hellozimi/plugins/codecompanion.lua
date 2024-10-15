return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    { "stevearc/dressing.nvim", opts = {} },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "openai"
        },
        inline = {
          adapter = "openai"
        },
        agent = {
          adapter = "openai"
        }
      },
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = "cmd:cat ~/.config/.open-api",
            },
          })
        end,
      },
    })
  end
}
