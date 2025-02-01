local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofumpt" },
    -- templ formatter is really janky
    templ = { lsp_format = "never" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    sh = { "shfmt" },
    -- visit https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters to see all formatters
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1500,
    lsp_fallback = true,
  },
}

return options
