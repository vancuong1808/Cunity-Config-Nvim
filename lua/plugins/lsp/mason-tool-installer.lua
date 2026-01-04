return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  cmd = {
    "MasonToolsInstall",
    "MasonToolsUpdate",
    "MasonToolsClean",
  },
  opts = {
    ensure_installed = {
      -- C# / .NET
      "roslyn",
      "csharpier",

      -- Debugging
      "netcoredbg",

      -- Go
      "gopls",
      "goimports",
      "gofumpt",
      "delve",

      -- JS/TS
      "eslint-lsp",
      "prettierd",
    },
    auto_update = false,
    run_on_start = true,
    start_delay = 2000,
    debounce_hours = 24,
  },
}
