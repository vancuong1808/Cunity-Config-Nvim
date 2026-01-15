local builtin = require("telescope.builtin")
local ext = require("telescope").extensions

local M = {}

----------------------------------------------------------------------
-- SHARED LAYOUT PRESETS
----------------------------------------------------------------------
local layout_config = {
  horizontal = {
    width = 0.9,
    height = 25,
    preview_cutoff = 120,
  },
  vertical = {
    width = 0.9,
    height = 25,
    preview_cutoff = 40,
    prompt_position = "top",
  },
  center = {
    width = 0.6,
    height = 0.5,
  },
  cursor = {
    width = 0.5,
    height = 0.4,
  },
  bottom_pane = {
    height = 15,
    preview_cutoff = 120,
  },
}

local layout = {
  files = {
    layout_strategy = "horizontal",
    layout_config = layout_config.horizontal
  },

  lsp = {
    layout_strategy = "vertical",
    layout_config = layout_config.vertical
  },

  bottom = {
    layout_strategy = "bottom_pane",
    layout_config = layout_config.bottom_pane
  },

  center = {
    layout_strategy = "center",
    layout_config = layout_config.center
  },

  cursor = {
    layout_strategy = "cursor",
    layout_config = layout_config.center
  },
}

----------------------------------------------------------------------
-- FILE PICKERS
----------------------------------------------------------------------

function M.find_files(opts)
  builtin.find_files(vim.tbl_extend("force", layout.files, {
    hidden = true,
  }, opts or {}))
end

function M.git_files(opts)
  builtin.git_files(vim.tbl_extend("force", layout.files, opts or {}))
end

function M.oldfiles(opts)
  builtin.oldfiles(vim.tbl_extend("force", layout.bottom, {
    cwd = true,
  }, opts or {}))
end

function M.file_browser(opts)
  ext.file_browser.file_browser(vim.tbl_extend("force", layout.files, {
    path = "%:p:h",
    select_buffer = true,
  }, opts or {}))
end

----------------------------------------------------------------------
-- SEARCH
----------------------------------------------------------------------

function M.live_grep(opts)
  builtin.live_grep(vim.tbl_extend("force", layout.files, opts or {}))
end

function M.grep_word(opts)
  builtin.grep_string(vim.tbl_extend("force", layout.files, {
    search = vim.fn.expand("<cword>"),
  }, opts or {}))
end

function M.current_buffer(opts)
  builtin.current_buffer_fuzzy_find(vim.tbl_extend("force", layout.cursor, opts or {}))
end

----------------------------------------------------------------------
-- BUFFER / WINDOW
----------------------------------------------------------------------

function M.buffers(opts)
  builtin.buffers(vim.tbl_extend("force", layout.bottom, {
    sort_mru = true,
    ignore_current_buffer = true,
  }, opts or {}))
end

function M.jumplist()
  builtin.jumplist(layout.bottom)
end

function M.marks()
  builtin.marks(layout.bottom)
end

----------------------------------------------------------------------
-- COMMAND / VIM
----------------------------------------------------------------------

function M.commands(opts)
  builtin.commands(vim.tbl_extend("force", layout.center, opts or {}))
end

function M.keymaps()
  builtin.keymaps(layout.center)
end

function M.help()
  builtin.help_tags(layout.center)
end

function M.man_pages()
  builtin.man_pages(layout.center)
end

function M.colorscheme()
  builtin.colorscheme(vim.tbl_extend("force", layout.cursor, {
      enable_preview = true,
  }))
end

----------------------------------------------------------------------
-- GIT
----------------------------------------------------------------------

function M.git_status()
  builtin.git_status(layout.files)
end

function M.git_commits()
  builtin.git_commits(layout.files)
end

function M.git_bcommits()
  builtin.git_bcommits(layout.files)
end

function M.git_branches()
  builtin.git_branches(layout.center)
end

function M.git_stash()
  builtin.git_stash(layout.center)
end

----------------------------------------------------------------------
-- LSP
----------------------------------------------------------------------

function M.lsp_definitions()
  builtin.lsp_definitions(layout.lsp)
end

function M.lsp_references()
  builtin.lsp_references(layout.lsp)
end

function M.lsp_implementations()
  builtin.lsp_implementations(layout.lsp)
end

function M.lsp_type_definitions()
  builtin.lsp_type_definitions(layout.lsp)
end

function M.lsp_document_symbols(opts)
  builtin.lsp_document_symbols(vim.tbl_extend("force", layout.lsp, opts or {}))
end

function M.lsp_workspace_symbols(opts)
  builtin.lsp_workspace_symbols(vim.tbl_extend("force", layout.lsp, opts or {}))
end

function M.diagnostics(opts)
  builtin.diagnostics(vim.tbl_extend("force", layout.lsp, {
    bufnr = 0,
  }, opts or {}))
end

-- Workspace diagnostics (ALL files)
-- opts:
--   severity = vim.diagnostic.severity.ERROR | WARN | INFO | HINT
--   no_unlisted = true → chỉ file đang mở
function M.workspace_diagnostics(opts)
  builtin.diagnostics(vim.tbl_extend("force", {
    bufnr = nil,          -- toàn workspace
    no_unlisted = true,
  }, opts or {}))
end

function M.diagnostics_error()
  builtin.diagnostics({ severity = vim.diagnostic.severity.ERROR })
end

function M.diagnostics_warn()
  builtin.diagnostics({ severity = vim.diagnostic.severity.WARN })
end

function M.lsp_incoming_calls()
  builtin.lsp_incoming_calls(layout.lsp)
end

function M.lsp_outgoing_calls()
  builtin.lsp_outgoing_calls(layout.lsp)
end

----------------------------------------------------------------------
-- TREESITTER
----------------------------------------------------------------------
----------------------------------------------------------------------
-- HISTORY / META
----------------------------------------------------------------------

function M.resume()
  builtin.resume(layout.bottom)
end

function M.pickers()
  builtin.pickers(layout.center)
end

function M.projects()
  ext.projects.projects(layout.center)
end

return M
