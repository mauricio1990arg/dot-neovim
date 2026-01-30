-- Configuración específica para archivos de log
local M = {}

function M.setup()
  -- Detectar archivos .log automáticamente
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.log", "*-log", "syslog", "messages" },
    callback = function()
      vim.bo.filetype = "log"
    end,
  })
  
  -- Optimizaciones para archivos grandes (logs)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "log",
    callback = function()
      -- Deshabilitar features pesadas
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.list = false
      vim.opt_local.number = true
      vim.opt_local.relativenumber = false
      
      -- Modo de solo lectura por defecto para logs del sistema
      local filepath = vim.fn.expand("%:p")
      if filepath:match("^/var/log/") or filepath:match("^/etc/") then
        vim.opt_local.readonly = true
        vim.notify("Archivo del sistema abierto en modo solo lectura", vim.log.levels.INFO)
      end
      
      -- Scroll automático al final del archivo (útil para logs en tiempo real)
      vim.keymap.set('n', '<leader>lt', function()
        vim.cmd('normal! G')
        vim.opt_local.autoread = true
        vim.notify("Auto-scroll activado. Presiona Ctrl+C para detener.", vim.log.levels.INFO)
      end, { buffer = true, desc = "Activar tail -f mode" })
      
      -- Recargar archivo (útil para logs activos)
      vim.keymap.set('n', '<leader>lr', function()
        vim.cmd('checktime')
        vim.notify("Log recargado", vim.log.levels.INFO)
      end, { buffer = true, desc = "Recargar log" })
      
      -- Buscar errores comunes en logs
      vim.keymap.set('n', '<leader>le', function()
        vim.fn.search("ERROR\\|error\\|Error\\|FATAL\\|fatal\\|Fatal", "w")
      end, { buffer = true, desc = "Buscar siguiente error" })
      
      vim.keymap.set('n', '<leader>lE', function()
        vim.fn.search("ERROR\\|error\\|Error\\|FATAL\\|fatal\\|Fatal", "bw")
      end, { buffer = true, desc = "Buscar error anterior" })
      
      -- Buscar warnings en logs
      vim.keymap.set('n', '<leader>lw', function()
        vim.fn.search("WARN\\|warn\\|Warn\\|WARNING\\|warning\\|Warning", "w")
      end, { buffer = true, desc = "Buscar siguiente warning" })
    end,
  })
  
  -- Auto-reload para logs que están siendo escritos
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    pattern = "*.log",
    callback = function()
      if vim.fn.getcmdwintype() == '' then
        vim.cmd('checktime')
      end
    end,
  })
end

return M
