return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  { import = "nvchad.blink.lazyspec" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "go",
        "templ",
        "zig",
        "sql",
        "javascript",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "staticcheck",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.nvim-tree",
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "Wansmer/treesj",
    keys = { "<space>j" },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require "configs.treesj"
    end,
    lazy = false,
  },
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --       return require("configs.flash")
  --   end,
  -- },
  {
    -- cheatsheet: ysiw<char> to surround and ds<char> to delete
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    -- word_count(), is_available() for current filetype
    "skwee357/nvim-prose",
    config = function()
      require("nvim-prose").setup {}
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    opts = {},
    config = function()
      require("render-markdown").setup {}
    end,
    lazy = false,
  },
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown", -- or 'event = "VeryLazy"'
    opts = require "configs.markdown",
  },
  {
    -- support TODO, FIX, PERF, NOTE, FIX, WARNING, BUG
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    lazy = false,
  },
  {
    "karb94/neoscroll.nvim",
    opts = { duration_multiplier = 0.5 },
    lazy = false,
  },
  {
    -- NOTE: you can delete tag with vim-surround (dst)
    "windwp/nvim-ts-autotag",
    lazy = false,
    opts = {
      -- -- Defaults
      -- enable_close = true, -- Auto close tags
      -- enable_rename = true, -- Auto rename pairs of tags
      -- enable_close_on_slash = false, -- Auto close on trailing </
    },
  },
}
