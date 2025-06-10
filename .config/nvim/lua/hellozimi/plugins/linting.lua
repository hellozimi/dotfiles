return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint" },
      python = { "pylint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    local get_lsp_client = function()
      -- Get lsp client for current buffer
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      local clients = vim.lsp.get_clients()
      if next(clients) == nil then
        return nil
      end

      for _, client in pairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client
        end
      end

      return nil
    end

    local flex_lint = function()
      local client = get_lsp_client()
      local root_dir = client and client.config and client.config.root_dir
      if root_dir then
        lint.try_lint(nil, { cwd = root_dir })
      else
        lint.try_lint()
      end
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        flex_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      flex_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
