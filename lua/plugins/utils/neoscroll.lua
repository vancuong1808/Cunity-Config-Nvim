return {
  "karb94/neoscroll.nvim",
  enabled = function()
    return not vim.g.neovide
  end,
  event = "VeryLazy",
  config = function()
    require("neoscroll").setup {}
  end,
}
