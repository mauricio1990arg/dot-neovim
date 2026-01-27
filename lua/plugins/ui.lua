return {
  -- Notificaciones bonitas en la esquina
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
  -- Líneas de indentación (clave para React y archivos JSON de Mongo)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  }
}
