return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  opts = function(_, opts)
    local config = require("fzf-lua.config")
    local actions = require("fzf-lua.actions")

    -- Quickfix
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

    -- Trouble
    if LazyVim.has("trouble.nvim") then
      config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open
    end

    -- Toggle root dir / cwd
    config.defaults.actions.files["ctrl-r"] = function(_, ctx)
      local o = vim.deepcopy(ctx.__call_opts)
      o.root = o.root == false
      o.cwd = nil
      o.buf = ctx.__CTX.bufnr
      LazyVim.pick.open(ctx.__INFO.cmd, o)
    end
    config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
    config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },
      { cmd = "chafa", args = { "{file}", "--format=symbols" } },
      { cmd = "viu", args = { "-b" } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      "default-title",
      hls = {
        border = "FloatBorder",
        cursorline = "Visual",
        cursorlinenr = "Visual",
        backdrop = "FzfLuaBackdrop",
      },
      fzf_colors = false,
      -- History file
      fzf_opts = {
        ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
        ["--info"] = false,
        ["--border"] = false,
        ["--preview-window"] = false,
        ["--no-scrollbar"] = true,
      },
      -- winopts = {
      --   width = 0.8,
      --   height = 0.8,
      --   row = 0.5,
      --   col = 0.5,
      --   preview = {
      --     layout = "flex",
      --     flip_columns = 130,
      --     scrollchars = { "┃", "" },
      --   },
      --   backdrop = 60,
      -- title         = "Title",
      -- title_pos     = "center",        -- 'left', 'center' or 'right'
      -- title_flags = false, -- uncomment to disable title flags
      -- defaults keys:
      -- alt-i: toggle ignore
      -- alt-h: toggle hidden
      -- alt-f: toggle follow
      -- },
      -- files = {
      --   multiprocess = true,
      --   git_icons = false,
      --   file_icons = false,
      -- },
      -- grep = {
      --   multiprocess = true,
      -- },
      defaults = {
        -- formatter = "path.filename_first",
        formatter = "path.dirname_first",
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      },
      -- Custom LazyVim option to configure vim.ui.select
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {

            backdrop = 60,
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {

            backdrop = 60,
            layout = "vertical",
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(LazyVim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
              layout = "vertical",
              vertical = "down:15,border-top",
              hidden = "hidden",
            } or {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          winopts = {
            backdrop = 60,
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end,
      winopts = {

        backdrop = 60,
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { "┃", "" },
        },
      },
      files = {

        git_icons = false,
        file_icons = false,
        multiprocess = true,
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        multiprocess = true,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return "TroubleIcon" .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
          child_prefix = false,
          path_shorten = 1,
        },
        code_actions = {
          winopts = {
            -- previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
            preview = { layout = "reverse-list", horizontal = "right:75%" },
          },
        },
      },
    }
  end,
  config = function(_, options)
    local fzf_lua = require("fzf-lua")
    local actions = require("fzf-lua.actions")
    local config = require("fzf-lua.config")

    -- Files actions
    config.defaults.actions.files["alt-."] = actions.toggle_hidden

    -- Trouble
    config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open

    -- Refer https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/defaults.lua#L69 for default keymaps
    -- Shift+up/down to move the preview window
    -- Alt+q to send to quickfix
    -- Alt+a to toggle all
    fzf_lua.setup(options)

    -- Automatic sizing of height/width of vim.ui.select
    fzf_lua.register_ui_select(function(_, items)
      local min_h, max_h = 0.60, 0.80
      local h = (#items + 4) / vim.o.lines
      if h < min_h then
        h = min_h
      elseif h > max_h then
        h = max_h
      end
      return { winopts = { height = h, width = 0.80, row = 0.40 } }
    end)

    -- Refer https://github.com/ibhagwan/fzf-lua/issues/602
    vim.lsp.handlers["textDocument/codeAction"] = fzf_lua.lsp_code_actions
    vim.lsp.handlers["textDocument/definition"] = function()
      fzf_lua.lsp_definitions({ jump1 = true, ignore_current_line = true })
    end
    vim.lsp.handlers["textDocument/declaration"] = fzf_lua.lsp_declarations
    vim.lsp.handlers["textDocument/typeDefinition"] = fzf_lua.lsp_typedefs
    vim.lsp.handlers["textDocument/implementation"] = fzf_lua.lsp_implementations
    vim.lsp.handlers["textDocument/documentSymbol"] = fzf_lua.lsp_document_symbols
    vim.lsp.handlers["workspace/symbol"] = fzf_lua.lsp_workspace_symbols
    vim.lsp.handlers["callHierarchy/incomingCalls"] = fzf_lua.lsp_incoming_calls
    vim.lsp.handlers["callHierarchy/outgoingCalls"] = fzf_lua.lsp_outgoing_calls
  end,
  init = function()
    LazyVim.on_very_lazy(function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "fzf-lua" } })
        local opts = LazyVim.opts("fzf-lua") or {}
        require("fzf-lua").register_ui_select(opts.ui_select or nil)
        return vim.ui.select(...)
      end
    end)
  end,
  keys = {
    { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
    { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
    {
      "<Tab>",
      "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    -- find
    { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },

    {
      "<a-r>",
      function()
        local root_dir = require("utils.root").git()
        local fzf_lua = require("fzf-lua")
        fzf_lua.live_grep({
          cwd = root_dir,
          rg_opts = "--column --hidden --smart-case --color=always --no-heading --line-number -g '!{.git,node_modules}/'",
          multiprocess = true,
        })
      end,
      desc = "Find Live Grep (including hidden files)",
    },
    -- Find files at the current working directory
    {
      "<c-p>", -- <leader>e is used by oil.nvim for open file explorer in float window
      function()
        local root_dir = require("utils.root").git()
        require("fzf-lua").files({
          cwd = root_dir,
          cwd_prompt = false,
        })
      end,
      desc = "Find Files at project directory",
    },
    -- {
    --   "<a-r>",
    --   function()
    --     local root_dir = require("utils.root").git()
    --     local fzf_lua = require("fzf-lua")
    --     fzf_lua.live_grep({
    --       cwd = root_dir,
    --       rg_opts = "--column --hidden --smart-case --color=always --no-heading --line-number -g '!{.git,node_modules}/'",
    --       multiprocess = true,
    --     })
    --   end,
    --   desc = "Find Live Grep (including hidden files)",
    -- },
    -- -- Find files at the current working directory
    -- {
    --   "<c-p>", -- <leader>e is used by oil.nvim for open file explorer in float window
    --   function()
    --     local root_dir = require("utils.root").get()
    --     require("fzf-lua").files({
    --       cwd = root_dir,
    --       cwd_prompt = false,
    --     })
    --   end,
    --   desc = "Find Files at project directory",
    -- },
    { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
    { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    -- git
    { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
    { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
    -- search
    { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
    { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
    { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
    { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
    { "<leader><leader>", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
    { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
    { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
    {
      "<leader>sw",
      LazyVim.pick("grep_visual"),
      mode = "v",
      desc = "Selection (Root Dir)",
    },
    {
      "<leader>sW",
      LazyVim.pick("grep_visual", { root = false }),
      mode = "v",
      desc = "Selection (cwd)",
    },
    { "<leader>uC", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },

    {
      "g/",
      "<cmd>FzfLua grep_cword<cr>",
      mode = "n",
      desc = "Search Word Under Cursor (Root Dir)",
    },
    {
      "g/",
      "<cmd>FzfLua grep_visual<cr>",
      mode = "v",
      desc = "Search Selected Text (Root Dir)",
    },
    {
      "<leader>ss",
      function()
        require("fzf-lua").lsp_document_symbols({
          regex_filter = symbols_filter,
        })
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require("fzf-lua").lsp_live_workspace_symbols({
          regex_filter = symbols_filter,
        })
      end,
      desc = "Goto Symbol (Workspace)",
    },
  },
}
