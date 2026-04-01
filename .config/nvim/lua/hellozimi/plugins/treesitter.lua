return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- Use main branch for Neovim 0.12+ support
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- Install required parsers (the main branch uses install() method)
    local install = require("nvim-treesitter").install

    -- Install all required parsers
    install({
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "prisma",
      "go",
      "markdown",
      "markdown_inline",
      "svelte",
      "graphql",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
      "vimdoc",
      "c",
    })

    -- Enable treesitter highlighting for all filetypes via autocmd
    -- This is the new way in the main branch
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "go",
        "markdown",
        "svelte",
        "graphql",
        "sh",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "c",
      },
      callback = function(args)
        local bufnr = args.buf
        local buf_name = vim.api.nvim_buf_get_name(bufnr)

        -- Skip large files (> 100KB)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, buf_name)
        if ok and stats and stats.size > max_filesize then
          return
        end

        -- Start treesitter highlighting
        vim.treesitter.start(bufnr)
      end,
    })

    -- Enable treesitter-based indentation
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "go",
        "markdown",
        "svelte",
        "graphql",
        "sh",
        "lua",
        "vim",
        "dockerfile",
        "c",
      },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- Setup autotag
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    })

    -- Setup incremental selection keymaps via treesitter API
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "go",
        "markdown",
        "svelte",
        "graphql",
        "sh",
        "lua",
        "vim",
        "dockerfile",
        "c",
      },
      callback = function(args)
        local bufnr = args.buf

        -- Set up incremental selection keymaps
        local function incremental_selection_init()
          require("nvim-treesitter.incremental_selection").init_selection(bufnr)
        end

        local function incremental_selection_node()
          require("nvim-treesitter.incremental_selection").node_incremental(bufnr)
        end

        local function incremental_selection_scope()
          require("nvim-treesitter.incremental_selection").scope_incremental(bufnr)
        end

        local function incremental_selection_node_dec()
          require("nvim-treesitter.incremental_selection").node_decremental(bufnr)
        end

        -- Set keymaps for this buffer only
        vim.keymap.set("n", "<C-space>", incremental_selection_init, { buffer = bufnr, silent = true, desc = "Start incremental selection" })
        vim.keymap.set("x", "<C-space>", incremental_selection_node, { buffer = bufnr, silent = true, desc = "Increment to next node" })
        vim.keymap.set("x", "<bs>", incremental_selection_node_dec, { buffer = bufnr, silent = true, desc = "Decrement to previous node" })
      end,
    })
  end,
}
