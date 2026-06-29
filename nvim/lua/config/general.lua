-- ~/.config/nvim/lua/config/general.lua

---- LOOKS ----
-- Visual guide at column 80
vim.opt.colorcolumn = "80"

-- Keep the sign column fixed so diagnostics do not shift text horizontally
vim.opt.signcolumn = "yes"

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Keep cursor away from top/bottom edge
vim.opt.scrolloff = 5

-- Cursor is always a block
vim.opt.guicursor = "a:block"

---- FEELS ----

-- Update time (for things like showing errors/warnings)
vim.opt.updatetime = 300

---- GENERAL  ----
-- Indentation
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Search behavior
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.shortmess:remove("S")		-- Do not show search count in the command area

-- Automatically save and restore folds/views
local view_group = vim.api.nvim_create_augroup("AutoSaveLoadView", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
  group = view_group,
  pattern = "*.*",
  command = "mkview",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = view_group,
  pattern = "*.*",
  command = "silent! loadview",
})

-- Stop comments from continuing automatically after pressing Enter
-- TODO: I don't think this really works
local format_group = vim.api.nvim_create_augroup("FormatOptions", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = format_group,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

