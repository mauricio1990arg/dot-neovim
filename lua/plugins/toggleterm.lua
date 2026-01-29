return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = nil, -- Deshabilitado, usamos <leader>t en keymaps.lua
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            persist_mode = true,
            direction = 'horizontal', -- Terminal abajo por defecto
            close_on_exit = true,
            shell = vim.o.shell,
            auto_scroll = true,
            -- Terminal se abre en la parte inferior, no desplaza opencode
            on_open = function(term)
                -- Asegurar que el terminal se abra debajo sin afectar opencode
                vim.cmd("wincmd J")
            end,
            float_opts = {
                border = 'curved',
                winblend = 0,
            },
        })

        -- Atajos de teclado centralizados en lua/core/keymaps.lua
    end,
}
