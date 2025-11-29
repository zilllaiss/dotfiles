
return {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  extensions_list = { "themes", "terms" },
  extensions = {},

  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      -- find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*" },
      find_command = { "fd",  "--hidden", '--no-require-git' },
    },
    live_grep = {
      -- find_command = { "rg", "--hidden", "-glob", "--no-ignore", "!**/.git/*" },
      find_command = { "rg", "--hidden" },
    },
  },
}
