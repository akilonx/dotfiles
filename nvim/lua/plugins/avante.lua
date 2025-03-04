return {
  "yetone/avante.nvim",
  dir = "~/projects/nvim/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  keys = function(_, keys)
    ---@type avante.Config
    local opts =
      require("lazy.core.plugin").values(require("lazy.core.config").spec.plugins["avante.nvim"], "opts", false)

    local mappings = {
      {
        opts.mappings.focus_results,
        function()
          require("avante.api").focus_results()
        end,
        desc = "avante: focus_results",
        mode = { "n", "v", "i" },
      },
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
        -- mode = { "n", "v" },
        mode = { "v" },
      },
      {
        opts.mappings.focus,
        function()
          require("avante.api").focus()
        end,
        desc = "avante: focus",
        mode = { "n", "v", "i" },
      },
      -- {
      --   opts.mappings.focus_input,
      --   function()
      --     require("avante.api").focus_input()
      --   end,
      --   desc = "avante: focus input",
      --   mode = { "n", "v", "i" },
      -- },
    }
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    rag_service = {
      enabled = true, -- Enables the rag service, requires OPENAI_API_KEY to be set
    },
    -- provider = "openai",
    provider = "gemini", -- Recommend using Claude
    -- provider = "claude", -- Recommend using Claude
    -- provider = "deepseek", -- Recommend using Claude

    gemini = {
      -- __inherited_from = "openai",
      -- @see https://ai.google.dev/gemini-api/docs/models/gemini
      model = "gemini-2.0-flash", -- your desired model (or use gpt-4o, etc.)
      -- timeout = 30000, -- timeout in milliseconds
      temperature = 0, -- adjust if needed
      max_tokens = 1048576,
      --
      -- stream = false,
    },
    vendors = {
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-coder",
      },
      qianwen = {
        __inherited_from = "openai",
        api_key_name = "DASHSCOPE_API_KEY",
        endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
        model = "qwen-coder-plus-latest",
      },
    },
    openai = {
      endpoint = "https://api.openai.com/v1",
      -- model = "o1-2024-12-17",
      -- model = "chatgpt-4o-latest",
      model = "o3-mini",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 16384,
      -- reasoning_effort = "high",
      stream = true,
    },
    -- auto_suggestions_provider = "openai",
    auto_suggestions_provider = "gemini",
    -- cursor_applying_provider = nil,
    cursor_applying_provider = "gemini",
    -- add any opts here
    -- dual_boost = {
    --   enabled = false,
    --   first_provider = "openai",
    --   second_provider = "claude",
    --   prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
    --   timeout = 60000, -- Timeout in milliseconds
    -- },
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
      ask = "<A-a>", -- Alt + a to ask
      edit = "e", -- Alt + e to edit
      -- refresh = "<A-s>", -- leader + ar to refresh
      focus = "<A-f>", -- leader + ar to refresh
      -- focus_results = "<A-s>",
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
        accept = "<right>",
        next = "]",
        prev = "[",
        dismiss = "<esc>",
      },
      jump = {
        next = "]",
        prev = "[",
      },
      submit = {
        normal = "<CR>",
        insert = "<c-CR>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<c-t>",
        reverse_switch_windows = "<S-Tab>",
        remove_file = "d",
        add_file = "a",
      },
      files = {
        add_current = "<A-d>", -- Add current buffer to selected files
      },
    },
    hints = { enabled = true },
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", -- the position of the sidebar
      wrap = true, -- similar to vim.o.wrap
      width = 50, -- default % based on available width
      height = 50,
      sidebar_header = {
        enabled = true, -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 15, -- Height of the input window in vertical layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = true, -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
      },
    },
    -- windows = {
    --   position = "right",
    --   wrap = true, -- similar to vim.o.wrap
    --   width = 50, -- default % based on available width in vertical layout
    --   height = 50, -- default % based on available height in horizontal layout
    --   sidebar_header = {
    --     enabled = true, -- true, false to enable/disable the header
    --     align = "center", -- left, center, right for title
    --     rounded = true,
    --   },
    --   input = {
    --     -- height = 30,
    --     height = 15,
    --   },
    --   ask = {
    --     floating = false, -- Open the 'AvanteAsk' prompt in a floating window
    --     start_insert = true, -- Start insert mode when opening the ask window
    --     border = "rounded",
    --     ---@type "ours" | "theirs"
    --     focus_on_apply = "ours", -- which diff to focus after applying
    --   },
    -- },
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
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    -- {
    --   suggestion = {
    --     enabled = true,
    --     auto_trigger = true,
    --     keymap = {
    --       accept = "<Right>", -- Set Enter to confirm suggestions
    --       next = "<C-j>", -- Navigate to the next suggestion
    --       prev = "<C-k>", -- Navigate to the previous suggestion
    --       dismiss = "<C-l>", -- Dismiss the suggestion
    --     },
    --   },
    --   -- support for image pasting
    --   "HakonHarnes/img-clip.nvim",
    --   event = "VeryLazy",
    --   opts = {
    --     hints = { enabled = false },
    --     -- recommended settings
    --     default = {
    --       embed_image_as_base64 = false,
    --       prompt_for_file_name = false,
    --       drag_and_drop = {
    --         insert_mode = true,
    --       },
    --       -- required for Windows users
    --       use_absolute_path = true,
    --     },
    --   },
    -- },
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
