return {
  -- add dracula
  {
    "Mofiqul/dracula.nvim",
    opts = {
      transparent = true,
      overrides = {
        Keyword = { italic = false }, -- Disable italics for keywords
        Function = { italic = false }, -- Disable italics for functions
        Identifier = { italic = false }, -- Disable italics for identifiers
      },
    },
  },

  -- Configure LazyVim to load dracula
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
