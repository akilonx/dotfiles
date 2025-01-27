return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  keys = function(_, keys)
    ---@type avante.Config
    local opts =
      require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

    local mappings = {
      {
        opts.mappings.ask,
        function()
          require("avante.api").toggle()
        end,
        desc = "avante: ask",
        mode = { "n", "v", "i" },
      },
      {
        opts.mappings.refresh,
        function()
          require("avante.api").refresh()
        end,
        desc = "avante: refresh",
        mode = "v",
      },
      {
        opts.mappings.edit,
        function()
          require("avante.api").edit()
        end,
        desc = "avante: edit",
        mode = { "n", "v" },
      },
      {
        opts.mappings.focus,
        function()
          require("avante.api").focus()
        end,
        desc = "avante: focus",
        mode = { "n", "v", "i" },
      },
    }
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    -- add any opts here
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = true, -- Experimental stage
      auto_suggestions_respect_ignore = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      jump_result_buffer_on_finish = true,
      support_paste_from_clipboard = true,
      minimize_diff = true,
    },
    repo_map = {
      ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules", "venv", ".turbo" }, -- ignore files matching these
      negate_patterns = {}, -- negate ignore files matching these.
    },
    mappings = {
      ask = "<M-a>", -- Alt + a to ask
      edit = "<M-e>", -- Alt + e to edit
      refresh = "<M-s>", -- leader + ar to refresh
      focus = "<M-f>", -- leader + ar to refresh
      diff = {
        ours = "o",
        theirs = "t",
        all_theirs = "a",
        both = "b",
        cursor = "c",
        next = "]",
        prev = "[",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]",
        prev = "[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-CR>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
        remove_file = "d",
        add_file = "a",
      },
      files = {
        add_current = "<M-e>", -- Add current buffer to selected files
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {

      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        hints = { enabled = true },
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
