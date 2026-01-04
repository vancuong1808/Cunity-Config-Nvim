return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
  end,
  opts = {
    manual_mode = false,
    detection_methods = { "pattern", "lsp" },
    patterns = {
      ".git",
      "Makefile",
      "package.json",
      "pyproject.toml",
      "requirements.txt",
      "*.sln",
      "*.csproj",
    },
    show_hidden = true,
    silent_chdir = true,
    scope_chdir = "global",
    base_dirs = {
        { path = vim.fn.expand("~/dev"), max_depth = 3 },
        { path = vim.fn.expand("~/Projects"), max_depth = 3 },
        { path = vim.fn.expand("~/src"), max_depth = 3 },
    },
  },
}
