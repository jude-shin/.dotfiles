-- ~/.config/nvim/lua/config/filetype.lua

local api = vim.api

-- Writing-oriented filetypes: plain text, Markdown, TeX/LaTeX
local writing_group = api.nvim_create_augroup("WritingFiletypes", { clear = true })

api.nvim_create_autocmd("FileType", {
  group = writing_group,
  pattern = { "text", "markdown", "tex" },
  callback = function()
    -- Enable spell checking
    vim.opt_local.spell = true

    -- Add dictionary
    vim.opt_local.dictionary:append("/usr/share/dict/cracklib-small")

    -- Navigate wrapped display lines instead of physical lines
    vim.keymap.set("n", "j", "gj", {
      buffer = true,
      noremap = true,
      silent = true,
    })

    vim.keymap.set("n", "k", "gk", {
      buffer = true,
      noremap = true,
      silent = true,
    })

    -- Do not break words visually at line wrap
    vim.opt_local.linebreak = true
  end,
})

-- Extra TeX syntax highlighting for lstlisting blocks
api.nvim_create_autocmd("FileType", {
  group = writing_group,
  pattern = "tex",
  command = [[syntax region texZone start='\\begin{lstlisting}' end='\\end{lstlisting}']],
})


-- C-oriented settings
local c_group = api.nvim_create_augroup("CFiletypes", { clear = true })

api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
  group = c_group,
  pattern = { "*.c", "*.h" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.showmatch = true
    vim.opt_local.matchtime = 1
  end,
})
