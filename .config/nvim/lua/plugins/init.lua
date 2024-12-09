return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

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
    opts = function()
      return require "configs.markdown"
    end,
    -- opts = {
    --   -- configuration here or empty for defaults
    --   -- mappings = false,
    -- },
  },
  {
    -- support TODO, FIX, PERF, NOTE, FIX, WARNING
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    lazy = false,
  },
}
