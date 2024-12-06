return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.winbar = {
      lualine_a = {
        {
          "filename",
          path = 1, -- Use 1 for relative path, 2 for absolute path
        },
      },
    }
  end,
}
