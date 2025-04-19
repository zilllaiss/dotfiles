require("nvchad.configs.lspconfig").defaults()

local servers = {
  "ts_ls",
  "cssls",
  "basedpyright",
  "svelte",
  "templ",
  "bashls",
  "gopls",
  "emmet_language_server",
  "html",
  "zls",
  "yamlls",
  -- "tailwindcss",
}

vim.lsp.enable(servers)

vim.lsp.config("html", { filetypes = { "html", "gotmpl" } })
vim.lsp.config("emmet_language_server", { filetypes = { "html", "gotmpl", "templ" } })

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      completeUnimported = true,
      gofumpt = true,
      staticcheck = true,
      -- usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      hints = {
        assignVariableTypes = true,
        constantValues = true,
      },
    },
  },
})

vim.lsp.config("yamlls", {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },

  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemas = {
        ["https://taskfile.dev/schema.json"] = { "**/Taskfile.yml" },
      },
    },
  },
})
