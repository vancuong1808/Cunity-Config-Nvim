local M = {}

local function url_encode(str)
  return (str:gsub("[^%w%-_%.~]", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

function M.open_url(url)
  if type(url) ~= "string" or url == "" then
    return
  end

  if vim.fn.has("win32") == 1 then
    -- `start` needs a title argument (empty string) before the URL.
    vim.fn.jobstart({ "cmd.exe", "/c", "start", "", url }, { detach = true })
    return
  end

  if vim.fn.has("mac") == 1 then
    vim.fn.jobstart({ "open", url }, { detach = true })
    return
  end

  vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end

function M.prompt(prompt, cb)
  vim.ui.input({ prompt = prompt }, function(input)
    if not input or input == "" then
      return
    end
    cb(input)
  end)
end

function M.search_devdocs(query)
  local url = "https://devdocs.io/#q=" .. url_encode(query)
  M.open_url(url)
end

function M.search_learn_dotnet(query)
  -- Keep it official + always up-to-date: Learn global search.
  local terms = "dotnet " .. query
  local url = "https://learn.microsoft.com/en-us/search/?terms=" .. url_encode(terms)
  M.open_url(url)
end

local function floaterm_cmd(cmd)
  if vim.fn.exists(":FloatermNew") == 2 then
    vim.cmd("FloatermNew --autoclose=0 " .. cmd)
    return true
  end

  vim.cmd("terminal " .. cmd)
  return true
end

function M.pydoc(symbol)
  symbol = symbol or vim.fn.expand("<cword>")
  if not symbol or symbol == "" then
    return
  end

  if vim.fn.executable("python") == 1 then
    return floaterm_cmd("python -m pydoc " .. vim.fn.shellescape(symbol))
  end

  if vim.fn.executable("py") == 1 then
    return floaterm_cmd("py -m pydoc " .. vim.fn.shellescape(symbol))
  end

  vim.notify("python/py not found in PATH (needed for pydoc)", vim.log.levels.WARN)
end

function M.godoc(symbol)
  symbol = symbol or vim.fn.expand("<cword>")
  if not symbol or symbol == "" then
    return
  end

  if vim.fn.executable("go") ~= 1 then
    vim.notify("go not found in PATH (needed for go doc)", vim.log.levels.WARN)
    return
  end

  -- `go doc` works for stdlib + modules in GOPATH/module cache.
  return floaterm_cmd("go doc " .. vim.fn.shellescape(symbol))
end

function M.setup_commands()
  vim.api.nvim_create_user_command("DevDocsSearch", function()
    M.prompt("DevDocs search: ", M.search_devdocs)
  end, { desc = "Search DevDocs in browser" })

  vim.api.nvim_create_user_command("DotnetLearnSearch", function()
    M.prompt(".NET (Learn) search: ", M.search_learn_dotnet)
  end, { desc = "Search Microsoft Learn (.NET) in browser" })

  vim.api.nvim_create_user_command("PyDoc", function(opts)
    local arg = opts.args ~= "" and opts.args or nil
    M.pydoc(arg)
  end, { desc = "Run pydoc for symbol", nargs = "?" })

  vim.api.nvim_create_user_command("GoDoc", function(opts)
    local arg = opts.args ~= "" and opts.args or nil
    M.godoc(arg)
  end, { desc = "Run go doc for symbol", nargs = "?" })
end

return M
