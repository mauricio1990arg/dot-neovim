return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                variant = "moon",
                styles = {
                    italic = true,
                    transparency = true,
                },
                highlight_groups = {
                    NotifyBackground = { bg = "#000000" },
                    ["@annotation"] = { fg = "iris" },
                    ["@annotation.java"] = { fg = "gold" },

                    -- ============================================================================
                    -- NVIM-DBEE: Colores personalizados para MongoDB y bases de datos
                    -- ============================================================================

                    -- Operadores MongoDB ($find, $match, $set, etc.)
                    ["@field.mongodb"] = { fg = "#f6c177", bold = true }, -- Amarillo/dorado vibrante
                    ["@operator.mongodb"] = { fg = "#ea9a97", bold = true }, -- Coral brillante

                    -- ObjectIDs de MongoDB
                    ["@string.special.mongodb"] = { fg = "#9ccfd8", italic = true }, -- Cian suave

                    -- Claves de documentos JSON
                    ["@property.json"] = { fg = "#c4a7e7" }, -- Iris/púrpura

                    -- Valores en JSON
                    ["@string.json"] = { fg = "#f6c177" }, -- Amarillo
                    ["@number.json"] = { fg = "#ea9a97" }, -- Coral
                    ["@boolean.json"] = { fg = "#eb6f92" }, -- Love (rosa)

                    -- Bordes de ventanas flotantes (menús, selección de DB)
                    FloatBorder = { fg = "#44415a", bg = "none" }, -- Borde visible sobre fondo
                    FloatTitle = { fg = "#c4a7e7", bold = true }, -- Título púrpura

                    -- Drawer de nvim-dbee
                    DbeeDrawerConnection = { fg = "#31748f", bold = true },            -- Azul para conexiones
                    DbeeDrawerActiveConnection = { fg = "#9ccfd8", bold = true, italic = true }, -- Cian brillante para activa
                    DbeeDrawerFolder = { fg = "#6e6a86" },                             -- Gris para carpetas
                    DbeeDrawerNote = { fg = "#908caa" },                               -- Gris más claro para notas

                    -- Resultados en dbee-result
                    DbeeResultHeader = { fg = "#c4a7e7", bold = true }, -- Encabezados púrpura
                    DbeeResultRow = { fg = "#e0def4" },          -- Texto normal
                    DbeeResultRowAlt = { fg = "#e0def4", bg = "#232136" }, -- Fila alternada
                },
            })
            vim.cmd("colorscheme rose-pine")
        end,
    },
}
