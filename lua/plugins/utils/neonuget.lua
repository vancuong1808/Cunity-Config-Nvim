return {
  "MonsieurTib/neonuget",
  cmd = { "NuGet" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("neonuget").setup({
      dotnet_path = "dotnet",
      default_project = nil,
    })
  end,
}
