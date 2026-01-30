-- Configuración para visualización de archivos de log
return {
  {
    -- Plugin para resaltado de logs
    'mtdl9/vim-log-highlighting',
    ft = { 'log' },
    config = function()
      -- Configuración adicional si es necesaria
    end
  },
  
  {
    -- Configuración personalizada para archivos grandes (logs)
    'LunarVim/bigfile.nvim',
    event = 'BufReadPre',
    config = function()
      require('bigfile').setup({
        filesize = 2, -- Tamaño en MB
        pattern = { "*" },
        features = {
          "indent_blankline",
          "illumintate",
          "lsp",
          "treesitter",
          "syntax",
          "matchparen",
          "vimopts",
          "filetype",
        },
      })
    end
  },
}
