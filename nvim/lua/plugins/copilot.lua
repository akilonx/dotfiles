return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Right>", -- Accept suggestion
          -- next = "<Right>", -- Move to the next suggestion using the Right Arrow key
          -- prev = "<Left>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  { "zbirenbaum/copilot-cmp", opts = {} },
  {
    -- dir = "~/projects/neovim/ChatGPT.nvim", -- Replace with the actual path to your plugin directory
    dir = "~/projects/nvim/ChatGPT.nvim", -- Replace with the actual path to your plugin directory
    name = "chatgpt", -- Optional: name to refer to the plugin
    config = function()
      -- Plugin-specific configuration
      -- require("plugin_name").setup()

      require("chatgpt").setup({
        -- this config assumes you have OPENAI_API_KEY environment variable set
        openai_params = {
          -- NOTE: model can be a function returning the model name
          -- this is useful if you want to change the model on the fly
          -- using commands
          -- Example:
          -- model = function()
          --     if some_condition() then
          --         return "gpt-4-1106-preview"
          --     else
          --         return "gpt-3.5-turbo"
          --     end
          -- end,
          -- model = "gpt-4-turbo-2024-04-09",
          -- model = "gpt-4o-2024-08-06",
          -- model = "o1-preview-2024-09-12",
          -- model = "gpt-3.5-turbo",
          model = "o1-mini-2024-09-12",
          max_tokens = 4095,
          -- max_completion_tokens = 4095,
          frequency_penalty = 0,
          presence_penalty = 0,
          temperature = 1,
          top_p = 1,
          n = 1,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim",
    },
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup({
  --       -- this config assumes you have OPENAI_API_KEY environment variable set
  --       openai_params = {
  --         -- NOTE: model can be a function returning the model name
  --         -- this is useful if you want to change the model on the fly
  --         -- using commands
  --         -- Example:
  --         -- model = function()
  --         --     if some_condition() then
  --         --         return "gpt-4-1106-preview"
  --         --     else
  --         --         return "gpt-3.5-turbo"
  --         --     end
  --         -- end,
  --         model = "o1-mini",
  --         frequency_penalty = 0,
  --         presence_penalty = 0,
  --         max_tokens = 4095,
  --         temperature = 0.2,
  --         top_p = 0.1,
  --         n = 1,
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim", -- optional
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
}
