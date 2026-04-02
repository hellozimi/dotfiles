local function biome_or_prettier()
  -- Check for biome.json in the project root
  local biome_json = vim.fn.glob(vim.fn.getcwd() .. "/biome.json")
  if biome_json ~= "" then
    return { "biome" }
  end
  return { "prettierd" }
end

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = biome_or_prettier,
        typescript = biome_or_prettier,
        javascriptreact = biome_or_prettier,
        typescriptreact = biome_or_prettier,
        svelte = biome_or_prettier,
        css = biome_or_prettier,
        html = biome_or_prettier,
        json = biome_or_prettier,
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
        liquid = { "prettierd" },
        go = { "goimports", "goimports-reviser", "gofumpt" },
      },
      formatters = {
        ["goimports"] = { command = "/Users/simon/go/bin/goimports" },
        ["goimports-reviser"] = { prepend_args = { "-set-alias" } },
        ["biome"] = {
          command = "biome",
          args = { "format", "--stdin-file-path", "$FILENAME" },
          stdin = true,
        },
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
