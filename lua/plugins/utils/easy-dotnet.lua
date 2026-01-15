return {
  "GustavEikaas/easy-dotnet.nvim",
  cmd = { "Dotnet" },
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  opts = function()
    local function get_sdk_path()
      local version_out = vim.system({ "dotnet", "--version" }):wait()
      local list_out = vim.system({ "dotnet", "--list-sdks" }):wait()

      local sdk_version = vim.trim(version_out.stdout or "")
      local sdk_list = vim.trim(list_out.stdout or "")
      if sdk_version == "" or sdk_list == "" then
        return nil
      end

      local base
      for line in sdk_list:gmatch("[^\n]+") do
        if line:find(sdk_version, 1, true) then
          base = vim.fs.normalize(line:match("%[(.-)%]"))
          break
        end
      end
      if not base or base == "" then
        return nil
      end

      return vim.fs.joinpath(base, sdk_version)
    end

    local function get_secret_path(secret_guid)
      local home_dir = vim.fn.expand("~")
      if require("easy-dotnet.extensions").isWindows() then
        return home_dir
          .. "\\AppData\\Roaming\\Microsoft\\UserSecrets\\"
          .. secret_guid
          .. "\\secrets.json"
      end
      return home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
    end

    return {
      -- Optional function to return the path for the dotnet sdk (e.g C:/Program Files/dotnet/sdk/8.0.0)
      get_sdk_path = get_sdk_path,

      ---@type TestRunnerOptions
      test_runner = {
        ---@type "split" | "float" | "buf"
        viewmode = "float",
        enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
        noBuild = true,
        noRestore = true,
        icons = {
          passed = "",
          skipped = "",
          failed = "",
          success = "",
          reload = "",
          test = "",
          sln = "󰘐",
          project = "󰘐",
          dir = "",
          package = "",
        },
        mappings = {
          run_test_from_buffer = { lhs = "<leader>rt", desc = "run test from buffer" },
          debug_test_from_buffer = { lhs = "<leader>rd", desc = "run test from buffer" },
          filter_failed_tests = { lhs = "<leader>dff", desc = "filter failed tests" },
          debug_test = { lhs = "<leader>dt", desc = "debug test" },
          go_to_file = { lhs = "g", desc = "got to file" },
          run_all = { lhs = "<leader>R", desc = "run all tests" },
          run = { lhs = "<leader>r", desc = "run test" },
          peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
          peek_stack_trace_from_buffer = { lhs = "<leader>stb", desc = "peek stacktrace of failed test from buffer" },
          expand = { lhs = "l", desc = "expand" },
          expand_node = { lhs = "E", desc = "expand node" },
          expand_all = { lhs = "-", desc = "expand all" },
          collapse_all = { lhs = "h", desc = "collapse all" },
          close = { lhs = "q", desc = "close testrunner" },
          refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
        },
        additional_args = {},
      },

      ---@param action "test" | "restore" | "build" | "run" | "watch"
      terminal = function(path, action, args)
        args = args or ""
        local commands = {
          run = function()
            return string.format("dotnet run --project %s %s", path, args)
          end,
          test = function()
            return string.format("dotnet test %s %s", path, args)
          end,
          restore = function()
            return string.format("dotnet restore %s %s", path, args)
          end,
          build = function()
            return string.format("dotnet build %s %s", path, args)
          end,
          watch = function()
            return string.format("dotnet watch --project %s %s", path, args)
          end,
        }
        local command = commands[action]()
        if require("easy-dotnet.extensions").isWindows() == true then
          command = command .. "\r"
        end
        vim.cmd("vsplit")
        vim.cmd("term " .. command)
      end,

      secrets = {
        path = get_secret_path,
      },

      -- Workaround: easy-dotnet's Telescope picker can error in some flows
      -- (coroutine.status on nil / yielding from main thread). Use basic picker.
      picker = "basic",

      csproj_mappings = true,
      fsproj_mappings = true,
      auto_bootstrap_namespace = true,
    }
  end,
  config = function(_, opts)
    require("easy-dotnet").setup(opts)
    -- local dotnet = require("easy-dotnet")
    -- -- Options are not required
    -- dotnet.setup()

    -- Example command
    -- vim.api.nvim_create_user_command("Secrets", function()
    --   dotnet.secrets()
    -- end, {})

    -- Example keybinding
    -- vim.keymap.set("n", "<C-p>", function()
    --   dotnet.run_project()
    -- end)
  end,
}