-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local dracula = require("dracula")
dracula.setup({
  -- customize dracula color palette
  colors = {
    bg = "#282A36",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#ff7eb6",
    yellow = "#8a3ffc",
    green = "#08bdba",
    -- green = "#50fa7b",
    purple = "#BD93F9",
    -- purple = "#BD93F9",
    cyan = "#4589ff",
    pink = "#4589ff",
    -- pink = "#888888",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    bright_magenta = "#FF92DF",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
    menu = "#21222C",
    visual = "#3E4452",
    gutter_fg = "#4B5263",
    nontext = "#3B4048",
    white = "#fff1f1",
    black = "#191A21",
  },

  -- local dracula = require("dracula")

  -- dracula.setup({
  --   -- customize dracula color palette
  --   colors = {
  --     bg = "#282A36",
  --     fg = "#F8F8F2",
  --     selection = "#44475A",
  --     comment = "#6272A4",
  --     red = "#FF5555",
  --     orange = "#ebbcba",
  --     yellow = "#F1FA8C",
  --     green = "#50fa7b",
  --     purple = "#908caa",
  --     cyan = "#9ccfd8",
  --     pink = "#31748f",
  --     bright_red = "#FF6E6E",
  --     bright_green = "#69FF94",
  --     bright_yellow = "#FFFFA5",
  --     bright_blue = "#D6ACFF",
  --     bright_magenta = "#FF92DF",
  --     bright_cyan = "#A4FFFF",
  --     bright_white = "#FFFFFF",
  --     menu = "#21222C",
  --     visual = "#3E4452",
  --     gutter_fg = "#4B5263",
  --     nontext = "#3B4048",
  --     white = "#ABB2BF",
  --     black = "#191A21",
  --   },
  -- show the '~' characters after the end of buffers
  show_end_of_buffer = true, -- default false
  -- use transparent background
  transparent_bg = true, -- default false
  -- set custom lualine background color
  lualine_bg_color = "#44475a", -- default nil
  -- set italic comment
  italic_comment = true, -- default false
  -- overrides the default highlights with table see `:h synIDattr`
  overrides = {},
  -- You can use overrides as table like this
  -- overrides = {
  --   NonText = { fg = "white" }, -- set NonText fg to white
  --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
  --   Nothing = {} -- clear highlight of Nothing
  -- },
  -- Or you can also use it like a function to get color from theme
  -- overrides = function (colors)
  --   return {
  --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
  --   }
  -- end,
})

vim.cmd([[colorscheme dracula]])

vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#007d79", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#007d79", bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#007d79", bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#007d79", bg = "NONE" })
