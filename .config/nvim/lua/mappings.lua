require "nvchad.mappings"

local b = require "base46"
local map = vim.keymap.set
local unmap = vim.keymap.del

require "configs.arabic"

local tab = require "nvchad.tabufline"

require "configs.harpoon"
require "configs.slint"

map("n", "<M-.>", function()
  tab.move_buf(1)
end, { desc = "move buffer to the right" })

map("n", "<M-,>", function()
  tab.move_buf(-1)
end, { desc = "move buffer to the left" })

map("n", "<M-j>", "<C-d>")
map("n", "<M-k>", "<C-u>")

unmap("n", "<leader>h")
unmap("n", "<space>e")
-- unmap("n", "<space>m")

map({ "n", "i" }, "<M-]>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map({ "n", "i" }, "<M-[>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

-- custom

map("n", "<leader>zk", "<cmd>NvCheatsheet<CR>")
map("n", "<leader>zl", "<cmd>LspRestart<CR>", { desc = "Restart your janky LSP" })
map("i", "jk", "<ESC>")
map("i", "<tab>", "    ", { noremap = true, silent = true })
map("n", "<leader>tr", function()
  b.toggle_transparency()
end, { desc = "toggle transparency" })
map("n", "<leader>wr", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })
map("n", "<leader>zts", "<cmd>LspStop tailwindcss<CR>", { desc = "Stop your janky tailwindcss LSP" })
map(
  "n",
  "<leader>ztp",
  "<cmd>LspStart tailwindcss<CR>",
  { desc = "Start your janky tailwindcss LSP and make your editor slow" }
)
map("n", "<leader>ca", function ()
    vim.lsp.buf.code_action()
end, { desc = "Code action show"})

-- todo list

map("n", "<leader>ta", "<cmd>TodoLocList<CR>", { desc = "Show all todo" })
map("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "Search todos with Telescope" })

-- telesecope

local telescope = require "telescope.builtin"

map("n", "<leader>f'", function()
  telescope.marks {}
end, { desc = "search vim marks" })

-- this is need so telescope actually respect configs.telescope
map("n", "<leader>fa", function ()
    telescope.find_files()
end)

map("n", "<leader>fw", function ()
    telescope.live_grep()
end)

-- blink

-- local blink = require "blink.cmp"

-- map("i", "<M-q>", function ()
--     blink.select_prev()
-- end)
--
-- map("i", "<M-e>", function ()
--     blink.select_next()
-- end)
--
