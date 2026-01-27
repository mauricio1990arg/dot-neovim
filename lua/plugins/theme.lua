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
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },
}
