return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = false, -- Disable gitsigns
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      { "gs", "<cmd>Git<CR>", desc = "Git status" },
      { "gc", "<cmd>Git commit<CR>", desc = "Git commit" },
      { "gp", "<cmd>Git push<CR>", desc = "Git push" },
      { "gl", "<cmd>Git pull<CR>", desc = "Git pull" },
      { "gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
      { "gb", "<cmd>Git blame<CR>", desc = "Git blame" },
    },
  },
}
