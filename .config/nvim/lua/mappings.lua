require "nvchad.mappings"

local b = require "base46"
local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", "<M-j>", "<C-d>")
map("n", "<M-k>", "<C-u>")

-- forcing myself to use harpoon as it is more efficient that way
unmap("n", "<tab>")
unmap("n", "<S-tab>")

unmap("n", "<leader>h")
unmap("n", "<space>e")

-- map("n", "<M-]>", function()
--   require("nvchad.tabufline").next()
-- end, { desc = "buffer goto next" })
--
-- map("n", "<M-[>", function()
--   require("nvchad.tabufline").prev()
-- end, { desc = "buffer goto prev" })

map("n", "<leader>e", require("treesj").toggle, { desc = "Toggle tree"})

map("n", "<leader>zk", "<cmd>NvCheatsheet<CR>")
map("n", "<leader>zl", "<cmd>LspRestart<CR>", { desc = "Restart your junky LSP" })
map("i", "jk", "<ESC>")
map("i", "<tab>", "    ", { noremap = true, silent = true })
map("n", "<leader>tr", function()
  b.toggle_transparency()
end, { desc = "toggle transparency" })
map("n", "<leader>wr", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap"})

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

map("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "add file (with the position) to harpoon" })

map("n", "<leader>hh", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "open harpoon menu" })

map("n", "<leader>h1", function()
  harpoon:list():select(1)
end)
map("n", "<leader>h2", function()
  harpoon:list():select(2)
end)
map("n", "<leader>h3", function()
  harpoon:list():select(3)
end)
map("n", "<leader>h4", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<M-[>", function()
  harpoon:list():prev()
end)
map("n", "<M-]>", function()
  harpoon:list():next()
end)

-- -- Flash
-- local flash = require "flash"
--
-- map({ "n", "x", "o" }, "s", function()
--   flash.jump()
-- end, { desc = "Flash" })
--
-- map({ "n", "x", "o" }, "S", function()
--   flash.treesitter()
-- end, { desc = "Flash" })
--
-- map("o", "r", function()
--   flash.remote()
-- end, { desc = "Remote Flash" })
--
-- map({ "o", "x" }, "R", function()
--   flash.treesitter_search()
-- end, { desc = "Treesitter Search" })
--
-- map("c", "<c-s>", function()
--   flash.toggle()
-- end, { desc = "Toggle Flash Search" })
