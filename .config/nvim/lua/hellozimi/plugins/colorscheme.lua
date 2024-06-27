return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function ()
    require("catppuccin").setup({
      flavour = "auto",
      background = {
        light = "latte",
        dark = "frappe",
      },
    })
    vim.cmd("colorscheme catppuccin")
  end
}
