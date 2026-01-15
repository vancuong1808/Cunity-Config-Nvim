return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          -- Required by nvim-dap-ui (otherwise it errors during setup)
          "nvim-neotest/nvim-nio",
        },
        config = function()
          require("dapui").setup({
            icons = { expanded = "▾", collapsed = "▸" },
            layouts = {
              {
                elements = {
                  { id = "scopes", size = 0.33 },
                  { id = "breakpoints", size = 0.17 },
                  { id = "stacks", size = 0.25 },
                  { id = "watches", size = 0.25 },
                },
                size = 40,
                position = "left",
              },
              {
                elements = { "repl", "console" },
                size = 0.25,
                position = "bottom",
              },
            },
            floating = {
              border = "rounded",
            },
          })
        end,
      },
    },
    config = function()
      local dap = require("dap")

      local function delve_path()
        local exe = vim.fn.exepath("dlv")
        if exe ~= nil and exe ~= "" then
          return exe
        end

        local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
        local candidates = {
          vim.fs.joinpath(mason_bin, "dlv"),
          vim.fs.joinpath(mason_bin, "dlv.exe"),
          vim.fs.joinpath(mason_bin, "dlv.cmd"),
        }

        for _, candidate in ipairs(candidates) do
          if vim.uv.fs_stat(candidate) then
            return candidate
          end
        end

        return "dlv"
      end

      local function netcoredbg_path()
        local exe = vim.fn.exepath("netcoredbg")
        if exe ~= nil and exe ~= "" then
          return exe
        end

        local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
        local candidates = {
          vim.fs.joinpath(mason_bin, "netcoredbg"),
          vim.fs.joinpath(mason_bin, "netcoredbg.exe"),
          vim.fs.joinpath(mason_bin, "netcoredbg.cmd"),
        }

        for _, candidate in ipairs(candidates) do
          if vim.uv.fs_stat(candidate) then
            return candidate
          end
        end

        return "netcoredbg"
      end

      dap.adapters.coreclr = {
        type = "executable",
        command = netcoredbg_path(),
        args = { "--interpreter=vscode" },
      }

      dap.adapters.go = function(callback, _)
        local handle
        local pid_or_err
        local port = 38697

        handle, pid_or_err = vim.uv.spawn(delve_path(), {
          args = { "dap", "-l", "127.0.0.1:" .. port },
          detached = true,
        }, function(code)
          if handle and not handle:is_closing() then
            handle:close()
          end
          if code ~= 0 then
            vim.schedule(function()
              vim.notify("dlv exited with code " .. code, vim.log.levels.WARN)
            end)
          end
        end)

        if not handle then
          vim.notify("Failed to start dlv: " .. tostring(pid_or_err), vim.log.levels.ERROR)
          return
        end

        vim.defer_fn(function()
          callback({ type = "server", host = "127.0.0.1", port = port })
        end, 100)
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch .NET (pick dll)",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug Go (file)",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug Go (package)",
          request = "launch",
          program = "${fileDirname}",
        },
      }

      -- Keymaps
      require("helpers.dap-keymap").setup()
    end,
  },

  {
    "nvim-telescope/telescope-dap.nvim",
    lazy = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
}
