-- harpoon setup
local harpoon = require "harpoon"
local map = vim.keymap.set
local unmap = vim.keymap.del

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- basic telescope configuration
-- local conf = require("telescope.config").values
-- local function toggle_telescope(harpoon_files)
--   local file_paths = {}
--   for _, item in ipairs(harpoon_files.items) do
--     table.insert(file_paths, item.value)
--   end
--
--   require("telescope.pickers")
--     .new({}, {
--       prompt_title = "Harpoon",
--       finder = require("telescope.finders").new_table {
--         results = file_paths,
--       },
--       previewer = conf.file_previewer {},
--       sorter = conf.generic_sorter {},
--     })
--     :find()
-- end
--
-- map("n", "<C-e>", function()
--   toggle_telescope(harpoon:list())
-- end, { desc = "Open harpoon window" })

map("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "add file (with the position) to harpoon" })

unmap("n", "<M-h>")

map("n", "<M-h>", function()
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
map("n", "<S-M-[>", function()
  harpoon:list():prev()
end)

map("n", "<S-M-]>", function()
  harpoon:list():next()
end)
