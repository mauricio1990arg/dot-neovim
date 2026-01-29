-- ============================================================================
-- NVIM-DBEE - Cliente de Base de Datos Interactivo
-- Configurado para layout personalizado: o (↑), l (↓), k (←), ñ (→)
-- ============================================================================

return {
    "kndndrj/nvim-dbee",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    build = function()
        require("dbee").install()
    end,
    config = function()
        require("dbee").setup({
            -- Configuración del drawer (barra lateral)
            drawer = {
                mappings = {
                    { key = "ñ",     mode = "n", action = "toggle" },   -- Abrir/cerrar nodos
                    { key = "s",     mode = "n", action = "action_1" }, -- Esto debería abrir el scratchpad directamente
                    { key = "<CR>",  mode = "n", action = "toggle" },   -- Enter también abre nodos
                    { key = "r",     mode = "n", action = "refresh" },
                    { key = "cw",    mode = "n", action = "edit" },     -- Más claro que action_2
                    { key = "dd",    mode = "n", action = "delete" },   -- Más claro que action_3
                    { key = "<Esc>", mode = "n", action = "menu_close" },
                    { key = "q",     mode = "n", action = "menu_close" },
                    { key = "y",     mode = "n", action = "menu_yank" },
                },
            },

            -- Configuración del editor
            editor = {
                mappings = {
                    { key = "<leader>rr", mode = "n", action = "run_file" },
                    { key = "<leader>rs", mode = "v", action = "run_selection" },
                },
            },

            -- Configuración de resultados
            result = {
                page_size = 100,
            },
        })

        -- Atajos globales
        vim.keymap.set("n", "<leader>db", function()
            require("dbee").toggle()
        end, { desc = "DB: Toggle nvim-dbee" })
    end,
}
