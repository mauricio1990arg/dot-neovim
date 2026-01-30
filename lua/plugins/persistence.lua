-- ============================================================================
-- PERSISTENCE.NVIM - Gestión Automática de Sesiones
-- Guarda automáticamente al salir y carga automáticamente al iniciar
-- ============================================================================

return {
  "folke/persistence.nvim",
  event = "VimEnter", -- Carga al iniciar Neovim para restaurar sesión automáticamente
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/", -- ~/.local/state/nvim/sessions/
    need = 1,     -- Mínimo 1 buffer de archivo abierto para guardar
    branch = true, -- Usa la rama de git para guardar sesiones separadas
  },
  config = function(_, opts)
    require("persistence").setup(opts)
    
    -- Cargar sesión automáticamente al iniciar Neovim
    -- Solo si:
    -- 1. No se pasaron argumentos (archivos) al abrir nvim
    -- 2. Existe una sesión para el directorio actual
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("persistence_autoload", { clear = true }),
      callback = function()
        -- Verificar si NO se pasaron argumentos
        if vim.fn.argc() == 0 then
          -- Intentar cargar la sesión del directorio actual
          require("persistence").load()
        end
      end,
      nested = true, -- Permitir que otros autocmds se ejecuten después
    })
  end,
  keys = {
    -- <leader>ps → Restaurar sesión del directorio actual
    {
      "<leader>ps",
      function()
        require("persistence").load()
      end,
      desc = "Persistence: Restaurar sesión (directorio actual)",
    },
    
    -- <leader>pS → Seleccionar sesión para cargar
    {
      "<leader>pS",
      function()
        require("persistence").select()
      end,
      desc = "Persistence: Seleccionar sesión",
    },
    
    -- <leader>pl → Restaurar última sesión
    {
      "<leader>pl",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Persistence: Restaurar última sesión",
    },
    
    -- <leader>pd → Detener persistencia (no guardar al salir)
    {
      "<leader>pd",
      function()
        require("persistence").stop()
      end,
      desc = "Persistence: Detener (no guardar sesión al salir)",
    },
  },
}
