-- Configuración de Neovim para administración de servidor Debian 13 (Bare Metal)
require("core.options")
require("core.keymaps")
require("core.lazy")
require("core.log-config").setup() -- Configuración para visualización de logs
require("core.filetype-config").setup() -- Configuración de tipos de archivo (.env, .service, etc.)
vim.g.skip_ts_context_commentstring_module = true
vim.opt.termguicolors = true

-- Comando personalizado para ver logs de la aplicación
vim.api.nvim_create_user_command("LogsApp", function()
  require("core.systemd-commands").logs_app()
end, { desc = "Ver logs de app-provincial.service con journalctl" })

-- Activar highlighting de treesitter automáticamente para todos los archivos
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    pcall(vim.treesitter.start)  -- pcall para evitar errores si no hay parser
  end,
})

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
