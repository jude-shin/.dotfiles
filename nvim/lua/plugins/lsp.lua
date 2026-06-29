-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  {
    -- Common configuration data for Neovim's built-in LSP client.
    --
    -- This does not install language servers by itself.
    -- We mostly keep it because many LSP examples/plugins expect it,
    -- and it gives us standard LSP plumbing.
    "neovim/nvim-lspconfig",
  },
}
