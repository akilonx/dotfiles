-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.snacks_animate = false
vim.opt.shada = ""
vim.g.copilot_filetypes = { ["*"] = true }
vim.g.lazyvim_eslint_auto_format = true
vim.opt.swapfile = false
vim.g.lazyvim_format_on_save = true

vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#ff79c6", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#8be9fd", bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#50fa7b", bg = "NONE" })
vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#f8f8f2", bg = "NONE" })
