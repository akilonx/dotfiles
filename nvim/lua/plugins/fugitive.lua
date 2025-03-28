return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = false, -- Disable gitsigns
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    enabled = true,
    keys = {
      { "gs", "<cmd>Git<CR>", desc = "Git status" },
      { "gc", "<cmd>Git commit<CR>", desc = "Git commit" },
      { "gp", "<cmd>Git push<CR>", desc = "Git push" },
      { "gl", "<cmd>Git pull<CR>", desc = "Git pull" },
      { "<leader>gs", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
      { "<leader>gB", "<cmd>Git blame<CR>", desc = "Git blame" },
    },
  },
}
