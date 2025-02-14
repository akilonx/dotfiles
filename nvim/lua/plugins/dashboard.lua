return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
⣿⣿⣿⣿⣿⣿⢸⣿⡇⠀⣿⣿⡇⣿⣿⡇⣼⣿⣿⣿⣿⣿⠀⠀⡇⣿⣶⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀
⠉⠉⣿⣿⠉⠉⢸⣿⡇⠀⣿⣿⡃⣿⣿⡇⣿⣿⡇⠀⣿⣿⠀⠀⡇⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀
⠀⠀⣿⣿⠀⠀⢸⣿⣧⣤⣿⣿⡇⣿⣿⡇⠻⣿⣷⣦⡀⠀⠀⠀⡇⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀
⠀⠀⣿⣿⠀⠀⢸⣿⡟⠛⣿⣿⡇⣿⣿⡇⠀⠈⠻⢿⣿⣦⠀⠀⡇⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀
⠀⠀⣿⣿⠀⠀⢸⣿⡇⠀⣿⣿⡇⣿⣿⡇⣿⣿⡇⠀⣿⣿⠀⠀⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀
⠀⠀⣿⣿⠀⠀⢸⣿⡇⠀⣿⣿⡇⣿⣿⡇⣿⣿⣷⣶⣿⣿⠀⠀⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀
⠀⠀⠛⠛⠀⠀⠘⠛⠃⠀⠛⠛⠃⠛⠛⠃⠈⠛⠛⠛⠛⠋⠀⠀⠿⢟⣛⣛⣛⣛⣛⣛⣛⣛⣛⣰⡄
⣿⡇⢴⣿⣿⣿⡆⠀⢸⣿⣿⣿⣿⣿⣿⠀⣿⡇⢸⣿⣿⣿⡇⠀⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⣿⣷
⣿⡇⢸⣿⡀⠛⠃⠀⠀⠀⣿⡇⠀⣿⣿⠀⣿⡇⢸⣿⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣴⣶⣶⣶⣾⣿⣿
⣿⡇⠈⠻⢿⣶⡄⠀⠀⠀⣿⡇⠀⣿⣿⠿⣿⡇⢸⣿⠿⠿⠇⠀⠀⠀⢸⣿⣿⣿⣿⣿⡿⠛⠋⣹⡿
⣿⡇⢰⣶⡀⣿⡇⠀⠀⠀⣿⡇⠀⣿⣿⠀⣿⡇⢸⣿⣀⣀⡀⠀⠀⠀⢸⣿⣿⣿⣿⠋⠀⠀⢰⣿⡇
⠿⠇⠸⠿⠿⠿⠇⠀⠀⠀⠿⠇⠀⠿⠿⠀⠿⠇⠸⠿⠿⠿⠇⠀⠀⠀⣿⣿⣿⣿⠃⠀⠀⢠⣿⣿⡇
⣶⣶⡆⠀⣶⣶⠀⢰⣶⣶⠀⢰⣶⣶⡀⢲⣶⣦⠀⢰⣶⣶⠀⠀⠀⠀⣿⣿⣿⠃⠀⣠⣤⣿⣿⣿⠃
⢸⣿⣧⠀⣿⣿⡇⢸⣿⣿⠀⣿⣿⣿⡇⠈⣿⣿⡀⣼⣿⡏⠀⠀⠀⠀⣿⣿⡏⢀⣾⣿⣿⣿⣿⣿⠀
⢸⣿⣿⢸⣿⣿⡇⣼⣿⡇⢸⣿⡿⣿⣧⠀⢻⣿⣇⣿⣿⠁⠀⠀⠀⠀⣿⣿⠇⣼⣿⣿⣿⣿⣿⣿⠀
⠀⣿⣿⢸⣿⣿⣇⣿⣿⠇⢸⣿⡇⣿⣿⡀⠘⣿⣿⣿⡏⠀⠀⠀⠀⠀⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⠀
⠀⣿⣿⣿⣿⢿⣿⣿⣿⠀⣾⣿⠷⢿⣿⡇⠀⢻⣿⣿⠀⠀⠀⠀⠀⠀⣿⡿⣾⣿⣿⣿⣿⣿⠟⠁⠀
⠀⢸⣿⣿⡏⢸⣿⣿⡿⢰⣿⣿⠀⢸⣿⣷⠀⢸⣿⣿⠀⠀⠀⠀⠀⢀⣿⡇⣿⣿⣿⠟⠋⠀⠀⠀⠀
⠀⢸⣿⣿⡇⢸⣿⣿⡇⢸⣿⡇⠀⠀⣿⣿⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠻⡇⠟⠋⠀⠀⠀⠀⠀⠀⠀
 ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    -- config = function()
    --   -- Override highlight groups
    --   vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#ff8800", bold = true }) -- Menu keys
    --   vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#00ff88" }) -- Menu descriptions
    --   vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#8888ff" }) -- Menu icons
    -- end,
  },
}
