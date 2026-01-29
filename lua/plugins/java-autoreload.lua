-- ~/.config/nvim/lua/plugins/java-autoreload.lua
return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      -- Tu configuración actual de jdtls...
      local jdtls = require("jdtls")
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
      local lombok_path = vim.fn.expand("~/.local/share/nvim/jdtls/lombok.jar")
      
      local config = {
        cmd = {
          "jdtls",
          "-data", workspace_dir,
          "--jvm-arg=-javaagent:" .. lombok_path,
          "--jvm-arg=-Xbootclasspath/a:" .. lombok_path,
        },
        root_dir = vim.fs.dirname(
          vim.fs.find({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }, { upward = true })[1]
        ) or vim.fn.getcwd(),
        settings = {
          java = {
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            configuration = { updateBuildConfiguration = "automatic" }, -- ← IMPORTANTE
            references = { includeDecompiledSources = true },
            format = { enabled = true },
          },
        },
        init_options = {
          bundles = {},
        },
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, noremap = true, silent = true }
          
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          
          vim.notify("✓ Java LSP con Lombok activo", vim.log.levels.INFO)
        end,
      }
      
      jdtls.start_or_attach(config)
      
      -- Auto-reload cuando pom.xml cambia
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "pom.xml",
        callback = function()
          vim.notify("🔄 Recargando proyecto Maven...", vim.log.levels.INFO)
          
          -- Actualizar configuración del proyecto
          vim.lsp.buf.execute_command({
            command = "java.projectConfiguration.update",
            arguments = { vim.uri_from_fname(vim.fn.expand("%:p")) }
          })
          
          -- Esperar un poco y reiniciar LSP
          vim.defer_fn(function()
            vim.cmd("LspRestart")
            vim.notify("✓ Maven recargado", vim.log.levels.INFO)
          end, 2000)
        end,
      })
    end,
  },
}