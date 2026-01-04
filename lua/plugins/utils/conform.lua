return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      desc = "Format file",
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { "stylua" },

      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      jsonc = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
      markdown = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },

      python = { "isort", "black" },

      go = { "gofumpt", "goimports", "gofmt" },

      sql = { "sqlfluff", "sql-formatter", "sqlfmt" },

      cs = { "csharpier" },
      csharp = { "csharpier" },
    },
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      local disabled = {
        [""] = true,
        ["neo-tree"] = true,
        ["floaterm"] = true,
        ["TelescopePrompt"] = true,
        ["lazy"] = true,
        ["mason"] = true,
        ["help"] = true,
      }
      if disabled[ft] then
        return
      end
      return { timeout_ms = 2000, lsp_format = "fallback" }
    end,
  },
}
