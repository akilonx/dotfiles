-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
-- turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- fix conceallevel for json files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufFilePost" }, {
  callback = function()
    --if not vim.bo.buflisted then
    --  vim.cmd("setlocal buflisted")
    --end
    if vim.bo.filetype ~= "" and vim.fn.expand("%:p") ~= "" then
      -- Set the winbar to show the file name
      vim.opt_local.winbar = "%=%f%=" -- Centered filename
    else
      -- Clear winbar for non-file buffers
      vim.opt_local.winbar = nil
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*", -- Apply to all files, or specify filetypes like "*.js,*.ts"
  callback = function()
    vim.lsp.buf.format({ async = false }) -- Use async=false for blocking format before save
  end,
})
