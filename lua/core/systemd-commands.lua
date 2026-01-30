-- ============================================================================
-- COMANDOS DE SYSTEMD - Gestión de servicios del servidor
-- ============================================================================

local M = {}

-- Nombre del servicio principal de la aplicación
local APP_SERVICE = "app-provincial.service"

-- Función auxiliar para ejecutar comandos en terminal flotante
local function execute_command(cmd, title)
  local Terminal = require("toggleterm.terminal").Terminal
  
  local term = Terminal:new({
    cmd = cmd,
    direction = "float",
    close_on_exit = false,
    on_open = function(t)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(t.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(t.bufnr, "n", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  })
  
  term:toggle()
end

-- ============================================================================
-- COMANDOS DE GESTIÓN DE SERVICIOS
-- ============================================================================

-- Ver logs de la aplicación con journalctl
function M.logs_app()
  vim.notify("📋 Abriendo logs de " .. APP_SERVICE .. "...", vim.log.levels.INFO)
  execute_command(
    "journalctl -u " .. APP_SERVICE .. " -f -n 100",
    "Logs: " .. APP_SERVICE
  )
end

-- Ver estado del servicio
function M.status_app()
  vim.notify("📊 Estado de " .. APP_SERVICE, vim.log.levels.INFO)
  execute_command(
    "systemctl status " .. APP_SERVICE .. " && echo '\nPresiona q para cerrar'",
    "Status: " .. APP_SERVICE
  )
end

-- Reiniciar servicio
function M.restart_app()
  vim.ui.input({
    prompt = "¿Reiniciar " .. APP_SERVICE .. "? (s/n): ",
  }, function(input)
    if input and (input:lower() == "s" or input:lower() == "y") then
      vim.notify("🔄 Reiniciando " .. APP_SERVICE .. "...", vim.log.levels.INFO)
      execute_command(
        "sudo systemctl restart " .. APP_SERVICE .. " && echo '✅ Servicio reiniciado' && sleep 2 && systemctl status " .. APP_SERVICE,
        "Restart: " .. APP_SERVICE
      )
    end
  end)
end

-- Detener servicio
function M.stop_app()
  vim.ui.input({
    prompt = "¿Detener " .. APP_SERVICE .. "? (s/n): ",
  }, function(input)
    if input and (input:lower() == "s" or input:lower() == "y") then
      vim.notify("🛑 Deteniendo " .. APP_SERVICE .. "...", vim.log.levels.INFO)
      execute_command(
        "sudo systemctl stop " .. APP_SERVICE .. " && echo '✅ Servicio detenido' && systemctl status " .. APP_SERVICE,
        "Stop: " .. APP_SERVICE
      )
    end
  end)
end

-- Iniciar servicio
function M.start_app()
  vim.notify("▶️  Iniciando " .. APP_SERVICE .. "...", vim.log.levels.INFO)
  execute_command(
    "sudo systemctl start " .. APP_SERVICE .. " && echo '✅ Servicio iniciado' && sleep 2 && systemctl status " .. APP_SERVICE,
    "Start: " .. APP_SERVICE
  )
end

-- Recargar daemon (después de editar .service)
function M.daemon_reload()
  vim.notify("🔄 Recargando systemd daemon...", vim.log.levels.INFO)
  execute_command(
    "sudo systemctl daemon-reload && echo '✅ Daemon recargado' && echo 'Presiona q para cerrar'",
    "Systemd Daemon Reload"
  )
end

-- Habilitar servicio al inicio
function M.enable_app()
  vim.notify("⚙️  Habilitando " .. APP_SERVICE .. " al inicio...", vim.log.levels.INFO)
  execute_command(
    "sudo systemctl enable " .. APP_SERVICE .. " && echo '✅ Servicio habilitado al inicio' && systemctl status " .. APP_SERVICE,
    "Enable: " .. APP_SERVICE
  )
end

-- Deshabilitar servicio al inicio
function M.disable_app()
  vim.notify("⚙️  Deshabilitando " .. APP_SERVICE .. " del inicio...", vim.log.levels.INFO)
  execute_command(
    "sudo systemctl disable " .. APP_SERVICE .. " && echo '✅ Servicio deshabilitado del inicio' && systemctl status " .. APP_SERVICE,
    "Disable: " .. APP_SERVICE
  )
end

-- Listar todos los servicios
function M.list_services()
  vim.notify("📋 Listando servicios del sistema...", vim.log.levels.INFO)
  execute_command(
    "systemctl list-units --type=service --all",
    "Systemd Services"
  )
end

-- Listar servicios activos
function M.list_active_services()
  vim.notify("📋 Listando servicios activos...", vim.log.levels.INFO)
  execute_command(
    "systemctl list-units --type=service --state=running",
    "Active Services"
  )
end

-- Listar servicios fallidos
function M.list_failed_services()
  vim.notify("❌ Listando servicios fallidos...", vim.log.levels.INFO)
  execute_command(
    "systemctl list-units --type=service --state=failed",
    "Failed Services"
  )
end

-- Ver logs del sistema completo
function M.system_logs()
  vim.notify("📋 Abriendo logs del sistema...", vim.log.levels.INFO)
  execute_command(
    "journalctl -f -n 100",
    "System Logs (journalctl)"
  )
end

-- Ver logs de errores del sistema
function M.system_errors()
  vim.notify("❌ Buscando errores del sistema...", vim.log.levels.INFO)
  execute_command(
    "journalctl -p err -n 100",
    "System Errors"
  )
end

-- Terminal interactiva para systemctl
function M.systemctl_terminal()
  local Terminal = require("toggleterm.terminal").Terminal
  
  if M.systemctl_term == nil then
    M.systemctl_term = Terminal:new({
      direction = "horizontal",
      size = 15,
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.notify("Terminal Systemd abierta. Usa 'systemctl' directamente.", vim.log.levels.INFO)
      end,
    })
  end
  M.systemctl_term:toggle()
end

return M
