return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
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
    -- REQUIRED

    -- vim.keymap.del("n", "<C-f>")

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- local wk = require("which-key")
    -- wk.add({
    --   {
    --     "<C-f>",
    --     function()
    --       harpoon:list():select(1)
    --     end,
    --     desc = "Harpoon 1",
    --     mode = "n",
    --   },
    -- })

    vim.keymap.set("n", "<C-f>", function()
      harpoon:list():select(1)
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-d>", function()
      harpoon:list():select(2)
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-t>", function()
      harpoon:list():select(3)
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-n>", function()
      harpoon:list():select(4)
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-y>", function()
      harpoon:list():select(5)
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-u>", function()
      harpoon:list():select(6)
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-i>", function()
      harpoon:list():select(7)
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-o>", function()
      harpoon:list():select(8)
    end, { noremap = true, silent = true })

    -- Toggle previous & next buffers stored within Harpoon list
    -- vim.keymap.set("n", "<C-S-P>", function()
    --   harpoon:list():prev()
    -- end)
    -- vim.keymap.set("n", "<C-S-N>", function()
    --   harpoon:list():next()
    -- end)

    require("telescope").load_extension("harpoon") -- Load Telescope integration
  end,
}
