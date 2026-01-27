return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "classic", -- Usa el diseño clásico para evitar grupos raros
      delay = 0,         -- Que aparezca al instante sin retardo
      spec = {
        { "<leader>f", group = "Archivos" },
        { "<leader>s", group = "Sistema" },
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
    },
  },
}
