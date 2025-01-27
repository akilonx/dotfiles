-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "H", "30<C-U>zz", opts)
keymap.set("n", "L", "30<C-D>zz", opts)
keymap.set("n", "<A-j>", ":bnext<CR>", opts)
keymap.set("n", "<A-k>", ":bprev<CR>", opts)
keymap.set("n", "<A-q>", ":bd<CR>", opts)
keymap.set("n", "<C-q>", ":qa<CR>", opts)
--keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>")
--
local function custom_rename()
  local current_name = vim.fn.expand("<cword>") -- Get the current word under the cursor
  vim.ui.input({ prompt = "Rename to: ", default = current_name }, function(new_name)
    if new_name and new_name ~= "" and new_name ~= current_name then
      vim.lsp.buf.rename(new_name)
    end
  end)
end

keymap.set("n", "<leader>re", custom_rename, opts)

-- delete a word backwords
keymap.set("n", "dw", "vb_d")

-- select automatically
keymap.set("n", "<C-a>", "gg<S-v>G")

-- jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- split window
keymap.set("n", "<A-/>", ":vsplit<Return>", opts)
keymap.set("n", "<A-c>", ":close<Return>", opts)

-- comments
keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", opts)
keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", opts)

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")

vim.cmd([[
  highlight Comment cterm=NONE gui=NONE
  highlight Keyword cterm=NONE gui=NONE
  highlight Function cterm=NONE gui=NONE
  highlight Identifier cterm=NONE gui=NONE
]])

-- ChatGPT Keymaps
-- keymap.set("n", "<leader>vv", ":ChatGPT<CR>", opts)
-- keymap.set("v", "<leader>vv", ":ChatGPT<CR>", opts)
-- keymap.set("v", "<leader>ve", ":'<,'>ChatGPTEditWithInstruction<CR>", opts)
-- keymap.set("v", "<leader>vg", ":'<,'>ChatGPTRun grammar_correction<CR>", opts)
-- keymap.set("v", "<leader>vt", ":'<,'>ChatGPTRun translate<CR>", opts)
-- keymap.set("v", "<leader>vk", ":'<,'>ChatGPTRun keywords<CR>", opts)
-- keymap.set("v", "<leader>vd", ":'<,'>ChatGPTRun docstring<CR>", opts)
-- keymap.set("v", "<leader>va", ":'<,'>ChatGPTRun add_tests<CR>", opts)
-- keymap.set("v", "<leader>vo", ":'<,'>ChatGPTRun optimize_code<CR>", opts)
-- keymap.set("v", "<leader>vs", ":'<,'>ChatGPTRun summarize<CR>", opts)
-- keymap.set("v", "<leader>vf", ":'<,'>ChatGPTRun fix_bugs<CR>", opts)
-- keymap.set("v", "<leader>vx", ":'<,'>ChatGPTRun explain_code<CR>", opts)
-- keymap.set("v", "<leader>vr", ":'<,'>ChatGPTRun roxygen_edit<CR>", opts)
-- keymap.set("v", "<leader>vl", ":'<,'>ChatGPTRun code_readability_analysis<CR>", opts)

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({
  global_settings = {
    save_on_toggle = true,
    save_on_change = true,
    -- enter_on_sendcmd = false,
    -- tmux_autoclose_windows = false,
    excluded_filetypes = { "harpoon" },
  },
})

vim.keymap.set("n", "<C-f>", function()
  harpoon:list():select(1)
end, opts)

-- Map Alt-Left to backward jump (default <C-o>)
vim.keymap.set("n", "<M-Left>", "<C-o>", { desc = "Jump backward" })

-- Map Alt-Right to forward jump (default <C-i>)
vim.keymap.set("n", "<M-Right>", "<C-i>", { desc = "Jump forward" })
