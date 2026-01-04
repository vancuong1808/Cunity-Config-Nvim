local M = {}

local function is_windows()
  return vim.fn.has("win32") == 1
end

local function path_join(...)
  return vim.fs.joinpath(...)
end

local function exists(path)
  return path and path ~= "" and vim.uv.fs_stat(path) ~= nil
end

local function find_root(startpath)
  local start = startpath or vim.api.nvim_buf_get_name(0)
  if start == "" then
    start = vim.uv.cwd() or vim.fn.getcwd()
  end

  local dir = vim.fs.dirname(start)
  if not dir or dir == "" then
    dir = vim.uv.cwd() or vim.fn.getcwd()
  end

  local markers = {
    "pyproject.toml",
    "uv.lock",
    "poetry.lock",
    "Pipfile",
    "requirements.txt",
    "setup.py",
    ".git",
  }

  local root = vim.fs.root(dir, markers)
  return root or dir
end

local function venv_python(venv_dir)
  if not venv_dir or venv_dir == "" then
    return nil
  end

  if is_windows() then
    return path_join(venv_dir, "Scripts", "python.exe")
  end

  return path_join(venv_dir, "bin", "python")
end

function M.detect_python(bufname)
  local root = find_root(bufname)

  local candidates = {
    path_join(root, ".venv"),
    path_join(root, "venv"),
    path_join(root, "env"),
  }

  for _, venv_dir in ipairs(candidates) do
    local py = venv_python(venv_dir)
    if exists(py) then
      return py, root
    end
  end

  -- fall back to system python if present
  local sys = vim.fn.exepath("python")
  if sys ~= nil and sys ~= "" then
    return sys, root
  end
  local py = vim.fn.exepath("py")
  if py ~= nil and py ~= "" then
    return py, root
  end

  return nil, root
end

function M.apply_pyright_python(config, bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr or 0)
  local python_path = nil

  python_path = select(1, M.detect_python(bufname))
  if not python_path then
    return
  end

  config.settings = config.settings or {}
  config.settings.python = config.settings.python or {}

  -- Many pyright clients still respect pythonPath; harmless if ignored.
  config.settings.python.pythonPath = python_path

  config.settings.python.analysis = config.settings.python.analysis or {}
  config.settings.python.analysis.autoSearchPaths = true
  config.settings.python.analysis.useLibraryCodeForTypes = true
end

function M.setup_commands()
  vim.api.nvim_create_user_command("PyrightVenv", function()
    local python_path, root = M.detect_python(vim.api.nvim_buf_get_name(0))
    if not python_path then
      vim.notify("No .venv/venv found and no python in PATH", vim.log.levels.WARN)
      return
    end

    vim.notify("Pyright python: " .. python_path .. "\nRoot: " .. root, vim.log.levels.INFO)
  end, { desc = "Show detected python for pyright" })
end

return M
