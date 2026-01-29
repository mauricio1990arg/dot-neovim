-- ~/.config/nvim/lua/plugins/java.lua
return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          local jdtls = require("jdtls")
          
          -- Paths
          local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
          local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
          
          -- IMPORTANTE: Usar el lombok.jar descargado manualmente
          local lombok_path = vim.fn.expand("~/.local/share/nvim/jdtls/lombok.jar")
          
          -- Verificar que lombok.jar existe (clave del artículo)
          if vim.fn.filereadable(lombok_path) == 0 then
            vim.notify("⚠️ Lombok jar NO encontrado en: " .. lombok_path, vim.log.levels.ERROR)
            vim.notify("Descarga lombok.jar de https://projectlombok.org/download", vim.log.levels.WARN)
          else
            vim.notify("✓ Lombok jar encontrado en: " .. lombok_path, vim.log.levels.INFO)
          end
          
          -- Root del proyecto
          local root_dir = vim.fs.dirname(
            vim.fs.find({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }, { upward = true })[1]
          )
          
          if not root_dir then
            return
          end
          
          local config = {
            cmd = {
              "jdtls",
              "-data", workspace_dir,
              "-javaagent:" .. lombok_path,  -- ← Forma correcta según el artículo
            },
            root_dir = root_dir,
            settings = {
              java = {
                eclipse = { downloadSources = true },
                maven = { downloadSources = true },
                configuration = { updateBuildConfiguration = "automatic" },
                references = { includeDecompiledSources = true },
                format = { enabled = true },
              },
            },
            init_options = {
              bundles = {},
            },
            on_attach = function(client, bufnr)
              if client.server_capabilities then
                client.server_capabilities.workDoneProgress = false
              end
              
              local opts = { buffer = bufnr, noremap = true, silent = true }
              
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
              vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
              vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
              vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
              
              vim.notify("✓ Java LSP activo", vim.log.levels.INFO)
            end,
          }
          
          jdtls.start_or_attach(config)
        end,
      })
      
      -- Auto-reload Maven
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "pom.xml",
        callback = function()
          vim.notify("🔄 Recargando Maven...", vim.log.levels.INFO)
          vim.lsp.buf.execute_command({
            command = "java.projectConfiguration.update",
            arguments = { vim.uri_from_fname(vim.fn.expand("%:p")) }
          })
          vim.defer_fn(function()
            vim.cmd("LspRestart")
            vim.notify("✓ Maven recargado", vim.log.levels.INFO)
          end, 2000)
        end,
      })
    end,
  },
}