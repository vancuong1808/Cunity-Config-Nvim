return {
  "zerochae/endpoint.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Endpoint", "EndpointRefresh" },
  config = function()
    if vim.fn.executable("rg") ~= 1 then
      vim.notify("endpoint.nvim requires ripgrep (rg) in PATH", vim.log.levels.WARN)
    end

    require("endpoint").setup({
      picker = {
        type = "telescope",
      },
      cache = {
        mode = "session",
      },
    })
  end,
}
