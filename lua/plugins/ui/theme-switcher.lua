return {
  "zaldih/themery.nvim",
  config = function()
    require("themery").setup({
      -- :lua print(vim.inspect(vim.fn.getcompletion("", "color")) ) lay theme hien co
      themes = { "NeoSolarized", "blue", "catppuccin", "catppuccin-frappe", "catppuccin-latte", "catppuccin-macchiato", "catppuccin-mocha", "cyberdream", "cyberdream-light", "darkblue", "default", "delek", "desert", "elflord", "evening", "gruvbox", "habamax", "industry", "koehler", "lunaperche", "morning", "murphy", "onedark", "onedark_dark", "onedark_vivid", "onelight", "pablo", "peachpuff", "quiet", "retrobox", "ron", "shine", "slate", "sorbet", "tokyonight", "tokyonight-day", "tokyonight-moon", "tokyonight-night", "tokyonight-storm", "torte", "unokai", "vaporwave", "vim", "wildcharm", "zaibatsu", "zellner" },
      livePreview = true,
    })
  end,
}
