return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({})
      
      local builtin = require('telescope.builtin')
      
      -- Atajos básicos de archivos
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Buscar Archivos' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Buscar Texto (Grep)' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Ver Buffers abiertos' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Buscar ayuda' })
      
      -- Atajos LSP con Telescope (útil para Spring/Java)
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Símbolos del documento' })
      vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, { desc = 'Símbolos del workspace' })
      vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Referencias' })
      vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Implementaciones' })
    end
  }
}
