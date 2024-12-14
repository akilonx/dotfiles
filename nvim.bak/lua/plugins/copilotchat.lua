return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options

      prompts = {
        Explain = "Breakdown sections of the code and explain step by step with short words and code example",
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
