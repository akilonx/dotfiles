return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    -- Map <leader>lg to open LazyGit
    { "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
  },
  config = function()
    -- Optional: Configure LazyGit behavior here
  end,
}
