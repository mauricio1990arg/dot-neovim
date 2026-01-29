require("core.nodejs").setup({ silent = true })
require("core.options")   -- Configuraciones de UI (números de línea, etc.)
require("core.keymaps")   -- Tus atajos personalizados
require("core.lazy")      -- Instalación de lazy.nvim y plugins
vim.g.skip_ts_context_commentstring_module = true
vim.opt.termguicolors = true

-- Mejorar highlight de anotaciones Java
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.cmd([[
      highlight! link @annotation Keyword
      highlight! link @annotation.java Special
    ]])
  end,
})

-- Comandos Spring Boot
vim.api.nvim_create_user_command('SpringBootRun', function()
  local env_file = vim.fn.getcwd() .. '/.env'
  
  if vim.fn.filereadable(env_file) == 1 then
    vim.cmd('terminal export $(cat .env | xargs) && mvn spring-boot:run')
  else
    vim.cmd('terminal mvn spring-boot:run')
  end
end, {})

vim.api.nvim_create_user_command('SpringBootStop', function()
  vim.cmd('!pkill -f spring-boot')
end, {})

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

-- LSP log level
vim.lsp.set_log_level("WARN")

-- Reducir notificaciones molestas del LSP
local notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" and msg:match("readDependency") then
    return
  end
  notify(msg, level, opts)
end

-- Caracteres invisibles
vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
  nbsp = '␣',
  extends = '›',
  precedes = '‹',
}