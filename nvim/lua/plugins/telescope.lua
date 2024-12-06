return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      layout_config = {
        prompt_position = "top", -- Moves the input text to the top
      },
      sorting_strategy = "ascending", -- Ensures results are sorted from top to bottom
      cwd = vim.fn.getcwd(),
      vimgrep_arguments = {
        "rg",
        "--hidden", -- Include hidden files
        "--no-ignore", -- Do not respect .gitignore or other ignore files
        "--glob=!.git/*", -- Exclude .git directory
        "--glob=!node_modules/*", -- Exclude node_modules directory
        "--column",
        "--line-number",
        "--no-heading",
        "--color=never",
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)

    -- Make Telescope's background transparent
    local set_hl = vim.api.nvim_set_hl
    set_hl(0, "TelescopeNormal", { bg = "NONE" })
    set_hl(0, "TelescopeBorder", { bg = "NONE" })
    set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
    set_hl(0, "TelescopePromptBorder", { bg = "NONE" })
    set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
    set_hl(0, "TelescopePreviewBorder", { bg = "NONE" })
    set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
    set_hl(0, "TelescopeResultsBorder", { bg = "NONE" })
  end,
}
