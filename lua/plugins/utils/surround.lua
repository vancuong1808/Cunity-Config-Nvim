return {
  "echasnovski/mini.surround",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.surround").setup({
      -- Use classic, easy-to-remember mappings:
      -- sa = add, sd = delete, sr = replace
      mappings = {
        add = "sa",
        delete = "sd",
        replace = "sr",

        -- Optional but handy:
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        update_n_lines = "sn",

        -- Disable default suffixes to keep it predictable
        suffix_last = "",
        suffix_next = "",
      },
    })
  end,
}
