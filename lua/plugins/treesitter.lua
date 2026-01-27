return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua", "java", "rust", "tsx", "typescript", "javascript", "html", "css"
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- En las versiones nuevas, nvim-treesitter ya sabe qué hacer con las opts
      -- si se pasan a través de lazy. Si quieres forzarlo:
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
