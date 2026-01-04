return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- Recommended by neo-tree to prevent conflicts
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "󰈙",
      },
      git_status = {
        symbols = {
          added = "✚",
          modified = "",
          deleted = "✖",
          renamed = "󰁕",
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      hijack_netrw_behavior = "open_default",
    },
    window = {
      position = "left",
      width = 32,
    },
  },
  keys = {
    { "<C-Tab>", "<cmd>Neotree toggle<cr>", desc = "Explorer (Neo-tree)", silent = true },
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (Neo-tree)", silent = true },
  },
}
