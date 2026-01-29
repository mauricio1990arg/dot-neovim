require("core.nodejs").setup({ silent = true })
require("core.options")
require("core.keymaps")
require("core.lazy")
require("core.java-helpers")
require("core.java-check")
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
