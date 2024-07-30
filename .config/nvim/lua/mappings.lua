require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- harpoon setup
local harpoon = require "harpoon"

-- REQUIRED
harpoon:setup()
-- REQUIRED

map("n", "<leader>za", function()
  harpoon:list():add()
end)
map("n", "<leader>zm", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

map("n", "<leader>z1", function()
  harpoon:list():select(1)
end)
map("n", "<leader>z2", function()
  harpoon:list():select(2)
end)
map("n", "<leader>z3", function()
  harpoon:list():select(3)
end)
map("n", "<leader>z4", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-S-P>", function()
  harpoon:list():prev()
end)
map("n", "<C-S-N>", function()
  harpoon:list():next()
end)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
