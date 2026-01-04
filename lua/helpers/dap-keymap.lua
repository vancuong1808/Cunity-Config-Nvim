local M = {}

function M.setup()
  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = desc })
  end

  local dap = require("dap")
  local dapui = require("dapui")
  local tb = require("telescope").extensions.dap

  -- Core
  map("<F5>", dap.continue, "DAP: Continue")
  map("<F6>", dap.step_over, "DAP: Step Over")
  map("<F7>", dap.step_into, "DAP: Step Into")
  map("<F8>", dap.step_out, "DAP: Step Out")

  map("<leader>db", dap.toggle_breakpoint, "DAP: Toggle breakpoint")
  map("<leader>du", dapui.toggle, "DAP UI")

  -- Telescope views
  map("<leader>ds", tb.frames, "DAP: Stack frames")
  map("<leader>dv", tb.variables, "DAP: Variables")
  map("<leader>dc", tb.commands, "DAP: Commands")
  map("<leader>dbp", tb.list_breakpoints, "DAP: Breakpoints")
end

return M
