local Lsp = require("utils.lsp")

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "biome" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        biome = {
          root_dir = function()
            if Lsp.biome_config_exists() then
              return Lsp.biome_config_path()
            end

            return vim.fn.stdpath("config")
          end,
          keys = {
            {
              "<leader>cb",
              function()
                -- NOTE:Migrate to LSP later if it's available
                local file = vim.fn.fnameescape(vim.fn.expand("%:p")) -- Escape file path for shell
                vim.cmd("silent !biome lint --write " .. file)
              end,
              desc = "Lint Fix",
            },
            {
              "<leader>cc",
              function()
                -- NOTE:Migrate to LSP later if it's available
                local file = vim.fn.fnameescape(vim.fn.expand("%:p")) -- Escape file path for shell
                vim.cmd("silent !biome lint --write --unsafe " .. file)
              end,
              desc = "Lint Unsafe Fix",
            },
          },
        },
      },
      setup = {
        biome = function(_, opts)
          Lsp.register_keymaps("biome", opts.keys, "Biome")
        end,
      },
    },
  },
}
