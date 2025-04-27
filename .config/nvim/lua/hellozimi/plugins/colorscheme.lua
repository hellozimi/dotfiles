return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("tokyonight").setup({
      -- use the night style
      style = "night",
      -- disable italic for functions
      styles = {
        functions = {}
      },
      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = "#ff0000"
      end
    })

    vim.cmd([[colorscheme tokyonight ]])
  end
}

--return {
--  "catppuccin/nvim",
--  name = "catppuccin",
--  priority = 1000,
--  lazy = false,
--  config = function()
--    require("catppuccin").setup({
--      flavour = "mocha",
--      background = {
--        light = "latte",
--        dark = "mocha",
--      },
--      styles = {
--        comments = {},
--        conditionals = {},
--      },
--    })
--    --vim.opt.background = 'light'
--    --vim.cmd("colorscheme catppuccin-mocha")
--    vim.cmd([[colorscheme catppuccin]])
--  end
--}
