return {
  "mason-org/mason.nvim",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- Configure default capabilities with position encoding
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    capabilities.offsetEncoding = { "utf-8", "utf-16" }

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      automatic_installation = {},
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "prismals",
        "gopls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettierd",
        "prettier", -- prettier formatter
        "stylua",   -- lua formatter
        "eslint_d",
        "goimports",
        "goimports-reviser",
        "gofumpt",
      },
    })

    -- Setup each server with capabilities using vim.lsp.config (Neovim 0.11+)
    local servers = { "ts_ls", "html", "cssls", "tailwindcss", "lua_ls", "prismals", "gopls" }
    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
      })
      vim.lsp.enable(server)
    end

    local K = require("hellozimi.core.keymap")

    -- Suppress deprecation warnings from upstream plugins (telescope.nvim, treesitter)
    -- These will be fixed when the plugins update for Neovim 0.12+
    local notify = vim.notify
    vim.notify = function(msg, level, opts)
      if type(msg) == "string" and (
        msg:match("is deprecated") or
        msg:match("was removed") or
        msg:match("position_encoding param is required") or
        msg:match("attempt to call method 'range'") or
        msg:match("conceal_line")
      ) then
        return
      end
      return notify(msg, level, opts)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- -- set keybinds
        -- opts.desc = "See available code actions"
        -- K.nnoremap("<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        K.nnoremap("<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show line diagnostics"
        K.nnoremap("<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        K.nnoremap("[d", function(opts) vim.diagnostic.jump({ opts, count = -1, float = true }) end, opts) -- jump to previous diagnostic in buffer
        --
        opts.desc = "Go to next diagnostic"
        K.nnoremap("]d", function(opts) vim.diagnostic.jump({ opts, count = 1, float = true }) end, opts) -- jump to previous diagnostic in buffer
      end,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}
