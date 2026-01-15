local M = {}

M.dotnet = function()
  local path = vim.fn.stdpath("config") .. "/docs/dotnet.md"
  local lines = vim.fn.readfile(path)

  local sections = {}
  for i, line in ipairs(lines) do
    local title = line:match("^## (.+)")
    if title then
      table.insert(sections, {
        title = title,
        line = i,
      })
    end
  end

  require("telescope.pickers").new({}, {
    prompt_title = ".NET CLI Cheat Sheet",
    finder = require("telescope.finders").new_table({
      results = sections,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.title,
          ordinal = entry.title,
        }
      end,
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(_, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function open_selection(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd("edit " .. vim.fn.fnameescape(path))
        vim.api.nvim_win_set_cursor(0, { selection.value.line, 0 })
      end

      actions.select_default:replace(open_selection)
      map({ "i", "n" }, "<CR>", open_selection)
      map({ "i", "n" }, "<leader>dd", open_selection)
      return true
    end,
  }):find()
end

return M
