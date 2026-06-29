-- ~/.config/nvim/ftplugin/java.lua

local jdtls = require("jdtls")

local home = os.getenv("HOME")
local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local root_markers = {
  "gradlew",
  "mvnw",
  ".git",
  "build.gradle",
  "build.gradle.kts",
  "pom.xml",
  "settings.gradle",
  "settings.gradle.kts",
}

local root_dir = require("jdtls.setup").find_root(root_markers)

if root_dir == nil or root_dir == "" then
  return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local config = {
  cmd = {
    home .. "/.local/share/nvim/mason/bin/jdtls",
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,

  capabilities = capabilities,

  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "interactive",
      },
    },
  },

  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)
