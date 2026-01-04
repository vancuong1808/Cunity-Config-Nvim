return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        theme = "auto",
        disabled_filetypes = { "neo-tree", "floaterm" },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            function()
              return "󰣇"
            end,
            separator = { right = "" },
            padding = { left = 1, right = 1 },
          },
          { "mode", separator = { right = "" } },
        },
        lualine_b = {
          { "branch", icon = "", separator = { left = "" } },
          {
            "filename",
            separator = { left = "" },
            symbols = {
              modified = "●",
              readonly = "",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
          },
          {
            "diff",
            separator = { left = "" },
            symbols = { added = " ", modified = " ", removed = " " },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            separator = { left = "" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_x = {
          { "encoding", icon = "", separator = { left = "" } },
          { "filetype", separator = { left = "" } },
        },
        lualine_y = {
          { function() return " " .. os.date("%H:%M") end },
        },
        lualine_z = {
          { "location", icon = "", separator = { left = "", right = "" } },
        },
      },
    })
  end,
}
