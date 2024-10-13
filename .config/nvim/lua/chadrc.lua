-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
local prose = require "nvim-prose"

local white = "#E5E9F0"

M.base46 = {
  theme = "tokyonight",
  changed_themes = {
    tokyonight = {
      base_16 = {
        base05 = white,
      },
    },
  },

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
  transparency = true,
}

M.ui = {
  statusline = {
    modules = {
      word_count = function()
        local wc = ""

        if prose.is_available() then
          wc = " " .. prose.word_count()
        end

        return wc
      end,
    },
    order = { "mode", "file", "git", "word_count", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
  },
}

return M
