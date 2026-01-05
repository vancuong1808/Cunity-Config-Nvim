return {
  "neovim/nvim-lspconfig",
  priority = 900,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    local lsp_common = require("helpers.lsp-common")
    local py = require("helpers.python")
    local csharp = require("helpers.csharp")
    local capabilities = lsp_common.capabilities()
    local on_attach = lsp_common.on_attach()

    py.setup_commands()
    csharp.setup_commands()

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      },
      ts_ls = {},
      eslint = {},
      html = {},
      cssls = {},
      tailwindcss = {},
      jsonls = {},
      pyright = {
        on_new_config = function(new_config, bufnr)
          py.apply_pyright_python(new_config, bufnr)
        end,
      },
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
          },
        },
      },
      sqlls = {},
    }

    for name, cfg in pairs(servers) do
      vim.lsp.config(name, vim.tbl_extend("force", cfg, {
        capabilities = capabilities,
        on_attach = on_attach,
      }))
    end

    vim.lsp.enable(vim.tbl_keys(servers))
  end,
}
