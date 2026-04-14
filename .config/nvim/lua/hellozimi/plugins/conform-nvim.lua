local function find_biome_config()
  -- Search for biome.json or biome.jsonc from current file's directory upward
  local dir = vim.fn.expand("%:p:h")
  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/biome.json") == 1 or vim.fn.filereadable(dir .. "/biome.jsonc") == 1 then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

local function biome_or_prettier()
  if find_biome_config() then
    return { "biome-check" }
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
        graphql = biome_or_prettier,
        liquid = { "prettierd" },
        go = { "gofmt" },
      },
      formatters = {
        ["goimports"] = { command = "/Users/simon/go/bin/goimports" },
        ["goimports-reviser"] = { prepend_args = { "-set-alias" } },
        ["biome-check"] = {
          command = "biome",
          args = { "check", "--write", "$FILENAME" },
          stdin = false,
          cwd = find_biome_config,
        },
      },
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 2000,
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
