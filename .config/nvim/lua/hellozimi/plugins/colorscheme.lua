return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      background = {
        light = "latte",
        dark = "frappe",
      },
      styles = {
        comments = {},
        conditionals = {},
      },
    })
    vim.cmd("colorscheme catppuccin-frappe")
  end
}
