return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
        liquid = { "prettierd" },
        go = { "goimports-reviser", "gofumpt" },
      },
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 1000,
      },
    })

    -- Add a keymap for manual formatting with Prettier
    vim.keymap.set("n", "<leader>fx", function()
      conform.format({
        formatters = { "prettierd" },
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format with Prettier" })
  end
}

