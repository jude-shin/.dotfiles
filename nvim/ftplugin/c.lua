-- ~/.config/nvim/ftplugin/c.lua

vim.lsp.start({
  name = "clangd",

  cmd = {
    vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"),
  },

  root_dir = vim.fs.root(0, {
    "compile_commands.json",
    "compile_flags.txt",
    ".git",
  }),

  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
