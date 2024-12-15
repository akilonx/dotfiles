return {
  "zbirenbaum/copilot.lua",
  opts = {
    panel = {
      enabled = true,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<CR>", -- Set Enter to confirm suggestions
        next = "<C-j>", -- Navigate to the next suggestion
        prev = "<C-k>", -- Navigate to the previous suggestion
        dismiss = "<C-l>", -- Dismiss the suggestion
      },
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)

    -- Attach Copilot to all buffers
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        vim.defer_fn(function()
          vim.cmd("Copilot auth")
          vim.cmd("Copilot enable")
        end, 100)
      end,
    })
  end,
}
