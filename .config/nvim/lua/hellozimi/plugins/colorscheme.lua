return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      styles = {
        comments = {},
        conditionals = {},
      },
    })
    --vim.opt.background = 'light'
    --vim.cmd("colorscheme catppuccin-mocha")
  end
}
