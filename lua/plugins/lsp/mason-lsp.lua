return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "eslint",
        "html",
        "cssls",
        "tailwindcss",
        "jsonls",
        "pyright",
        "gopls",
        "sqlls",
      },
      automatic_installation = true,
    })
  end,
}
