return {
  "SmiteshP/nvim-navic",
  event = "LspAttach",
  config = function()
    require("nvim-navic").setup({
      highlight = true,
      separator = "  ",
      depth_limit = 5,
    })
  end,
}
