-- ============================================================================
-- CONFIGURACIÓN CENTRALIZADA DE ATAJOS DE TECLADO
-- Todos los atajos de nvim organizados por categoría
-- ============================================================================

vim.g.mapleader = " "
local keymap = vim.keymap

-- ============================================================================
-- 1. NAVEGACIÓN BÁSICA VIM (Modo Normal y Visual)
-- ============================================================================
-- Mapeos personalizados: arriba (o), abajo (l), izq (k), der (ñ)

-- Modo Normal
keymap.set("n", "o", "k", { desc = "Mover arriba" })
keymap.set("n", "l", "j", { desc = "Mover abajo" })
keymap.set("n", "k", "h", { desc = "Mover izquierda" })
keymap.set("n", "ñ", "l", { desc = "Mover derecha" })

-- Modo Visual
keymap.set("v", "o", "k", { desc = "Mover arriba (visual)" })
keymap.set("v", "l", "j", { desc = "Mover abajo (visual)" })
keymap.set("v", "k", "h", { desc = "Mover izquierda (visual)" })
keymap.set("v", "ñ", "l", { desc = "Mover derecha (visual)" })

-- ============================================================================
-- 2. INSERCIÓN DE TEXTO
-- ============================================================================
keymap.set("n", "i", "i", { desc = "Insertar en posición actual" })
keymap.set("n", "p", "a", { desc = "Insertar a la derecha del cursor" })
keymap.set("n", "P", "A", { desc = "Insertar al final de la línea" })
keymap.set("n", "O", "O", { desc = "Insertar línea arriba" })
keymap.set("n", "L", "o", { desc = "Insertar línea abajo" })

-- ============================================================================
-- 3. ARCHIVOS Y EDICIÓN BÁSICA
-- ============================================================================
keymap.set("n", "e", "<cmd>Oil<cr>", { desc = "Abrir Oil (explorador de archivos)" })
keymap.set("n", "w", ":w<CR>", { desc = "Guardar archivo" })
keymap.set("n", "q", ":bdelete<CR>", { desc = "Cerrar buffer actual" })
keymap.set("n", "z", "u", { desc = "Deshacer cambios" })
keymap.set("n", "Z", "<C-r>", { desc = "Rehacer cambios" })
keymap.set("n", "Q", ":qa!<CR>", { desc = "Cerrar todo y salir de Neovim" })

-- ============================================================================
-- 3.1. CORTAR, COPIAR Y PEGAR
-- ============================================================================
-- x abre el menú para cortar (funciona como d - delete)
keymap.set("n", "x", "d", { desc = "Menú de cortar (x + movimiento, o xx para línea)" })
keymap.set("n", "xx", "dd", { desc = "Cortar línea completa" })
keymap.set("v", "x", "d", { desc = "Cortar selección visual" })

-- c abre el menú para copiar (funciona como y - yank)
keymap.set("n", "c", "y", { desc = "Menú de copiar (c + movimiento, o cc para línea)" })
keymap.set("n", "cc", "yy", { desc = "Copiar línea completa" })
keymap.set("v", "c", "y", { desc = "Copiar selección visual" })

-- v para pegar después del cursor, V para pegar antes
keymap.set("n", "v", "p", { desc = "Pegar después del cursor" })
keymap.set("n", "V", "P", { desc = "Pegar antes del cursor" })
keymap.set("v", "v", "p", { desc = "Pegar en selección visual" })
keymap.set("v", "V", "P", { desc = "Pegar antes en selección visual" })

-- ============================================================================
-- 3.2. IDENTACIÓN
-- ============================================================================
-- > para identar a la derecha, < para identar a la izquierda
keymap.set("n", ">", ">>", { desc = "Identar línea a la derecha" })
keymap.set("n", "<", "<<", { desc = "Identar línea a la izquierda" })
keymap.set("v", ">", ">gv", { desc = "Identar selección a la derecha" })
keymap.set("v", "<", "<gv", { desc = "Identar selección a la izquierda" })

-- ============================================================================
-- 4. MOVIMIENTO ENTRE VENTANAS
-- ============================================================================
keymap.set("n", "<C-k>", "<C-w>h", { desc = "Ir a ventana izquierda" })
keymap.set("n", "<C-l>", "<C-w>j", { desc = "Ir a ventana abajo" })
keymap.set("n", "<C-ñ>", "<C-w>l", { desc = "Ir a ventana derecha" })
keymap.set("n", "<C-o>", "<C-w>k", { desc = "Ir a ventana arriba" })

-- ============================================================================
-- 5. NAVEGACIÓN ENTRE BUFFERS (Archivos Abiertos)
-- ============================================================================
keymap.set("n", "<M-k>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer anterior" })
keymap.set("n", "<M-ñ>", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer siguiente" })
keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Cerrar buffer actual" })

-- Saltos directos a buffers específicos
keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Ir a buffer 1" })
keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Ir a buffer 2" })
keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Ir a buffer 3" })
keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Ir a buffer 4" })
keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Ir a buffer 5" })
keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "Ir a buffer 6" })
keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "Ir a buffer 7" })
keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "Ir a buffer 8" })
keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "Ir a buffer 9" })

-- ============================================================================
-- 6. NAVEGACIÓN DE EXTREMOS DE LÍNEA
-- ============================================================================
-- Modo Normal
keymap.set("n", "j", "^", { desc = "Ir al inicio de la línea" })
keymap.set("n", "{", "$", { desc = "Ir al final de la línea" })

-- Modo Visual
keymap.set("v", "j", "^", { desc = "Ir al inicio de la línea (visual)" })
keymap.set("v", "{", "$", { desc = "Ir al final de la línea (visual)" })

-- ============================================================================
-- 7. SELECCIÓN VISUAL (s*)
-- ============================================================================
-- s para entrar al modo visual carácter por carácter
keymap.set("n", "s", "v", { desc = "Entrar al modo visual (carácter)" })

-- sw para seleccionar palabra
keymap.set("n", "sw", "viw", { desc = "Seleccionar palabra" })

-- sl para seleccionar línea completa
keymap.set("n", "sl", "V", { desc = "Seleccionar línea completa" })

-- se para seleccionar hasta el final de línea
keymap.set("n", "se", "v$", { desc = "Seleccionar hasta el final de línea" })

-- ss para seleccionar hasta el inicio de línea
keymap.set("n", "ss", "v^", { desc = "Seleccionar hasta el inicio de línea" })

-- Atajos alternativos
keymap.set("n", "K", "v^", { desc = "Seleccionar hasta el inicio de línea (alt)" })
keymap.set("n", "Ñ", "v$", { desc = "Seleccionar hasta el final de línea (alt)" })

-- Ctrl+d para seleccionar palabra bajo cursor (alternativa a sw)
keymap.set("n", "<C-d>", "viw", { desc = "Seleccionar palabra completa bajo cursor" })

-- Ctrl+s también entra al modo visual (alternativa a s)
keymap.set("n", "<C-s>", "v", { desc = "Entrar al modo visual" })

-- En modo visual, Ctrl+s selecciona la palabra completa
keymap.set("v", "<C-s>", function()
    vim.cmd("normal! bw")
    vim.cmd("normal! aw")
end, { desc = "Seleccionar palabra completa" })

-- ============================================================================
-- 8. SCROLL Y CENTRADO
-- ============================================================================
-- Scroll 1/4 de página (en lugar de 1/2)
keymap.set("n", "<M-l>", function()
    local lines = math.floor(vim.api.nvim_win_get_height(0) / 4)
    vim.cmd("normal! " .. lines .. "jzz")
end, { desc = "Scroll down 1/4 de página y centrar" })

keymap.set("n", "<M-o>", function()
    local lines = math.floor(vim.api.nvim_win_get_height(0) / 4)
    vim.cmd("normal! " .. lines .. "kzz")
end, { desc = "Scroll up 1/4 de página y centrar" })

-- ============================================================================
-- 9. MODOS (Volver a modo normal)
-- ============================================================================
-- Tab para volver al modo normal desde Insert y Visual
-- IMPORTANTE: Se usa Tab en lugar de Escape para evitar conflictos con OpenCode y otros plugins
keymap.set('i', '<Tab>', '<Esc>', { desc = "Salir al modo normal desde Insert" })
keymap.set('v', '<Tab>', '<Esc>', { desc = "Salir al modo normal desde Visual" })

-- ============================================================================
-- 10. TERMINAL (ToggleTerm)
-- ============================================================================
-- Leader + t para abrir/cerrar terminal horizontal (ID 1)
keymap.set('n', '<leader>t', '<cmd>1ToggleTerm direction=horizontal<cr>', { desc = "Toggle terminal horizontal" })

-- Leader + T para abrir/cerrar terminal flotante (ID 2)
keymap.set('n', '<leader>T', '<cmd>2ToggleTerm direction=float<cr>', { desc = "Toggle terminal flotante" })

-- En modo terminal:
-- IMPORTANTE: Se usa 'n' en lugar de Escape porque necesitamos Escape libre en el terminal
keymap.set('t', '<C-n>', [[<C-\><C-n>]], { desc = "Salir del modo insert en terminal" })
keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "Terminal: ir a ventana izquierda" })
keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "Terminal: ir a ventana abajo" })
keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "Terminal: ir a ventana arriba" })
keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "Terminal: ir a ventana derecha" })

-- ============================================================================
-- GIT (Leader + g)
-- ============================================================================
-- Leader + g + g → Abrir/cerrar LazyGit (toggle)
keymap.set('n', '<leader>gg', function()
    require("core.lazygit-toggle").toggle()
end, { desc = "Git: LazyGit toggle" })

-- Leader + g + a → Git Add (agregar archivos al staging)
keymap.set('n', '<leader>ga', function()
    require("core.git-commands").add()
end, { desc = "Git: Add archivos" })

-- Leader + g + c → Git Commit (hacer commit)
keymap.set('n', '<leader>gc', function()
    require("core.git-commands").commit()
end, { desc = "Git: Commit" })

-- Leader + g + p → Git Pull (traer cambios)
keymap.set('n', '<leader>gp', function()
    require("core.git-commands").pull()
end, { desc = "Git: Pull" })

-- Leader + g + P → Git Push (enviar cambios)
keymap.set('n', '<leader>gP', function()
    require("core.git-commands").push()
end, { desc = "Git: Push" })

-- Leader + g + b → Git New Branch (crear rama nueva + checkout)
keymap.set('n', '<leader>gb', function()
    require("core.git-commands").new_branch()
end, { desc = "Git: Nueva rama" })

-- Leader + g + o → Git Checkout (cambiar de rama)
keymap.set('n', '<leader>go', function()
    require("core.git-commands").checkout()
end, { desc = "Git: Checkout rama" })

-- Leader + g + s → Git Status (ver estado)
keymap.set('n', '<leader>gs', function()
    require("core.git-commands").status()
end, { desc = "Git: Status" })

-- Leader + g + r → Git Restore (deshacer cambios de archivo)
keymap.set('n', '<leader>gr', function()
    require("core.git-commands").restore()
end, { desc = "Git: Restore (deshacer cambios)" })

-- ============================================================================
-- OPENCODE MENU (Leader + a)
-- ============================================================================
-- Leader + a + a → Abrir/cerrar panel de opencode
keymap.set('n', '<leader>aa', function()
    require("core.opencode-panel").toggle()
end, { desc = "Abrir/cerrar OpenCode" })

-- Leader + a + c → Consultar sobre lo seleccionado
keymap.set('v', '<leader>ac', function()
    require("core.opencode-panel").ask_about_selection()
end, { desc = "Consultar sobre selección" })

-- Leader + a + s → Consultar sobre el buffer activo
keymap.set('n', '<leader>as', function()
    require("core.opencode-panel").ask_about_buffer()
end, { desc = "Consultar sobre buffer activo" })

-- ============================================================================
-- 11. TELESCOPE (Búsqueda de Archivos y Texto)
-- ============================================================================
-- Configurado en lua/plugins/telescope.lua con keymaps específicos para servidor

-- ============================================================================
-- 12. LSP BÁSICO (Solo archivos de configuración)
-- ============================================================================
keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP: Mostrar documentación" })
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnóstico anterior" })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Siguiente diagnóstico" })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Mostrar diagnóstico flotante" })

-- ============================================================================
-- 13. SYSTEMD (Menú <leader>s)
-- ============================================================================
-- Leader + s + l → Ver logs de la aplicación (journalctl)
keymap.set('n', '<leader>sl', function()
    require("core.systemd-commands").logs_app()
end, { desc = "Systemd: Logs de aplicación" })

-- Leader + s + s → Ver estado del servicio
keymap.set('n', '<leader>ss', function()
    require("core.systemd-commands").status_app()
end, { desc = "Systemd: Status del servicio" })

-- Leader + s + r → Reiniciar servicio
keymap.set('n', '<leader>sr', function()
    require("core.systemd-commands").restart_app()
end, { desc = "Systemd: Restart servicio" })

-- Leader + s + S → Detener servicio
keymap.set('n', '<leader>sS', function()
    require("core.systemd-commands").stop_app()
end, { desc = "Systemd: Stop servicio" })

-- Leader + s + a → Iniciar servicio
keymap.set('n', '<leader>sa', function()
    require("core.systemd-commands").start_app()
end, { desc = "Systemd: Start servicio" })

-- Leader + s + d → Daemon reload (después de editar .service)
keymap.set('n', '<leader>sd', function()
    require("core.systemd-commands").daemon_reload()
end, { desc = "Systemd: Daemon reload" })

-- Leader + s + e → Habilitar servicio al inicio
keymap.set('n', '<leader>se', function()
    require("core.systemd-commands").enable_app()
end, { desc = "Systemd: Enable servicio" })

-- Leader + s + E → Deshabilitar servicio del inicio
keymap.set('n', '<leader>sE', function()
    require("core.systemd-commands").disable_app()
end, { desc = "Systemd: Disable servicio" })

-- Leader + s + L → Listar todos los servicios
keymap.set('n', '<leader>sL', function()
    require("core.systemd-commands").list_services()
end, { desc = "Systemd: Listar servicios" })

-- Leader + s + f → Listar servicios fallidos
keymap.set('n', '<leader>sf', function()
    require("core.systemd-commands").list_failed_services()
end, { desc = "Systemd: Servicios fallidos" })

-- Leader + s + t → Terminal systemctl
keymap.set('n', '<leader>st', function()
    require("core.systemd-commands").systemctl_terminal()
end, { desc = "Systemd: Terminal systemctl" })

-- Leader + s + j → Ver logs del sistema completo
keymap.set('n', '<leader>sj', function()
    require("core.systemd-commands").system_logs()
end, { desc = "Systemd: Logs del sistema" })

-- Leader + s + x → Ver errores del sistema
keymap.set('n', '<leader>sx', function()
    require("core.systemd-commands").system_errors()
end, { desc = "Systemd: Errores del sistema" })



-- ============================================================================
-- 14. ZOOM DUAL (Kitty + Neovim)
-- ============================================================================
local zoom = require('core.zoom')

-- Zoom de fuente (Terminal-Side via Kitty)
keymap.set('n', '<leader>z+', zoom.zoom_in, { desc = "Zoom: Aumentar fuente" })
keymap.set('n', '<leader>z-', zoom.zoom_out, { desc = "Zoom: Disminuir fuente" })
keymap.set('n', '<leader>z=', zoom.zoom_in, { desc = "Zoom: Aumentar fuente" })
keymap.set('n', '<leader>z0', zoom.reset_font_size, { desc = "Zoom: Resetear fuente" })

-- Zoom de ventana (Neovim-Side)
keymap.set('n', '<C-w>m', zoom.toggle_maximize, { desc = "Zoom: Maximizar/Restaurar ventana" })
keymap.set('n', '<C-w>M', zoom.restore, { desc = "Zoom: Restaurar ventana" })

-- Modo Focus (Combinado)
keymap.set('n', '<leader>zf', zoom.focus_mode, { desc = "Zoom: Activar modo focus" })
keymap.set('n', '<leader>zF', zoom.exit_focus_mode, { desc = "Zoom: Desactivar modo focus" })

-- ============================================================================
-- 15. AYUDA
-- ============================================================================
keymap.set('n', '<leader>?', function()
  require('core.help-panel').show()
end, { desc = "Mostrar panel de ayuda de keymaps" })

-- ============================================================================
-- RESUMEN DE PREFIJOS Y ATAJOS RÁPIDOS PARA SERVIDOR BARE METAL
-- ============================================================================
-- ATAJOS RÁPIDOS:
-- e                   → Toggle Oil sidebar (derecha, se cierra al abrir archivo)
-- <leader>o           → Toggle Oil sidebar
-- <leader>O           → Abrir Oil flotante
-- -                   → Abrir Oil en directorio padre
-- <leader><leader>    → 🔍 BUSCAR ARCHIVOS (doble espacio) ⭐
--
-- PREFIJOS:
-- <leader>g*  → Git (gg: lazygit, ga: add, gc: commit, gp: pull, gP: push, gb: nueva rama, go: checkout, gs: status, gr: restore)
-- <leader>a*  → OpenCode (aa: abrir/cerrar, ac: consultar selección, as: consultar buffer)
-- <leader>f*  → Telescope (fe: /etc/, fS: systemd, fl: logs, fL: /var/log/, fc: configs, ff: find, fg: grep, fb: buffers, fh: help)
-- <leader>s*  → Systemd (sl: logs app, ss: status, sr: restart, sS: stop, sa: start, sd: daemon-reload, se: enable, sE: disable, sL: list, sf: failed, st: terminal, sj: system logs, sx: errors)
-- <leader>l*  → Logs (lt: tail -f mode, lr: reload, le/lE: buscar errores, lw: buscar warnings)
-- <leader>z*  → Zoom y Focus mode
-- <leader>t   → Terminal horizontal toggle
-- <leader>T   → Terminal flotante toggle
-- <leader>1-9 → Saltar a buffer específico
-- <M-k/ñ>     → Navegar entre buffers (anterior/siguiente)
-- <M-o/l>     → Scroll up/down
-- <C-k/l/o/ñ> → Navegar entre ventanas
-- K           → LSP hover (documentación)
-- [d / ]d     → Diagnóstico anterior/siguiente
--
-- COMANDOS ESPECIALES:
-- :LogsApp    → journalctl -u app-provincial.service -f -n 100
--
-- OIL SIDEBAR (Explorador a la derecha):
-- <CR>        → Abrir archivo y CERRAR Oil
-- <C-s>       → Abrir en split vertical y CERRAR Oil
-- <C-h>       → Abrir en split horizontal y CERRAR Oil
-- gp          → Cambiar permisos (chmod)
-- g.          → Toggle archivos ocultos
