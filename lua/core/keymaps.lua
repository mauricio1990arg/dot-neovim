vim.g.mapleader = " "

local keymap = vim.keymap

-- ============================================================================
-- 1. NAVEGACIÓN BÁSICA (Modo Normal y Visual)
-- ============================================================================
-- Mapeos personalizados: arriba (o), abajo (l), izq (k), der (ñ)

-- Modo Normal
keymap.set("n", "o", "k", { desc = "Mover arriba" })
keymap.set("n", "l", "j", { desc = "Mover abajo" })
keymap.set("n", "k", "h", { desc = "Mover izquierda" })
keymap.set("n", "ñ", "l", { desc = "Mover derecha" })

-- Modo Visual (misma navegación)
keymap.set("v", "o", "k", { desc = "Mover arriba (visual)" })
keymap.set("v", "l", "j", { desc = "Mover abajo (visual)" })
keymap.set("v", "k", "h", { desc = "Mover izquierda (visual)" })
keymap.set("v", "ñ", "l", { desc = "Mover derecha (visual)" })

-- ============================================================================
-- 2. INSERCIÓN DE TEXTO
-- ============================================================================
-- i → insertar en posición actual (modo insert normal)
keymap.set("n", "i", "i", { desc = "Insertar en posición actual" })

-- p → insertar a la derecha del cursor (append)
keymap.set("n", "p", "a", { desc = "Insertar a la derecha del cursor" })
keymap.set("n", "P", "A", { desc = "Insertar al final de la línea" })

-- Shift+O → insertar línea arriba
keymap.set("n", "O", "O", { desc = "Insertar línea arriba" })

-- Shift+L → insertar línea abajo
keymap.set("n", "L", "o", { desc = "Insertar línea abajo" })

-- ============================================================================
-- 3. ARCHIVOS Y EDICIÓN
-- ============================================================================
keymap.set("n", "e", "<cmd>Neotree toggle<cr>", { desc = "Abrir explorador" })
keymap.set("n", "w", ":w<CR>", { desc = "Escribir (Guardar) archivo" })
keymap.set("n", "q", ":bdelete<CR>", { desc = "Cerrar archivo abierto (buffer)" })
keymap.set("n", "z", "u", { desc = "Deshacer cambios" })

-- ============================================================================
-- 4. MOVIMIENTO ENTRE VENTANAS (Explorador vs Editor)
-- ============================================================================
keymap.set("n", "<C-k>", "<C-w>h", { desc = "Ir a ventana izquierda" })
keymap.set("n", "<C-ñ>", "<C-w>l", { desc = "Ir a ventana derecha" })

-- ============================================================================
-- 5. MOVIMIENTO ENTRE ARCHIVOS ABIERTOS (Pestañas/Buffers)
-- ============================================================================
-- Cambiados a Alt para evitar conflictos
keymap.set("n", "<M-l>", "<cmd>bprevious<cr>", { noremap = true, silent = true, nowait = true, desc = "Archivo anterior" })
keymap.set("n", "<M-o>", "<cmd>bnext<cr>", { noremap = true, silent = true, nowait = true, desc = "Siguiente archivo" })

-- ============================================================================
-- 6. TERMINAL
-- ============================================================================
-- keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal flotante" })

-- ============================================================================
-- 7. NAVEGACIÓN DE EXTREMOS DE LÍNEA (Normal y Visual)
-- ============================================================================
-- Modo Normal
keymap.set("n", "j", "^", { desc = "Ir al inicio de la línea" })
keymap.set("n", "{", "$", { desc = "Ir al final de la línea" })

-- Modo Visual (mismo comportamiento)
keymap.set("v", "j", "^", { desc = "Ir al inicio de la línea (visual)" })
keymap.set("v", "{", "$", { desc = "Ir al final de la línea (visual)" })

-- ============================================================================
-- 5. MOVIMIENTO ENTRE ARCHIVOS ABIERTOS (Buffers)
-- ============================================================================
-- Alt+l → Buffer anterior (izquierda visualmente)
keymap.set("n", "<M-l>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer anterior" })

-- Alt+o → Buffer siguiente (derecha visualmente) 
keymap.set("n", "<M-o>", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer siguiente" })

-- OPCIONAL: Saltos directos con números
keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Ir a buffer 1" })
keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Ir a buffer 2" })
keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Ir a buffer 3" })
keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Ir a buffer 4" })
keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Ir a buffer 5" })
keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "Ir a buffer 6" })
keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "Ir a buffer 7" })
keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "Ir a buffer 8" })
keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "Ir a buffer 9" })

-- Cerrar buffer sin cerrar la ventana
keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Cerrar buffer actual" })

-- ============================================================================
-- 8. SELECCIÓN DE EXTREMOS (Modo Normal a Visual)
-- ============================================================================
keymap.set("n", "K", "v^", { desc = "Seleccionar hasta el inicio" })
keymap.set("n", "Ñ", "v$", { desc = "Seleccionar hasta el final" })

-- ============================================================================
-- 9. UTILIDADES
-- ============================================================================
-- Centrar pantalla al saltar (usando Ctrl+l y Ctrl+o que NO entran en conflicto)
keymap.set("n", "<C-l>", "<C-d>zz", { desc = "Scroll down y centrar" })
keymap.set("n", "<C-o>", "<C-u>zz", { desc = "Scroll up y centrar" })

-- Salir de Neovim con Shift + Q
keymap.set("n", "Q", ":qa!<CR>", { desc = "Cerrar todo y salir de Neovim" })

-- ============================================================================
-- 10. NAVEGACIÓN DE CÓDIGO LSP
-- ============================================================================
keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Ir a definición' })
keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Ir a declaración' })
keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Ir a implementación' })
keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Ver referencias' })
keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Ir a tipo' })

-- Hover y ayuda
keymap.set('n', '<leader>k', vim.lsp.buf.hover, { desc = 'Mostrar documentación' })

-- ============================================================================
-- 11. REFACTORING Y DIAGNÓSTICOS
-- ============================================================================
keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Renombrar símbolo' })
keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Acciones de código' })

keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnóstico anterior' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Siguiente diagnóstico' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Mostrar diagnóstico' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Lista de diagnósticos' })

-- Formateo
keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Formatear código' })

-- ============================================================================
-- 12. SPRING BOOT
-- ============================================================================
keymap.set('n', '<M-s>', ':SpringBootRun<CR>', { desc = 'Spring Boot Run' })
keymap.set('n', '<M-S>', ':SpringBootStop<CR>', { desc = 'Spring Boot Stop' })


-- ============================================================================
-- DIAGNÓSTICOS Y ERRORES LSP (Simple)
-- ============================================================================

-- Ctrl + . → Ver error en línea actual
keymap.set('n', '<C-.>', vim.diagnostic.open_float, { desc = 'Ver error' })

-- Ctrl + Shift + . → Siguiente error
keymap.set('n', '<C->>', vim.diagnostic.goto_next, { desc = 'Siguiente error' })