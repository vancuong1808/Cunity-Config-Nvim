return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "c_sharp",
      "go",
      "gomod",
      "gosum",
      "gotmpl",
      "html",
      "css",
      "json",
      "javascript",
      "typescript",
      "tsx",
      "xml",
      "sql",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.config").setup(opts)
  end,
}
