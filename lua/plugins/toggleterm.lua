return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,  -- Altura del terminal
      open_mapping = [[<c-\>]],  -- Ctrl+\ para abrir/cerrar
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = 'horizontal',  -- 'horizontal', 'vertical', 'float', 'tab'
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = 'curved',
        winblend = 0,
      },
    })

    -- Atajos de teclado centralizados en lua/core/keymaps.lua
  end,
}
