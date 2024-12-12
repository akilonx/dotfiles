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
keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>")

-- delete a word backwords
keymap.set("n", "dw", "vb_d")

-- select automatically
keymap.set("n", "<C-a>", "gg<S-v>G")

-- jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

--split window
keymap.set("n", "<A-/>", ":split<Return>", opts)

-- Telescope keymap for file search without hidden files
keymap.set("n", "<C-p>", function()
  require("telescope.builtin").find_files({
    hidden = false, -- Disable hidden files
  })
end, { noremap = true, silent = true, desc = "Find Files (No Hidden Files)" })

-- Telescope keymap for file search with hidden files
keymap.set("n", "<S-C-p>", function()
  require("telescope.builtin").find_files({
    hidden = true, -- Include hidden files
    file_ignore_patterns = { "node_modules", ".git/" }, -- Exclude `node_modules` and `.git`
    layout_config = {
      prompt_position = "top", -- Input box at the top
    },
    sorting_strategy = "ascending", -- Results sorted from top to bottom
  })
end, opts)

-- Telescope live_grep for the current working directory
keymap.set("n", "<A-r>", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--no-hidden", "--glob=!.git/", "--glob=!node_modules/**", "--glob=!dist/**" }
    end,
  })
end, opts)

-- Key mapping for Telescope grep_string in Normal Mode
keymap.set("n", "g/", function()
  require("telescope.builtin").grep_string({
    search = vim.fn.expand("<cword>"), -- Word under the cursor
    additional_args = function()
      return { "--no-hidden" } -- Exclude hidden files
    end,
  })
end, { noremap = true, silent = true, desc = "Search word under cursor in CWD" })

vim.keymap.set("v", "g/", function()
  -- Get the visually selected text
  local function get_visual_selection()
    vim.cmd('noau normal! "vy"') -- Yank visual selection into the unnamed register
    return vim.fn.getreg("v") -- Retrieve the yanked text
  end

  local search_text = get_visual_selection()

  require("telescope.builtin").grep_string({
    search = search_text, -- Search for the visually selected text
    additional_args = function()
      return { "--no-hidden" } -- Exclude hidden files
    end,
  })
end, { noremap = true, silent = true, desc = "Search visual selection in CWD" })

-- Map <Tab> to show all opened files using Telescope
keymap.set("n", "<Tab>", function()
  vim.api.nvim_command("stopinsert") -- Force normal mode
  require("telescope.builtin").buffers({
    sort_lastused = true, -- Sort buffers by last used
    ignore_current_buffer = true, -- Do not show the current buffer
  })
end, opts)

-- Show last telescope window
vim.keymap.set("n", "<leader><leader>", function()
  require("telescope.builtin").resume()
end, { noremap = true, silent = true, desc = "Resume last Telescope picker" })

-- Harpoon keybindings
keymap.set("n", "<leader>a", function()
  require("harpoon.mark").add_file()
end, { desc = "Add file to Harpoon", noremap = true, silent = true })

keymap.set("n", "<C-e>", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "Open Harpoon Menu", noremap = true, silent = true })

local function file_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  else
    return false
  end
end

-- Helper function to safely navigate to Harpoon files
local function safe_nav_file(index)
  local harpoon_ui = require("harpoon.ui")
  local harpoon_mark = require("harpoon.mark")
  local mark = harpoon_mark.get_marked_file(index)

  if mark and file_exists(mark.filename) then
    -- If the file exists, navigate to it
    vim.cmd("edit " .. mark.filename)
    harpoon_ui.nav_file(index)
  else
    -- File does not exist or is invalid
    print("File does not exist or is not open!")
  end
end

-- Navigate between Harpoon files
keymap.set("n", "<C-f>", function()
  safe_nav_file(1)
end, { desc = "Go to Harpoon File 1", noremap = true, silent = true })

keymap.set("n", "<C-d>", function()
  safe_nav_file(2)
end, { desc = "Go to Harpoon File 2", noremap = true, silent = true })

keymap.set("n", "<C-t>", function()
  safe_nav_file(3)
end, { desc = "Go to Harpoon File 3", noremap = true, silent = true })

keymap.set("n", "<C-n>", function()
  safe_nav_file(4)
end, { desc = "Go to Harpoon File 4", noremap = true, silent = true })

keymap.set("n", "<C-m>", function()
  safe_nav_file(5)
end, { desc = "Go to Harpoon File 5", noremap = true, silent = true })

keymap.set("n", "<C-y>", function()
  safe_nav_file(6)
end, { desc = "Go to Harpoon File 6", noremap = true, silent = true })

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")

vim.cmd([[
  highlight Comment cterm=NONE gui=NONE
  highlight Keyword cterm=NONE gui=NONE
  highlight Function cterm=NONE gui=NONE
  highlight Identifier cterm=NONE gui=NONE
]])

-- Comment
keymap.set("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", opts)
keymap.set("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", opts)

-- { "gs", "<cmd>Git<CR>", desc = "Git status" },
-- { "gc", "<cmd>Git commit<CR>", desc = "Git commit" },
-- { "gp", "<cmd>Git push<CR>", desc = "Git push" },
-- { "gl", "<cmd>Git pull<CR>", desc = "Git pull" },
-- { "gB", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
-- { "gb", "<cmd>Git blame<CR>", desc = "Git blame" },

-- Open Fugitive status
keymap.set("n", "gs", ":G<CR>", { noremap = true, silent = true, desc = "Git status (Fugitive)" })

-- Diff between HEAD and working directory
keymap.set(
  "n",
  "ga",
  ":Gdiffsplit<CR>",
  { noremap = true, silent = true, desc = "Git diff (HEAD vs working directory)" }
)

-- Blame the current file
keymap.set("n", "gb", ":Git blame<CR>", { noremap = true, silent = true, desc = "Git blame (Fugitive)" })

-- Open Git commit log for the current file
keymap.set("n", "gl", ":Git log --oneline<CR>", { noremap = true, silent = true, desc = "Git log (oneline)" })

-- Diff against a specific revision
-- keymap.set("n", "gA", ":Git diff ", { noremap = true, silent = true, desc = "Git diff against revision" })
keymap.set("n", "gA", function()
  vim.ui.input({ prompt = "Enter revision: " }, function(input)
    if input then
      vim.cmd("Gdiffsplit " .. input)
    end
  end)
end, { noremap = true, silent = true, desc = "Git diff against revision" })

-- View the commit for the line under the cursor (in blame)
keymap.set(
  "n",
  "go",
  ":Git show <C-R>=expand('<cword>')<CR><CR>",
  { noremap = true, silent = true, desc = "Open commit from blame" }
)

-- lsp code action
keymap.set("n", "<C-.>", ":CodeActionMenu<CR>", { noremap = true, silent = true, desc = "LSP: Code Action Menu" })
