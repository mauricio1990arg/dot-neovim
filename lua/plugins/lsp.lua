return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        -- Aquí aseguras que se instalen los servidores para tu stack
        ensure_installed = { "rust_analyzer", "jdtls", "ts_ls", "html", "cssls" },
      })
    end,
  },
}
