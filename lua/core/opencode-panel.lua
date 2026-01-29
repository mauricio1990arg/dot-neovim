-- ============================================================================
-- Panel persistente de OpenCode
-- Maneja la apertura/cierre del panel lateral manteniendo su tamaño
-- La sesión de opencode se mantiene activa entre abrir/cerrar
-- ============================================================================

local M = {}
local opencode_win = nil
local opencode_buf = nil
local opencode_job_id = nil
local panel_width = 60

-- Crear o mostrar el panel de opencode
function M.toggle()
    -- Si la ventana ya existe y está visible, solo ocultarla (sin cerrar el proceso)
    if opencode_win and vim.api.nvim_win_is_valid(opencode_win) then
        -- Solo cerrar la ventana, mantener el buffer y el proceso vivos
        vim.api.nvim_win_close(opencode_win, false)
        opencode_win = nil
        return
    end

    -- Guardar ventana original
    local original_win = vim.api.nvim_get_current_win()

    -- Si el buffer ya existe (sesión previa), reutilizarlo
    if opencode_buf and vim.api.nvim_buf_is_valid(opencode_buf) then
        -- Recrear ventana con el buffer existente
        vim.cmd('topleft vertical ' .. panel_width .. 'split')
        opencode_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(opencode_win, opencode_buf)

        -- Configurar propiedades de la ventana
        vim.api.nvim_win_set_option(opencode_win, 'winfixwidth', true)
        vim.api.nvim_win_set_option(opencode_win, 'number', false)
        vim.api.nvim_win_set_option(opencode_win, 'relativenumber', false)
        vim.api.nvim_win_set_option(opencode_win, 'signcolumn', 'no')
        vim.api.nvim_win_set_option(opencode_win, 'foldcolumn', '0')
        vim.api.nvim_win_set_option(opencode_win, 'wrap', true)

        -- Volver a la ventana original
        if original_win and vim.api.nvim_win_is_valid(original_win) then
            vim.api.nvim_set_current_win(original_win)
        end
        return
    end

    -- Primera vez: crear buffer y proceso nuevo
    local cwd = vim.fn.getcwd()

    -- Crear buffer scratch persistente (no aparece en bufferline)
    opencode_buf = vim.api.nvim_create_buf(false, true)

    -- Configurar opciones del buffer para que no aparezca en la lista pero persista
    vim.api.nvim_buf_set_option(opencode_buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(opencode_buf, 'bufhidden', 'hide') -- 'hide' en lugar de 'wipe'
    vim.api.nvim_buf_set_option(opencode_buf, 'swapfile', false)
    vim.api.nvim_buf_set_option(opencode_buf, 'buflisted', false)
    vim.api.nvim_buf_set_option(opencode_buf, 'filetype', 'opencode')

    -- Crear split vertical a la izquierda absoluta
    vim.cmd('topleft vertical ' .. panel_width .. 'split')
    opencode_win = vim.api.nvim_get_current_win()

    -- Asignar el buffer a la ventana
    vim.api.nvim_win_set_buf(opencode_win, opencode_buf)

    -- Configurar propiedades de la ventana para que sea fija
    vim.api.nvim_win_set_option(opencode_win, 'winfixwidth', true)
    vim.api.nvim_win_set_option(opencode_win, 'number', false)
    vim.api.nvim_win_set_option(opencode_win, 'relativenumber', false)
    vim.api.nvim_win_set_option(opencode_win, 'signcolumn', 'no')
    vim.api.nvim_win_set_option(opencode_win, 'foldcolumn', '0')
    vim.api.nvim_win_set_option(opencode_win, 'wrap', true)

    -- Ejecutar opencode en la terminal (solo la primera vez)
    opencode_job_id = vim.fn.termopen('opencode "' .. cwd .. '"', {
        cwd = cwd,
        on_exit = function()
            -- Limpiar completamente solo cuando el proceso termina
            if opencode_win and vim.api.nvim_win_is_valid(opencode_win) then
                pcall(vim.api.nvim_win_close, opencode_win, true)
            end
            if opencode_buf and vim.api.nvim_buf_is_valid(opencode_buf) then
                pcall(vim.api.nvim_buf_delete, opencode_buf, { force = true })
            end
            opencode_win = nil
            opencode_buf = nil
            opencode_job_id = nil
        end
    })

    -- Volver a la ventana original
    if original_win and vim.api.nvim_win_is_valid(original_win) then
        vim.api.nvim_set_current_win(original_win)
    end
end

return M
