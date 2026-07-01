-- ~/.config/nvim/ftplugin/python.lua

local root_dir = vim.fs.root(0, {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  ".git",
})

if root_dir == nil then
  return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Pyright: type checking, import resolution, hover, go-to-definition,
-- completion, and project-aware Python diagnostics.
vim.lsp.start({
  name = "pyright",

  cmd = {
    vim.fn.expand("~/.local/share/nvim/mason/bin/pyright-langserver"),
    "--stdio",
  },

  root_dir = root_dir,

  capabilities = capabilities,

  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})

-- Ruff: fast Python linting and import/style diagnostics.
-- This complements Pyright instead of replacing it.
vim.lsp.start({
  name = "ruff",

  cmd = {
    vim.fn.expand("~/.local/share/nvim/mason/bin/ruff"),
    "server",
  },

  root_dir = root_dir,

  capabilities = capabilities,
})
