return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({})
      
      -- Atajos de Telescope
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Buscar archivos' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Buscar en archivos' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buscar buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Buscar ayuda' })
      
      -- LSP con Telescope (MUY ÚTIL para Spring)
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Símbolos del documento' })
      vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, { desc = 'Símbolos del workspace' })
      vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Referencias' })
      vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Implementaciones' })
    end,
  },
}
