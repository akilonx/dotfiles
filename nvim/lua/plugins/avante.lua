return {
  "yetone/avante.nvim",
  -- dir = "~/projects/nvim/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = "*",
  -- version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
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
      enabled = false, -- Enables the RAG service, requires OPENAI_API_KEY to be set
      provider = "gemini", -- The provider to use for RAG service (e.g. openai or ollama)
      llm_model = "gemini-2.0-flash", -- The LLM model to use for RAG service
      embed_model = "gemini-2.0-flash", -- The embedding model to use for RAG service
      endpoint = "https://cloudaicompanion.googleapis.com/$discovery/rest?version=v1", -- The API endpoint for RAG service
    },

    -- provider = "claude", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
    -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
    -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
    -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
    auto_suggestions_provider = "copilot",
    -- cursor_applying_provider = "deepseek", -- The provider used in the applying phase of Cursor Planning Mode, defaults to nil, when nil uses Config.provider as the provider for the applying phase
    claude = {
      endpoint = "https://api.anthropic.com",
      temperature = 0,
      model = "claude-3-7-sonnet-20250219",
      -- model = "claude-3-5-sonnet-20241022",
      -- model = 'claude-3-7-sonnet-20250219'
      -- max_tokens = 16384,
      max_tokens = 8192,
      disable_tools = true,
      stream = true,
    },
    -- provider = "gemini", -- Recommend using Claude
    -- provider = "openai", -- Recommend using Claude
    provider = "groqdeepseek", -- Recommend using Claude
    -- provider = "deepseek", -- Recommend using Claude
    -- provider = "hyperbolic", -- Recommend using Claude
    -- provider = "gemini", -- Recommend using Claude
    -- provider = "openrouter",
    cursor_applying_provider = "groqapply", -- In this example, use Groq for applying, but you can also use any provider you want.
    -- cursor_applying_provider = "gemini", -- In this example, use Groq for applying, but you can also use any provider you want.
    behaviour = {
      --- ... existing behaviours
      enable_cursor_planning_mode = true, -- enable cursor planning mode!
    },
    gemini = {
      -- __inherited_from = "openai",
      -- @see https://ai.google.dev/gemini-api/docs/models/gemini
      -- model = "gemini-2.0-pro-exp-02-05",
      model = "gemini-2.0-flash", -- your desired model (or use gpt-4o, etc.)
      -- model = "gemini-2.0-pro-exp",
      -- timeout = 30000, -- timeout in milliseconds
      temperature = 0, -- adjust if needed
      max_tokens = 32768,
      -- stream = true,
      -- top_p = 0.95,
      -- top_k = 40,
      -- presence_penalty = 0.5,
      -- frequency_penalty = 0.5,
      -- stop = ["\n", "END"],
      -- n = 1,
      -- stream = false,
    },
    vendors = {
      hyperbolic = {
        __inherited_from = "openai",
        endpoint = "https://api.hyperbolic.xyz/v1",
        api_key_name = "HYPERBOLIC_API_KEY",
        model = "deepseek-ai/DeepSeek-V3",
        -- temperature = 0,
        stream = true,
        -- top_p = 0.9,
      },
      geminiflash = {
        __inherited_from = "openai",
        endpoint = "https://api.gemini.ai/v1",
        model = "gemini-2.0-flash",
        max_tokens = 1048576,
        temperature = 0,
        stream = true,
      },
      groqapply = { -- define groq provider
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        -- model = "llama-3.3-70b-versatile",
        -- model = "qwen-2.5-coder-32b",
        -- model = "llama-3.3-70b-specdec",
        -- model = "deepseek-r1-distill-llama-70b-specdec",
        max_completion_tokens = 8192,
        model = "llama-3.3-70b-specdec",
        temperature = 0,
      },
      groqdeepseek = { -- define groq provider
        __inherited_from = "openai",
        api_key_name = "GROQ_API_KEY",
        endpoint = "https://api.groq.com/openai/v1/",
        model = "deepseek-r1-distill-llama-70b-specdec",
        -- model = "llama-3.3-70b-versatile",
        -- model = "qwen-2.5-coder-32b",
        -- model = "qwen-qwq-32b",
        -- model = "deepseek-r1-distill-llama-70b",
        -- max_completion_tokens = 32768,
        max_completion_tokens = 16384,
        stream = true,
        temperature = 0,
      },
      openrouter = {
        __inherited_from = "openai",
        endpoint = "https://openrouter.ai/api/v1",
        api_key_name = "OPENROUTER_API_KEY",
        model = "deepseek/deepseek-chat",
      },
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-coder",
        max_tokens = 8192,
      },
      qianwen = {
        __inherited_from = "openai",
        api_key_name = "DASHSCOPE_API_KEY",
        endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
        model = "qwen-coder-plus-latest",
      },
      deepseekv3 = {
        __inherited_from = "openai",
        stream = true,
        api_key_name = "HYPERBOLIC_API_KEY",
        endpoint = "https://api.hyperbolic.xyz/v1",
        model = "deepseek-ai/DeepSeek-V3",
        temperature = 0,
      },
      deepseekr1 = {
        __inherited_from = "openai",
        stream = true,
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-reasoner",
        temperature = 0,
      },
    },
    openai = {
      endpoint = "https://api.openai.com/v1",
      -- endpoint = "https://api.hyperbolic.xyz/v1",
      -- model = "o1-2024-12-17",
      -- model = "chatgpt-4o-latest",
      -- model = "o3-mini",
      -- model = "deepseek-ai/DeepSeek-V3",
      -- model = "deepseek-ai/DeepSeek-R1",
      -- model = "o1",
      -- model = "o1-mini",
      model = "gpt-4o",
      timeout = 30000, -- Timeout in milliseconds
      -- temperature = 0,
      max_tokens = 16384,
      temperature = 0,
      -- top_p = 0.9,
      -- reasoning_effort = "high",
      stream = true,
    },
    -- auto_suggestions_provider = "openai",
    -- auto_suggestions_provider = "claude",
    -- cursor_applying_provider = nil,
    -- cursor_applying_provider = "claude",
    -- add any opts here
    -- dual_boost = {
    --   enabled = false,
    --   first_provider = "openai",
    --   second_provider = "claude",
    --   prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
    --   timeout = 60000, -- Timeout in milliseconds
    -- },

    -- behaviour = {
    --   auto_focus_sidebar = true,
    --   auto_suggestions = true, -- Experimental stage
    --   auto_suggestions_respect_ignore = false,
    --   auto_set_highlight_group = true,
    --   auto_set_keymaps = true,
    --   auto_apply_diff_after_generation = false,
    --   jump_result_buffer_on_finish = true,
    --   support_paste_from_clipboard = true,
    --   minimize_diff = true,
    -- },

    -- repo_map = {
    --   ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules", "venv", ".turbo" }, -- ignore files matching these
    --   negate_patterns = {}, -- negate ignore files matching these.
    -- },

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
    hints = { enabled = false },
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
        -- prefix = "> ",
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
    "giuxtaposition/blink-cmp-copilot",
    {
      "saghen/blink.cmp",
      optional = true,
      dependencies = { "giuxtaposition/blink-cmp-copilot", "Kaiser-Yang/blink-cmp-avante" },
      opts = {
        sources = {
          -- default = { "copilot" },
          default = { "copilot", "avante" },
          providers = {

            avante = {
              module = "blink-cmp-avante",
              name = "Avante",
              opts = {
                -- options for blink-cmp-avante
              },
            },
            copilot = {
              name = "copilot",
              module = "blink-cmp-copilot",
              kind = "Copilot",
            },
          },
        },
      },
    },
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
