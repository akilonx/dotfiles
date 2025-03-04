return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = {
    "AiderTerminalToggle",
    "AiderHealth",
  },
  keys = {
    { "<A-s>", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider" },
    { "<leader>as", "<cmd>AiderTerminalSend<cr>", desc = "Send to Aider", mode = { "n", "v" } },
    { "<A-z>", "<cmd>AiderQuickSendCommand<cr>", desc = "Send Command To Aider" },
    { "<leader>ab", "<cmd>AiderQuickSendBuffer<cr>", desc = "Send Buffer To Aider" },
    { "<leader>aa", "<cmd>AiderQuickAddFile<cr>", desc = "Add File to Aider" },
    { "<leader>ad", "<cmd>AiderQuickDropFile<cr>", desc = "Drop File from Aider" },
    { "<leader>ar", "<cmd>AiderQuickReadOnlyFile<cr>", desc = "Add File as Read-Only" },
    -- Example nvim-tree.lua integration if needed
    { "<leader>at", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
    { "<leader>aT", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
  },
  dependencies = {
    "folke/snacks.nvim",
    --- The below dependencies are optional
    -- "catppuccin/nvim",
    "nvim-tree/nvim-tree.lua",
  },
  config = function()
    require("nvim_aider").setup({
      defaults = {},
      setup = {},
      options = {},
      args = {
        "--edit-format",
        "udiff",
        "--editor-edit-format",
        "editor-diff",
        "--chat-mode",
        "architect",
        "--architect",
        "--model",
        "gemini/gemini-2.0-flash-thinking-exp",
        "--editor-model",
        "gemini/gemini-2.0-flash",
        "--multiline",
        "--cache-prompts",
        "--no-auto-commits",
        "--pretty",
        "--stream",
        "--watch-files",
        "--dark-mode",
        "--check-update",
        -- "--yes", -- Automatically accept all file edits
        "--read",
        "CONVENTIONS.md",
        "TEMPLATES.md",
      },
      -- Theme colors (automatically uses Catppuccin flavor if available)
      theme = {
        user_input_color = "#a6da95",
        tool_output_color = "#8aadf4",
        tool_error_color = "#ed8796",
        tool_warning_color = "#eed49f",
        assistant_output_color = "#c6a0f6",
        completion_menu_color = "#cad3f5",
        completion_menu_bg_color = "#24273a",
        completion_menu_current_color = "#181926",
        completion_menu_current_bg_color = "#f4dbd6",
      },
      -- snacks.picker.layout.Config configuration
      picker_cfg = {
        preset = "vscode",
      },
      -- Other snacks.terminal.Opts options
      config = {
        os = { editPreset = "nvim-remote" },
        gui = { nerdFontsVersion = "3" },
      },
      win = {
        wo = { winbar = "Aider" },
        style = "nvim_aider",
        position = "right",
      },
      settings = {
        available_options = { "defaults", "setup", "options", "args", "theme", "picker_cfg", "config", "win" },
        available_defaults = {
          -- Add default values if available (currently empty)
        },
        available_commands = {
          "AiderTerminalToggle",
          "AiderHealth",
          "AiderQuickSendCommand",
          "AiderQuickSendBuffer",
          "AiderQuickAddFile",
          "AiderQuickDropFile",
          "AiderQuickReadOnlyFile",
          "AiderTreeAddFile",
          "AiderTreeDropFile",
        },
      },
    })
  end,
}
