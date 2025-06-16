local prettier = { "prettierd" }
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = prettier,
        typescript = prettier,
        javascriptreact = prettier,
        typescriptreact = prettier,
        svelte = prettier,
        css = prettier,
        html = prettier,
        json = prettier,
        yaml = prettier,
        markdown = prettier,
        graphql = prettier,
        liquid = prettier,
        go = { "goimports-reviser", "gofumpt" },
      },
      formatters = {
        ["goimports-reviser"] = { prepend_args = { "-rm-unused", "-set-alias" } },
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
