return {
  "b0o/incline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("plugins.ui.incline")
  end,
}
