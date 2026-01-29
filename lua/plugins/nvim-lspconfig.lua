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
      local opts = { buffer = bufnr, silent = true }
      
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
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
