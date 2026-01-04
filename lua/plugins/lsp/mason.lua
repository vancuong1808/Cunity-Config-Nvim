return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  priority = 1000,
  config = function()
    require("mason").setup({
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ui = {
        border = "rounded",
      },
    })
  end,
}
