local M = {}

function M.setup()
  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = desc })
  end

  local dap = require("dap")
  local ok_dapui, dapui = pcall(require, "dapui")

  local tb
  do
    local ok_tel, telescope = pcall(require, "telescope")
    if ok_tel and telescope and telescope.extensions and telescope.extensions.dap then
      tb = telescope.extensions.dap
    end
  end

  -- Core
  map("<F5>", dap.continue, "DAP: Continue")
  map("<F6>", dap.step_over, "DAP: Step Over")
  map("<F7>", dap.step_into, "DAP: Step Into")
  map("<F8>", dap.step_out, "DAP: Step Out")

  map("<leader>db", dap.toggle_breakpoint, "DAP: Toggle breakpoint")

  if ok_dapui and dapui and type(dapui.toggle) == "function" then
    map("<leader>du", dapui.toggle, "DAP UI")
  end

  -- Telescope views
  if tb then
    map("<leader>ds", tb.frames, "DAP: Stack frames")
    map("<leader>dv", tb.variables, "DAP: Variables")
    map("<leader>dc", tb.commands, "DAP: Commands")
    map("<leader>dbp", tb.list_breakpoints, "DAP: Breakpoints")
  end
end

return M
