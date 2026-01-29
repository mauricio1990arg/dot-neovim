return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.g.deprecation_warnings = false
    local lspconfig = require("lspconfig")
    local capabilities = _G.lsp_capabilities or require("cmp_nvim_lsp").default_capabilities()
    
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      }
    }
    
    local on_attach = function(client, bufnr)
      -- Atajos de teclado LSP centralizados en lua/core/keymaps.lua
    end
    
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          suggest = {
            includeCompletionsForModuleExports = true,
            includeAutomaticOptionalChainCompletions = true,
          },
          preferences = {
            importModuleSpecifier = 'relative',
            includePackageJsonAutoImports = 'on',
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          suggest = {
            includeCompletionsForModuleExports = true,
            includeAutomaticOptionalChainCompletions = true,
          },
        },
      },
    })
    
    lspconfig.eslint.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        format = true,
        validate = 'on',
        run = 'onType',
      },
    })
    
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    
    lspconfig.jsonls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    
    lspconfig.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    
    lspconfig.lemminx.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
