-- ~/.config/nvim/ftplugin/kotlin.lua

local root_dir = vim.fs.root(0, {
  "settings.gradle",
  "settings.gradle.kts",
  "build.gradle",
  "build.gradle.kts",
  "pom.xml",
  ".git",
})

if root_dir == nil then
  return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Kotlin Language Server: Kotlin-aware diagnostics, completion,
-- hover, go-to-definition, symbols, formatting, and refactoring support.
vim.lsp.start({
  name = "kotlin_language_server",

  cmd = {
    vim.fn.expand("~/.local/share/nvim/mason/bin/kotlin-language-server"),
  },

  root_dir = root_dir,

  capabilities = capabilities,
})

-- ktlint: Kotlin style linting.
--
-- This runs ktlint manually on save and sends results into Neovim diagnostics.
-- It is deliberately separate from the language server.
local ktlint_group = vim.api.nvim_create_augroup("KotlinKtlint", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = ktlint_group,
  buffer = 0,
  callback = function()
    local file = vim.api.nvim_buf_get_name(0)

    if file == "" then
      return
    end

    local cmd = {
      vim.fn.expand("~/.local/share/nvim/mason/bin/ktlint"),
      "--reporter=json",
      file,
    }

    vim.system(cmd, { text = true }, function(result)
      vim.schedule(function()
        local diagnostics = {}

        if result.stdout == nil or result.stdout == "" then
          vim.diagnostic.set(vim.api.nvim_create_namespace("ktlint"), 0, diagnostics)
          return
        end

        local ok, decoded = pcall(vim.json.decode, result.stdout)

        if not ok or decoded == nil then
          return
        end

        for _, file_result in ipairs(decoded) do
          for _, error in ipairs(file_result.errors or {}) do
            table.insert(diagnostics, {
              lnum = math.max((error.line or 1) - 1, 0),
              col = math.max((error.column or 1) - 1, 0),
              severity = vim.diagnostic.severity.WARN,
              source = "ktlint",
              message = error.message or "ktlint warning",
            })
          end
        end

        vim.diagnostic.set(vim.api.nvim_create_namespace("ktlint"), 0, diagnostics)
      end)
    end)
  end,
})
