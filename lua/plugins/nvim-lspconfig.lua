-- Configuración LSP minimalista para administración de servidor Bare Metal
-- Solo incluye LSPs esenciales: YAML, JSON, Bash (sin Docker)
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
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

        -- Configuración LSP solo para archivos de configuración del servidor
        
        -- JSON (para archivos de configuración)
        vim.lsp.config('jsonls', {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true },
                }
            }
        })

        -- YAML (configuraciones de servidor, k8s, etc.)
        vim.lsp.config('yamlls', {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                yaml = {
                    schemas = {
                        ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
                    },
                    validate = true,
                    hover = true,
                    completion = true,
                }
            }
        })

        -- Bash/Shell scripts
        vim.lsp.config('bashls', {
            on_attach = on_attach,
            capabilities = capabilities,
        })

        -- Lua (solo para configurar Neovim)
        vim.lsp.config('lua_ls', {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })

        -- Activar solo los LSPs esenciales para servidor Bare Metal
        vim.lsp.enable('jsonls')
        vim.lsp.enable('yamlls')
        vim.lsp.enable('bashls')
        vim.lsp.enable('lua_ls')
    end,
}
