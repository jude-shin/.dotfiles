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

vim.lsp.start({
  name = "pyright",

  cmd = {
    "pyright-langserver",
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

vim.lsp.start({
  name = "ruff",

  cmd = {
    "ruff",
    "server",
  },

  root_dir = root_dir,
  capabilities = capabilities,
})
