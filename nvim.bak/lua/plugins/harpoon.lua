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

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set("n", "<C-f>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<C-d>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<C-t>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<C-n>", function()
      harpoon:list():select(4)
    end)
    vim.keymap.set("n", "<C-m>", function()
      harpoon:list():select(5)
    end)
    vim.keymap.set("n", "<C-y>", function()
      harpoon:list():select(6)
    end)

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
