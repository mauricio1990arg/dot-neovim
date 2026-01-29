# Migración a Neovim 0.11 - Nueva API LSP

## ⚠️ Cambios Importantes (Enero 2026)

Neovim 0.11 (lanzado en diciembre 2025) **deprecó** la API antigua de `require('lspconfig').setup()`.

### ❌ API Antigua (Deprecada)
```lua
require('lspconfig').lua_ls.setup({
  on_attach = my_function,
  capabilities = my_capabilities,
})
```

### ✅ API Nueva (Neovim 0.11+)
```lua
-- Configuración en ~/.config/nvim/lsp/lua_ls.lua
vim.lsp.enable({ 'lua_ls' })

-- Keymaps con LspAttach autocmd
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    -- tus keymaps aquí
  end,
})
```

## 📁 Nueva Estructura

```
~/.config/nvim/
├── lsp/                       # Configuraciones LSP (nueva ubicación)
│   ├── lua_ls.lua
│   ├── jsonls.lua
│   ├── yamlls.lua
│   └── lemminx.lua
├── lua/
│   ├── core/
│   │   └── java-helpers.lua
│   └── plugins/
│       ├── mason.lua          # Solo instalación de herramientas
│       ├── lsp-config.lua     # Habilita LSP con vim.lsp.enable()
│       ├── java-lsp.lua       # jdtls con LspAttach
│       ├── dap.lua
│       └── luasnip.lua
└── init.lua
```

## 🔧 Cambios Realizados

### 1. Eliminado `nvim-lspconfig` setup
- ❌ Removido: `require('lspconfig').lua_ls.setup()`
- ✅ Nuevo: Archivos en `~/.config/nvim/lsp/` + `vim.lsp.enable()`

### 2. Keymaps con `LspAttach`
- ❌ Removido: `on_attach` callback
- ✅ Nuevo: `vim.api.nvim_create_autocmd('LspAttach', ...)`

### 3. Autocompletado nativo
- Neovim 0.11 incluye autocompletado nativo
- Se habilita automáticamente con `vim.lsp.completion.enable()`

## 🚀 Cómo Usar

### Verificar LSP
```vim
:checkhealth vim.lsp
:LspInfo
```

### Habilitar un nuevo LSP
1. Crea el archivo: `~/.config/nvim/lsp/nombre_lsp.lua`
2. Agrega la configuración:
```lua
return {
  cmd = { "comando-del-lsp" },
  root_markers = { ".git" },
  filetypes = { "tipo" },
}
```
3. Habilítalo en `lsp-config.lua`:
```lua
vim.lsp.enable({ "nombre_lsp" })
```

## 📚 Referencias

- [Neovim 0.11 Release Notes](https://neovim.io/doc/user/news-0.11.html)
- [Gregory Anders Blog Post](https://gpanders.com/blog/whats-new-in-neovim-0-11/)
- [Reddit: Migration Guide](https://www.reddit.com/r/neovim/comments/1nmh99k/beware_the_old_nvimlspconfig_setup_api_is/)

## ✨ Beneficios

- ✅ Sin dependencia de `nvim-lspconfig` para configuración básica
- ✅ Configuración más simple y clara
- ✅ Autocompletado nativo incluido
- ✅ Mejor rendimiento
- ✅ Menos plugins necesarios

---

**Fecha de migración**: 29 de enero de 2026
