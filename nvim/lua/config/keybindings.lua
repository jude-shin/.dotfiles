-- ~/.config/nvim/lua/config/keybindings.lua

local map = vim.keymap.set

-- Time allowed between mapped key sequences.
vim.opt.timeoutlen = 400

local opts = {
  noremap = true,
  silent = true,
}

-- Escape remaps
map("i", "kj", "<Esc>", opts)
map("v", "kj", "<Esc>", opts)
map("c", "kj", "<C-C>", opts)

-- Visual search
-- Behavior:
--   Select text in visual mode, press //, and search for the selected text
--   literally.
map("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)
