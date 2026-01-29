require("core.nodejs").setup({ silent = true })
require("core.options")   -- Configuraciones de UI (números de línea, etc.)
require("core.keymaps")   -- Tus atajos personalizados
require("core.lazy")      -- Instalación de lazy.nvim y plugins
vim.g.skip_ts_context_commentstring_module = true
vim.opt.termguicolors = true

-- Configuración de diagnósticos
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})
