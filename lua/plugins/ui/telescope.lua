
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Project / navigation
    "ahmedkhalf/project.nvim",
    -- UI
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    -- Performance
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    -- Extra pickers
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },

    -- telescope/
    -- ├── builtin        -- các picker có sẵn
    -- ├── pickers        -- engine tạo picker
    -- ├── finders        -- nơi sinh data
    -- ├── sorters        -- cách sắp xếp
    -- ├── previewers     -- cửa sổ preview
    -- └── actions        -- hành động khi chọn
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "❯ ",
        entry_prefix = "  ",
        path_display = { "truncate" },

        sorting_strategy = "ascending",
        layout_strategy = "horizontal",

        layout_config = {
          prompt_position = "top",
          width = 0.9,
          height = 0.85,
        },

        winblend = 0,
        border = true,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

        mappings = {
          i = {
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["<CR>"] = actions.select_default,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          }
        },
      },
      
      -- Picker
      -- Layout_config {"bottom_pane, ivy, center, cursor, horizontal, vertical"}
      -- Theme {ivy, cursor, dropdown}
      -- opts {layout_strategy, theme, sorting_strategy, cwd, previewer }
      pickers = {
        find_files = {
          hidden = true,
          layout_strategy = "ivy",
        },
        git_files = {
            layout_strategy = "ivy",
        },
        lsp_references = { 
            theme = "dropdown", 
            layout_strategy = "vertical",
        },
        lsp_definitions = { 
            theme = "dropdown", 
            layout_strategy = "vertical",
        },
        diagnostics = { 
            theme = "ivy", 
            layout_strategy = "vertical", 
        },
        commands = {
          layout_strategy = "center",
        },
      },

      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },

        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            previewer = false,
            winblend = 10,
          }),
        },

        file_browser = {
          hijack_netrw = true,
          hidden = true,
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")
    telescope.load_extension("noice")
    telescope.load_extension("projects")
  end,
}
