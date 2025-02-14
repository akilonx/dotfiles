return {
  "neovim/nvim-lspconfig",
  opts = {
    -- Set global options like disabling inlay hints
    inlay_hints = { enabled = true },
    -- Configure servers
    servers = {
      eslint = {
        format = { enable = true }, -- Enable ESLint formatting
        setup = { cmd = { "vscode-eslint-language-server", "--stdio" } },
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = true
        end,
      },
      dartls = {},
      biome = {},
      tsserver = {
        on_attach = function(client)
          -- this is important, otherwise tsserver will format ts/js
          -- files which we *really* don't want.
          client.server_capabilities.documentFormattingProvider = false
        end,
        settings = {
          typescript = {
            tsserver = {
              exclude = { "**/node_modules", "**/.git" },
            },
          },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic", -- or "strict" for more rigorous checks
            },
          },
        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
    -- Attach custom functionality when LSP connects
    on_attach = function(client, bufnr)
      -- Enable document diagnostics
      vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = true })
        end,
      })
      vim.api.nvim_command([[autocmd BufWritePre <buffer> EslintFixAll]])
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })

      local bufopts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Go to Definition
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Hover Documentation
      vim.keymap.set("n", "<c-.>", vim.lsp.buf.signature_help, bufopts) -- Signature Help
      vim.keymap.set("n", "gi", vim.lsp.buf.references, bufopts) -- References
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts) -- Rename Symbol
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- Code Action
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.biome)
    end,
  },
}
