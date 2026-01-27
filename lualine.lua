return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight", -- Se sincroniza automáticamente
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },
}
