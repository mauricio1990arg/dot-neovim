return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = "java",
    config = function()
      -- Configuración básica para activar Lenses y soporte de Spring
      local config = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
        root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
        settings = {
          java = {
            referencesCodeLens = { enabled = true }, -- Activa los Lenses de referencias
            implementationsCodeLens = { enabled = true }, -- Activa Lenses de implementación
          }
        }
      }
      require("jdtls").start_or_attach(config)
    end,
  },
}
