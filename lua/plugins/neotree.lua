return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            ["o"] = "none", -- Desactiva el mapeo interno que causa error
            ["l"] = "none", -- Desactiva el mapeo interno que causa error
            ["k"] = "close_node", -- Usamos tu tecla izquierda para cerrar carpetas
            ["ñ"] = "open",       -- Usamos tu tecla derecha para abrir archivos/carpetas
            ["<space>"] = "none",
          },
        },
      })
    end,
  }
}
