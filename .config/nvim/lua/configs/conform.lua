local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofmt" },
    templ = { "templ" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    sh = { "shfmt" },
    sql = { "sqlfmt" }
    -- visit https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters to see all formatters
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
