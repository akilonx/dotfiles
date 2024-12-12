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
}
