-- Configuración de tipos de archivo para administración de servidor
local M = {}

function M.setup()
  -- ============================================================================
  -- ARCHIVOS .service (Systemd)
  -- ============================================================================
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.service", "*.timer", "*.socket", "*.mount", "*.target" },
    callback = function()
      vim.bo.filetype = "systemd"
      vim.bo.commentstring = "# %s"
      
      -- Opciones útiles para archivos de servicio
      vim.opt_local.number = true
      vim.opt_local.relativenumber = false
      
      -- Keymaps útiles para servicios
      vim.keymap.set('n', '<leader>sr', function()
        vim.notify("Recuerda hacer: sudo systemctl daemon-reload", vim.log.levels.INFO)
      end, { buffer = true, desc = "Recordatorio: daemon-reload" })
    end,
  })
  
  -- ============================================================================
  -- ARCHIVOS .env (Variables de entorno)
  -- ============================================================================
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.env", ".env.*", "env.*" },
    callback = function()
      vim.bo.filetype = "sh"
      vim.bo.commentstring = "# %s"
      
      -- Opciones de seguridad para archivos .env
      vim.opt_local.number = true
      vim.opt_local.relativenumber = false
      
      -- Advertencia de seguridad
      vim.notify("⚠️  Archivo .env abierto - Contiene variables sensibles", vim.log.levels.WARN)
      
      -- Keymaps útiles
      vim.keymap.set('n', '<leader>ev', function()
        -- Validar formato de variables de entorno
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local errors = {}
        
        for i, line in ipairs(lines) do
          -- Ignorar comentarios y líneas vacías
          if not line:match("^%s*#") and not line:match("^%s*$") then
            -- Validar formato KEY=VALUE
            if not line:match("^[A-Z_][A-Z0-9_]*=") then
              table.insert(errors, "Línea " .. i .. ": formato inválido (debe ser KEY=VALUE)")
            end
          end
        end
        
        if #errors > 0 then
          vim.notify("❌ Errores encontrados:\n" .. table.concat(errors, "\n"), vim.log.levels.ERROR)
        else
          vim.notify("✅ Archivo .env válido", vim.log.levels.INFO)
        end
      end, { buffer = true, desc = "Validar formato .env" })
    end,
  })
  
  -- ============================================================================
  -- ARCHIVOS .properties (Java/Spring)
  -- ============================================================================
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.properties", "application.properties", "application-*.properties" },
    callback = function()
      vim.bo.filetype = "jproperties"
      vim.bo.commentstring = "# %s"
      vim.opt_local.number = true
    end,
  })
  
  -- ============================================================================
  -- ARCHIVOS .conf (Configuración general)
  -- ============================================================================
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.conf", "*.config" },
    callback = function()
      vim.bo.filetype = "conf"
      vim.bo.commentstring = "# %s"
      vim.opt_local.number = true
    end,
  })
  
  -- ============================================================================
  -- SCRIPTS DE SHELL
  -- ============================================================================
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.sh", "*.bash", ".bashrc", ".bash_profile", ".zshrc" },
    callback = function()
      vim.bo.filetype = "sh"
      vim.opt_local.number = true
      vim.opt_local.expandtab = true
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
    end,
  })
  
  -- ============================================================================
  -- ARCHIVOS YAML (docker-compose, ansible, etc.)
  -- ============================================================================
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.yml", "*.yaml" },
    callback = function()
      vim.bo.filetype = "yaml"
      vim.opt_local.number = true
      vim.opt_local.expandtab = true
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
    end,
  })
end

return M
