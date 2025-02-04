return {
  "neovim/nvim-lspconfig",
  opts = {
    -- Set global options like disabling inlay hints
    inlay_hints = { enabled = false },
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
      tsserver = {
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
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts) -- Signature Help
      vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- References
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts) -- Rename Symbol
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- Code Action
    end,
  },
}
