require "nvchad.mappings"
-- add yours here

local b = require "base46"
local map = vim.keymap.set
local unmap = vim.keymap.del

unmap("n", "<tab>")
unmap("n", "<S-tab>")

map("n", "<M-]>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<M-[>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>zk", "<cmd>NvCheatsheet<CR>")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<tab>", "    ", { noremap = true, silent = true })
map("n", "<leader>tr", function()
  b.toggle_transparency()
end, { desc = "toggle transparency" })

-- harpoon setup
local harpoon = require "harpoon"

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- i'm too lazy to figure out how to add this in another file instead
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

vim.keymap.set("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

map("n", "<leader>za", function()
  harpoon:list():add()
end, { desc = "add file (with the position) to harpoon" })

map("n", "<leader>zm", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "open harpoon menu" })

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
