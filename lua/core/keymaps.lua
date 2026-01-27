vim.g.mapleader = " "

local keymap = vim.keymap

-- 1. NAVEGACIÓN BÁSICA (Modo Normal)
-- Mapeos personalizados: arriba (o), abajo (l), izq (k), der (ñ)
keymap.set("n", "o", "k", { desc = "Mover arriba" })
keymap.set("n", "l", "j", { desc = "Mover abajo" })
keymap.set("n", "k", "h", { desc = "Mover izquierda" })
keymap.set("n", "ñ", "l", { desc = "Mover derecha" })

-- 2. ARCHIVOS Y EDICIÓN
keymap.set("n", "e", "<cmd>Neotree toggle<cr>", { desc = "Abrir explorador" })
keymap.set("n", "w", ":w<CR>", { desc = "Escribir (Guardar) archivo" })
keymap.set("n", "q", ":bdelete<CR>", { desc = "Cerrar archivo abierto (buffer)" })
keymap.set("n", "z", "u", { desc = "Deshacer cambios" })

-- 3. MOVIMIENTO ENTRE VENTANAS (Explorador vs Editor)
-- Ctrl + k (izq) y Ctrl + ñ (der)
keymap.set("n", "<C-k>", "<C-w>h", { desc = "Ir a ventana izquierda" })
keymap.set("n", "<C-ñ>", "<C-w>l", { desc = "Ir a ventana derecha" })

-- 4. MOVIMIENTO ENTRE ARCHIVOS ABIERTOS (Pestañas/Buffers)
-- Ctrl + o (prev) y Ctrl + l (next)
-- Forzar navegación de buffers con alta prioridad
keymap.set("n", "<C-o>", "<cmd>bprevious<cr>", { noremap = true, silent = true, nowait = true, desc = "Archivo anterior" })
keymap.set("n", "<C-l>", "<cmd>bnext<cr>", { noremap = true, silent = true, nowait = true, desc = "Siguiente archivo" })

-- 5. TERMINAL
-- Ctrl + t para abrir la terminal flotante (usando ToggleTerm que instalamos antes)
keymap.set("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal flotante" })

-- 6. EXTRA: UTILIDADES
-- Centrar pantalla al saltar
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Salir de Neovim con Shift + Q
keymap.set("n", "Q", ":qa!<CR>", { desc = "Cerrar todo y salir de Neovim" })

-- Navegación de extremos de línea (Modo Normal)
-- j para ir al inicio de la línea (primer carácter no blanco)
keymap.set("n", "j", "^", { desc = "Ir al inicio de la línea" })
-- { para ir al final de la línea
keymap.set("n", "{", "$", { desc = "Ir al final de la línea" })

-- Selección de extremos (Modo Normal a Visual)
-- K para seleccionar desde la posición actual hasta el inicio
keymap.set("n", "K", "v^", { desc = "Seleccionar hasta el inicio" })
-- Ñ para seleccionar desde la posición actual hasta el final
keymap.set("n", "Ñ", "v$", { desc = "Seleccionar hasta el final" })
