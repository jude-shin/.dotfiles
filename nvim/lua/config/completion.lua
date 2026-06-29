-- ~/.config/nvim/lua/config/completion.lua

local cmp = require("cmp")

cmp.setup({
  completion = {
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
    },
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),

    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),

    ["<CR>"] = cmp.mapping.confirm({
      select = false,
    }),

    ["<C-e>"] = cmp.mapping.abort(),
  }),

  sources = cmp.config.sources({
    -- Java-aware completions from jdtls:
    -- classes, methods, fields, imports, package symbols, etc.
    { name = "nvim_lsp" },

    -- Words already present in the current file.
    { name = "buffer" },

    -- File path completion.
    { name = "path" },
  }),
})

vim.diagnostic.config({
  virtual_text = false, -- keeps warnings/errors from cluttering the line
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,

  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Show diagnostic message in a floating window when the cursor rests
-- on a warning/error.
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
    })
  end,
})
