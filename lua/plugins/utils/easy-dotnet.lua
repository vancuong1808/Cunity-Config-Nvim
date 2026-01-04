return {
  "GustavEikaas/easy-dotnet.nvim",
  ft = { "cs", "fs", "csproj", "fsproj", "sln", "slnx", "props", "targets" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    picker = "telescope",

    -- Prevent conflicts with our explicit roslyn.nvim + nvim-dap config
    lsp = {
      enabled = false,
    },
    debugger = {
      auto_register_dap = false,
    },
  },
  config = function(_, opts)
    require("easy-dotnet").setup(opts)
  end,
}
