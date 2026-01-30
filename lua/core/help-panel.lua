-- ============================================================================
-- PANEL DE AYUDA DE KEYMAPS
-- Muestra una ventana flotante con todos los atajos de teclado organizados
-- ============================================================================

local M = {}

-- Contenido de la ayuda de keymaps organizado por categorías
local function get_help_content()
  return [[
╔══════════════════════════════════════════════════════════════════════════════╗
║                          GUÍA DE ATAJOS DE TECLADO                           ║
╚══════════════════════════════════════════════════════════════════════════════╝

┌─ NAVEGACIÓN BÁSICA ────────────────────────────────────────────────────────┐
│ o/l/k/ñ          Mover arriba/abajo/izquierda/derecha                      │
│ j/{              Ir al inicio/final de línea                               │
│ <M-o>/<M-l>      Scroll 1/4 de página arriba/abajo                         │
└────────────────────────────────────────────────────────────────────────────┘

┌─ EDICIÓN BÁSICA ───────────────────────────────────────────────────────────┐
│ i                Insertar en posición actual                               │
│ p/P              Insertar después/al final de línea                        │
│ O/L              Insertar línea arriba/abajo                               │
│ w/q              Guardar archivo / Cerrar buffer                           │
│ z/Z              Deshacer / Rehacer                                        │
│ Q                Cerrar todo y salir                                       │
└────────────────────────────────────────────────────────────────────────────┘

┌─ CORTAR, COPIAR Y PEGAR ───────────────────────────────────────────────────┐
│ x / xx           Cortar (con movimiento) / Cortar línea                    │
│ c / cc           Copiar (con movimiento) / Copiar línea                    │
│ v / V            Pegar después / Pegar antes                               │
│ > / <            Identar derecha / izquierda                               │
└────────────────────────────────────────────────────────────────────────────┘

┌─ SELECCIÓN VISUAL (s*) ────────────────────────────────────────────────────┐
│ s                Entrar al modo visual (carácter por carácter)             │
│ sw               Seleccionar palabra                                       │
│ sl               Seleccionar línea completa                                │
│ se               Seleccionar hasta el final de línea                       │
│ ss               Seleccionar hasta el inicio de línea                      │
│ <C-d>            Seleccionar palabra bajo cursor (alternativa)             │
│ K/Ñ              Seleccionar hasta inicio/final de línea (alternativa)     │
└────────────────────────────────────────────────────────────────────────────┘

┌─ EXPLORADOR DE ARCHIVOS (Oil) ─────────────────────────────────────────────┐
│ e                Toggle Oil sidebar (derecha)                              │
│ <CR> o ñ         Abrir archivo y cerrar Oil                                │
│ o/l              Navegar arriba/abajo en Oil                               │
│ -                Subir un directorio                                       │
│ gp               Cambiar permisos (chmod)                                  │
│ g.               Toggle archivos ocultos                                   │
└────────────────────────────────────────────────────────────────────────────┘

┌─ NAVEGACIÓN VENTANAS Y BUFFERS ────────────────────────────────────────────┐
│ <C-k/l/o/ñ>      Ir a ventana izq/abajo/arriba/der                         │
│ <M-k>/<M-ñ>      Buffer anterior/siguiente                                 │
│ <leader>1-9      Ir a buffer específico                                    │
│ <leader>x        Cerrar buffer actual                                      │
└────────────────────────────────────────────────────────────────────────────┘

┌─ BÚSQUEDA (Telescope) ─────────────────────────────────────────────────────┐
│ <leader><leader> Buscar archivos (DOBLE ESPACIO) ⭐                         │
│ <leader>fe       Buscar en /etc/                                           │
│ <leader>fS       Buscar en /etc/systemd/system/                            │
│ <leader>fl       Buscar archivos .log                                      │
│ <leader>fL       Buscar en /var/log/                                       │
│ <leader>fc       Buscar archivos de configuración                          │
│ <leader>fg       Grep/buscar texto en archivos                             │
│ <leader>fb       Ver buffers abiertos                                      │
│ <leader>fh       Buscar en ayuda                                           │
└────────────────────────────────────────────────────────────────────────────┘

┌─ SYSTEMD (<leader>s*) ─────────────────────────────────────────────────────┐
│ <leader>sl       Logs de app-provincial.service (journalctl -f)            │
│ <leader>ss       Status del servicio                                       │
│ <leader>sr       Restart servicio                                          │
│ <leader>sS       Stop servicio                                             │
│ <leader>sa       Start servicio                                            │
│ <leader>sd       Daemon reload (después de editar .service)                │
│ <leader>se       Enable servicio al inicio                                 │
│ <leader>sE       Disable servicio del inicio                               │
│ <leader>sL       Listar todos los servicios                                │
│ <leader>sf       Listar servicios fallidos                                 │
│ <leader>st       Terminal systemctl                                        │
│ <leader>sj       Logs del sistema (journalctl -f)                          │
│ <leader>sx       Errores del sistema                                       │
│ :LogsApp         Comando rápido para logs de la app                        │
└────────────────────────────────────────────────────────────────────────────┘

┌─ GIT (<leader>g*) ─────────────────────────────────────────────────────────┐
│ <leader>gg       Abrir/cerrar LazyGit                                      │
│ <leader>ga       Git add (agregar archivos)                                │
│ <leader>gc       Git commit                                                │
│ <leader>gp       Git pull                                                  │
│ <leader>gP       Git push                                                  │
│ <leader>gb       Nueva rama                                                │
│ <leader>go       Checkout rama                                             │
│ <leader>gs       Git status                                                │
│ <leader>gr       Git restore (deshacer cambios)                            │
└────────────────────────────────────────────────────────────────────────────┘

┌─ OPENCODE (<leader>a*) ────────────────────────────────────────────────────┐
│ <leader>aa       Abrir/cerrar panel de OpenCode                            │
│ <leader>ac       Consultar sobre selección (modo visual)                   │
│ <leader>as       Consultar sobre buffer activo                             │
└────────────────────────────────────────────────────────────────────────────┘

┌─ LSP BÁSICO (Solo archivos de configuración) ─────────────────────────────┐
│ K                Mostrar documentación (hover)                             │
│ [d / ]d          Diagnóstico anterior/siguiente                            │
│ <leader>e        Mostrar diagnóstico flotante                              │
└────────────────────────────────────────────────────────────────────────────┘

┌─ TERMINAL (<leader>t*) ────────────────────────────────────────────────────┐
│ <leader>t        Toggle terminal horizontal                                │
│ <leader>T        Toggle terminal flotante                                  │
│ <Esc>            Salir de modo insert en terminal                          │
└────────────────────────────────────────────────────────────────────────────┘

┌─ LOGS (Visualización de archivos .log) ────────────────────────────────────┐
│ <leader>lt       Tail -f mode (auto-scroll)                                │
│ <leader>lr       Recargar log                                              │
│ <leader>le       Buscar siguiente ERROR/FATAL                              │
│ <leader>lw       Buscar siguiente WARNING                                  │
└────────────────────────────────────────────────────────────────────────────┘

┌─ ARCHIVOS .env ────────────────────────────────────────────────────────────┐
│ <leader>ev       Validar formato .env (KEY=VALUE)                          │
└────────────────────────────────────────────────────────────────────────────┘

┌─ ZOOM Y FOCUS (<leader>z*) ────────────────────────────────────────────────┐
│ <leader>z+/-     Zoom in/out de fuente (Kitty)                             │
│ <leader>z0       Resetear tamaño de fuente                                 │
│ <C-w>m           Maximizar/Restaurar ventana                               │
│ <leader>zf       Activar modo focus                                        │
│ <leader>zF       Desactivar modo focus                                     │
└────────────────────────────────────────────────────────────────────────────┘

┌─ AYUDA ────────────────────────────────────────────────────────────────────┐
│ <leader>?        Mostrar esta ayuda                                        │
│ <Esc> o q        Cerrar esta ventana de ayuda                              │
└────────────────────────────────────────────────────────────────────────────┘

  Presiona <Esc> o q para cerrar esta ventana
]]
end

-- Mostrar la ventana flotante con los keymaps
function M.show()
  -- Crear buffer scratch para la ayuda
  local buf = vim.api.nvim_create_buf(false, true)
  
  -- Obtener el contenido de la ayuda
  local content = get_help_content()
  local lines = vim.split(content, '\n')
  
  -- Establecer el contenido en el buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  
  -- Hacer el buffer de solo lectura
  vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
  vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
  vim.api.nvim_set_option_value('swapfile', false, { buf = buf })
  
  -- Calcular tamaño de la ventana (90% del ancho y alto)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  
  -- Calcular posición centrada
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  -- Configuración de la ventana flotante
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' Guía de Atajos de Teclado ',
    title_pos = 'center',
  }
  
  -- Crear la ventana flotante
  local win = vim.api.nvim_open_win(buf, true, opts)
  
  -- Configurar opciones de la ventana
  vim.api.nvim_set_option_value('winblend', 5, { win = win })
  vim.api.nvim_set_option_value('wrap', false, { win = win })
  vim.api.nvim_set_option_value('cursorline', true, { win = win })
  
  -- Mapeos para cerrar la ventana
  local close_keys = { 'q', '<Esc>' }
  for _, key in ipairs(close_keys) do
    vim.api.nvim_buf_set_keymap(buf, 'n', key, '<cmd>close<cr>',
      { noremap = true, silent = true })
  end
  
  -- Permitir scroll con las teclas personalizadas (o/l)
  vim.api.nvim_buf_set_keymap(buf, 'n', 'o', 'k',
    { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'l', 'j',
    { noremap = true, silent = true })
end

return M
