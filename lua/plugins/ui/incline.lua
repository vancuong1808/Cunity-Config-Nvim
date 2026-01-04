local devicons = require("nvim-web-devicons")
local navic_ok, navic = pcall(require, "nvim-navic")

local function hl(name)
  local h = vim.api.nvim_get_hl(0, { name = name })
  return {
    fg = h.fg and string.format("#%06x", h.fg),
    bg = h.bg and string.format("#%06x", h.bg),
  }
end

local function colors()
  return {
    bg     = hl("Normal").bg,
    fg     = hl("Normal").fg,
    dim    = hl("Comment").fg,
    accent = hl("Identifier").fg,
  }
end

require("incline").setup({
  window = {
    padding = 1,
    margin = { vertical = 1 },
    placement = { vertical = "top", horizontal = "right" },
  },

  render = function(props)
    local c = colors()

    -- filename
    local filename = vim.fn.fnamemodify(
      vim.api.nvim_buf_get_name(props.buf),
      ":t"
    )
    if filename == "" then filename = "[No Name]" end

    -- icon
    local icon, icon_color =
      devicons.get_icon_color(filename, nil, { default = true })

    -- navic breadcrumb
    local breadcrumb = ""
    if navic_ok and navic.is_available(props.buf) then
      breadcrumb = navic.get_location({
        highlight = false,
        separator = " > ",
      }, props.buf)
    end

    return {
      { "", guifg = c.bg },
      {
        icon .. " ",
        guifg = icon_color,
        guibg = c.bg,
      },
      {
        filename,
        guifg = c.fg,
        guibg = c.bg,
        gui = vim.bo[props.buf].modified and "bold" or nil,
      },
      breadcrumb ~= "" and {
        " 󰁔 " .. breadcrumb,
        guifg = c.dim,
        guibg = c.bg,
      } or nil,
      { "", guifg = c.bg },
    }
  end,
})
