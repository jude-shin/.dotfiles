-- ~/.config/nvim/lua/plugins/mason.lua

return {
  {
    -- Tool installer/manager for Neovim.
    --
    -- We used this to install jdtls after the direct Eclipse download path
    -- caused problems. Mason keeps the jdtls files under:
    -- ~/.local/share/nvim/mason/
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
}
