require "nvchad.mappings"

local b = require "base46"
local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", "<M-j>", "<C-d>")
map("n", "<M-k>", "<C-u>")

unmap("n", "<tab>")
unmap("n", "<S-tab>")

unmap("n", "<leader>h")
unmap("n", "<space>e")
-- unmap("n", "<space>m")

require("configs.harpoon")

map("n", "<M-]>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<M-[>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>zk", "<cmd>NvCheatsheet<CR>")
map("n", "<leader>zl", "<cmd>LspRestart<CR>", { desc = "Restart your junky LSP" })
map("i", "jk", "<ESC>")
map("i", "<tab>", "    ", { noremap = true, silent = true })
map("n", "<leader>tr", function()
  b.toggle_transparency()
end, { desc = "toggle transparency" })
map("n", "<leader>wr", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })

map("n", "<leader>ta", "<cmd>TodoLocList<CR>", { desc = "Show all todo" })
map("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "Search todos with Telescope" })
