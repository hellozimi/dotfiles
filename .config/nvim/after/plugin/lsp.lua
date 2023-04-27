local K = require("smn.keymap")
local nnoremap = K.nnoremap
local inoremap = K.inoremap

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
  youtube = "[Suck it YT]",
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      -- vim.fn["vsnip#anonymous"](args.body)

      -- For `luasnip` user.
      require("luasnip").lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      local menu = source_mapping[entry.source.name]
      vim_item.menu = menu
      return vim_item
    end,
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "youtube" },
  },
})

local function config(_config)
  return vim.tbl_deep_extend("force", {
    on_attach = function()
      nnoremap("gd", function() vim.lsp.buf.definition() end)
      nnoremap("K", function() vim.lsp.buf.hover() end)
      -- nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
      nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
      nnoremap("[d", function() vim.diagnostic.goto_next() end)
      nnoremap("]d", function() vim.diagnostic.goto_prev() end)
      nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
      nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
      inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '<buffer>',
        callback = function()
          vim.lsp.buf.format()
        end
      })
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '<buffer>',
        callback = function()
          vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
        end
      })
    end,
  }, _config or {})
end

require("lspconfig").tsserver.setup(config({
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}))

require("lspconfig").cssls.setup(config())

require("lspconfig").gopls.setup(config({
  cmd = { "gopls" },
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}))

require("lspconfig").terraformls.setup{}

local opts = {
  highlight_hovered_item = true,
  show_guides = true,
}

require("symbols-outline").setup(opts)

function goimports(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

-- vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.format()]]
-- vim.cmd [[autocmd BufWritePre *.go lua goimports(1000)]]
