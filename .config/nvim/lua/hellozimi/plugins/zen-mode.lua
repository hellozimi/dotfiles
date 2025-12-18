return {
  "folke/zen-mode.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function ()
    local K = require("hellozimi.core.keymap")
    K.nnoremap("<leader>zm", "<cmd>ZenMode<CR>", { desc = "Toggle ZenMode"})
  end
}
