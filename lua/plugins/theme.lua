return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon", -- La variante oscura más elegante
        styles = {
          italic = true,
          transparency = true, -- Para que luzca tu Hyprland
        },
        highlight_groups = {
          NotifyBackground = { bg = "#000000" },  -- Agrega esto
          ["@annotation"] = { fg = "iris" },  -- Morado/azul
          ["@annotation.java"] = { fg = "gold" },  -- Amarillo/dorado
        },
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },
}
