return {
  "neovim/nvim-lspconfig",
  opts = {
    -- Set global options like disabling inlay hints
    inlay_hints = { enabled = false },
    -- Configure servers
    servers = {
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
    -- Attach custom functionality when LSP connects
    on_attach = function(client, bufnr)
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
