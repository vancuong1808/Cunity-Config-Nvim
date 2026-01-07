local map = vim.keymap.set
local t = require("helpers.telescope")
local docs = require("helpers.docs")

docs.setup_commands()

-- Telescope: Files / Search
map("n", "<leader>ff", t.find_files, { desc = "Find files" })
map("n", "<leader>fg", t.live_grep, { desc = "Live grep" })
map("n", "<leader>fw", t.grep_word, { desc = "Grep word under cursor" })
map("n", "<leader>fb", t.buffers, { desc = "Buffers" })
map("n", "<leader>fo", t.oldfiles, { desc = "Recent files" })
map("n", "<leader>fr", t.resume, { desc = "Resume last picker" })
map("n", "<leader>fe", t.file_browser, { desc = "File browser" })
map("n", "<leader>f/", t.current_buffer, { desc = "Search in buffer" })
map("n", "<leader>fp", t.projects, { desc = "Projects" })
map("n", "<leader>pp", t.projects, { desc = "Projects" })
map("n", "<leader>pm", function()
  t.projects({})
  vim.notify("In Projects picker: press 'c'/'C' to add current project", vim.log.levels.INFO)
end, { desc = "Projects (add current via c/C)" })

-- Telescope: Git
map("n", "<leader>gf", t.git_files, { desc = "Git files" })
map("n", "<leader>gs", t.git_status, { desc = "Git status" })
map("n", "<leader>gc", t.git_commits, { desc = "Git commits" })
map("n", "<leader>gb", t.git_branches, { desc = "Git branches" })
map("n", "<leader>gS", t.git_stash, { desc = "Git stash" })
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Telescope: Meta / Utils
map("n", "<leader>?", t.help, { desc = "Help tags" })
map("n", "<leader>uC", t.commands, { desc = "Commands" })
map("n", "<leader>uK", t.keymaps, { desc = "Keymaps" })
map("n", "<leader>uM", t.man_pages, { desc = "Man pages" })
map("n", "<leader>uP", t.pickers, { desc = "All pickers" })

-- Docs (fast + pretty + up-to-date)
map("n", "<leader>uD", "<cmd>DevDocsSearch<cr>", { desc = "DevDocs search" })
map("n", "<leader>uN", "<cmd>DotnetLearnSearch<cr>", { desc = ".NET docs (Learn)" })
map("n", "<leader>uY", function() docs.pydoc() end, { desc = "pydoc (cword)" })
map("n", "<leader>uG", function() docs.godoc() end, { desc = "go doc (cword)" })

-- Web endpoints navigator
map("n", "<leader>ue", "<cmd>Endpoint<cr>", { desc = "Endpoints" })

-- Apps
map("n", "<leader>ul", "<cmd>Leet<cr>", { desc = "LeetCode" })
map("n", "<leader>us", "<cmd>Store<cr>", { desc = "Store" })
local function back_to_dashboard()
  -- Some plugin UIs (e.g. leetcode.nvim) can open windows with 'winfixbuf',
  -- which prevents Alpha from switching buffers in the current window.
  -- In that case, open Alpha in a fresh tab.
  if vim.wo.winfixbuf then
    vim.cmd("tabnew")
    local ok, alpha = pcall(require, "alpha")
    if ok and alpha and alpha.start then
      alpha.start(true)
      return
    end
  end

  if vim.fn.exists(":Alpha") == 2 then
    local ok = pcall(vim.cmd, "Alpha")
    if ok then
      return
    end
  end

  local ok, alpha = pcall(require, "alpha")
  if ok and alpha and alpha.start then
    alpha.start(true)
    return
  end
  vim.notify("alpha-nvim not available", vim.log.levels.WARN)
end

map("n", "<leader>ud", back_to_dashboard, { desc = "Dashboard" })
map("n", "<leader>0", back_to_dashboard, { desc = "Dashboard" })

-- Telescope: LSP
map("n", "<leader>ld", t.lsp_definitions, { desc = "Go to definition" })
map("n", "<leader>lr", t.lsp_references, { desc = "References" })
map("n", "<leader>li", t.lsp_implementations, { desc = "Implementations" })
map("n", "<leader>lt", t.lsp_type_definitions, { desc = "Type definitions" })

map("n", "<leader>ls", t.lsp_document_symbols, { desc = "Document symbols" })
map("n", "<leader>lS", t.lsp_workspace_symbols, { desc = "Workspace symbols" })

map("n", "<leader>le", t.diagnostics, { desc = "Buffer diagnostics" })
-- Workspace diagnostics
map("n", "<leader>lE", t.workspace_diagnostics, { desc = "Workspace diagnostics" })
map("n", "<leader>lX", t.diagnostics_error, { desc = "Errors only" })
map("n", "<leader>lW", t.diagnostics_warn, { desc = "Warnings only" })
map("n", "<leader>lI", t.lsp_incoming_calls, { desc = "Incoming calls" })
map("n", "<leader>lO", t.lsp_outgoing_calls, { desc = "Outgoing calls" })

-- Telescope: Treesitter
map("n", "<leader>ts", t.treesitter, { desc = "Treesitter symbols" })

-- Telescope: UI
map("n", "<leader>ut", function()
    t.colorscheme()
    -- vim.cmd("autocmd FileType qf ++once call nvim_input(':cclose<cr>')") -- close quickfix list
end, { desc = "Colorscheme preview" })
map("n", "<leader>uT", "<cmd>Themery<CR>")

-- Telescope history
map("n", "<leader>jj", t.jumplist, { desc = "Jumplist" })
map("n", "<leader>jm", t.marks, { desc = "Marks" })

map("n", "<Tab>", ":NERDTreeToggle<CR>", { silent = true, desc = "Explorer toggle" })

-- NeovideFocus
map("n", "<leader>nf", "<cmd>NeovideFocus<CR>", {
  desc = "Focus Neovide window",
  silent = true,
})

-- Resize window
map("n", "<C-Left>", ":vertical resize +5<CR>")
map("n", "<C-Right>", ":vertical resize -5<CR>")
map("n", "<C-Down>", ":horizontal resize +5<CR>")
map("n", "<C-Up>", ":horizontal resize -5<CR>")

-- Move lines
map("v", "<S-Up>", ":move '<-2<CR>gv")   -- Di chuyển dòng lên
map("v", "<S-Down>", ":move '>+1<CR>gv") -- Di chuyển dòng xuống
map("x", "<S-Up>", ":move '<-2<CR>gv")   -- Di chuyển dòng lên (chế độ visual)
map("x", "<S-Down>", ":move '>+1<CR>gv") -- Di chuyển dòng xuống (chế độ visual)

-- Zoom font size
map("n", "<C-=>", function() require("helpers.font")(1) end)
map("n", "<C-->", function() require("helpers.font")(-1) end)

-- Buffers
map("n", "bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "bN", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "bq", ":bdelete<CR>", { noremap = true, silent = true })

-- Hien diagnostic co the xem error messages
map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>dq", vim.diagnostic.setqflist)

-- Notify check
map("n", "<leader>ne", "<cmd>Noice errors<cr>", { desc = "Noice Errors" })
map("n", "<leader>nh", function()
  require("telescope").extensions.noice.noice()
end, { desc = "Noice history" })
map("n", "<leader>nn", function()
  require("telescope").extensions.notify.notify()
end, { desc = "Notify history" })
map("n", "<leader>nc", "<cmd>Telescope command_history<cr>", { desc = "Command history" })

