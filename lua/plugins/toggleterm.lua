return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]], -- Ctrl + \ para abrir/cerrar
        direction = "float",      -- Terminal flotante
        float_opts = { border = "curved" },
      })
    end,
  },
}
