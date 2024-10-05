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

map("n", "<leader>zha", function()
  harpoon:list():add()
end, { desc = "add file (with the position) to harpoon" })

map("n", "<leader>zhm", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "open harpoon menu" })

map("n", "<leader>zh1", function()
  harpoon:list():select(1)
end)
map("n", "<leader>zh2", function()
  harpoon:list():select(2)
end)
map("n", "<leader>zh3", function()
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

-- Flash
local flash = require "flash"

map({ "n", "x", "o" }, "s", function()
  flash.jump()
end, { desc = "Flash" })

map({ "n", "x", "o" }, "S", function()
  flash.treesitter()
end, { desc = "Flash" })

map("o", "r", function()
  flash.remote()
end, { desc = "Remote Flash" })

map({ "o", "x" }, "R", function()
  flash.treesitter_search()
end, { desc = "Treesitter Search" })

map("c", "<c-s>", function()
  flash.toggle()
end, { desc = "Toggle Flash Search" })
