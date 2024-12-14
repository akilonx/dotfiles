return {
  "neovim/nvim-lspconfig",
  opts = {
    -- Set global options like disabling inlay hints
    inlay_hints = { enabled = false },
    -- Configure servers
    servers = {
      eslint = {},
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
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Go to Definition
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Hover Documentation
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts) -- Signature Help
      vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- References
      vim.keymap.set("n", "F2", vim.lsp.buf.rename, bufopts) -- Rename Symbol
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- Code Action
    end,
  },
}
