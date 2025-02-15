return {
  -- add dracula
  -- {
  --   "olivercederborg/poimandres.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("poimandres").setup({
  --       -- leave this setup function empty for default config
  --       -- or refer to the configuration section
  --       -- for configuration options
  --     })
  --   end,
  --
  --   -- optionally set the colorscheme within lazy config
  --   -- init = function()
  --   --   vim.cmd("colorscheme poimandres")
  --   -- end
  -- },
  -- { "Abstract-IDE/Abstract-cs" },
  -- { "projekt0n/github-nvim-theme", name = "github-theme" },
  -- { "rose-pine/neovim", name = "rose-pine" },
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
    setup = function() end,
    --   {
    --     { "shaunsingh/oxocarbon.nvim", run = "./install.sh" },
    --     -- "nyoom-engineering/oxocarbon.nvim",
    --     -- Add in any other configuration;
    --     --   event = foo,
    --     --   config = bar
    --     --   end,
    --   },
    --   { "rebelot/kanagawa.nvim" },
  },
  -- { "aliqyan-21/darkvoid.nvim" },
  -- {
  --   "Verf/deepwhite.nvim",
  --   dir = "~/projects/nvim/deepwhite.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- Configure LazyVim to load dracula
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "github_dark",
      -- colorscheme = "rose-pine",
      -- colorscheme = "kanagawa",
      colorscheme = "dracula",
      -- colorscheme = "oxocarbon",
      -- colorscheme = "deepwhite",
    },
  },
}
