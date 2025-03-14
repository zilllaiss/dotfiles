local map = vim.keymap.set

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

return {}
