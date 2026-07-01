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

-- basedpyright: Pyright-compatible type checking and Python language intelligence,
-- installed from PyPI instead of npm.
vim.lsp.start({
  name = "basedpyright",

  cmd = {
    "basedpyright-langserver",
    "--stdio",
  },

  root_dir = root_dir,

  capabilities = capabilities,

  settings = {
    basedpyright = {
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
vim.lsp.start({
  name = "ruff",

  cmd = {
    vim.fn.expand("~/.local/share/nvim/mason/bin/ruff"),
    "server",
  },

  root_dir = root_dir,

  capabilities = capabilities,
})
