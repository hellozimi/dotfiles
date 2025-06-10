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

    local lspconfig = require("lspconfig")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

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
        "goimports-reviser",
        "gofumpt",
      },
    })

    local K = require("hellozimi.core.keymap")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        K.nnoremap("gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        K.nnoremap("gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        K.nnoremap("gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        K.nnoremap("gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        K.nnoremap("gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        K.nnoremap("<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
        K.vnoremap("<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        K.nnoremap("<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        K.nnoremap("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        K.nnoremap("<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        K.nnoremap("[d", function(opts) vim.diagnostic.jump({ opts, count = -1, float = true }) end, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        K.nnoremap("]d", function(opts) vim.diagnostic.jump({ opts, count = 1, float = true }) end, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        K.nnoremap("K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        K.nnoremap("<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
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
