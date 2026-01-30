# AGENT INSTRUCTIONS

## Información del entorno

**Versión de Neovim:** `0.11.5` (actualizado en diciembre 2025)  
**Fecha actual:** Enero 2026  
**Sistema operativo:** Linux

---

## IMPORTANTE: Protocolo de trabajo

### 0. Regla de documentación

**NO CREAR DOCUMENTACIÓN A MENOS QUE EL USUARIO LO SOLICITE EXPLÍCITAMENTE**

- Solo realiza la tarea que se te pide
- No agregues archivos README.md, CHANGELOG.md, o cualquier otra documentación
- No agregues comentarios extensos en el código a menos que se solicite
- Mantén los cambios mínimos y enfocados en la tarea solicitada

### 1. Consultar documentación oficial ANTES de hacer cambios

Dado que estamos usando **Neovim 0.11.5** (una versión muy reciente de diciembre 2025), es **CRÍTICO** que:

- **SIEMPRE** consultes la documentación oficial en internet antes de hacer cualquier cambio
- Verifica que los plugins sean compatibles con Neovim 0.11+
- Revisa si hay breaking changes recientes en los plugins
- Usa las APIs más recientes de Neovim

### 2. Utilizar los MCP disponibles

Tienes acceso a varios MCPs (Model Context Protocol) que debes usar:

- **WebFetch**: Para consultar documentación oficial de GitHub, sitios web, etc.
- **Context7**: Para consultar documentación actualizada de librerías y frameworks
- **Task**: Para exploraciones complejas del código

**Ejemplo de flujo correcto:**
```
1. Usuario pide instalar/configurar plugin X
2. Agent usa WebFetch para consultar el README oficial del plugin
3. Agent verifica compatibilidad con Neovim 0.11.5
4. Agent implementa según la documentación oficial
5. Agent notifica al usuario de cambios importantes
```

### 3. Cambios recientes importantes de Neovim 0.11+

- **nvim-treesitter**: Reescritura completa, ya no existe `nvim-treesitter.configs`
  - Usar: `require('nvim-treesitter').install({ 'lang1', 'lang2' })`
  - NO usar: `require('nvim-treesitter.configs').setup({})`
  
- **Treesitter highlighting**: Ahora se activa con `vim.treesitter.start()`
  - Ya no se usa el módulo de configuración antiguo

- **APIs deprecadas**: Muchas funciones `vim.api.nvim_xxx_set_option()` están deprecadas
  - Preferir: `vim.opt`, `vim.bo`, `vim.wo`

---

## Estructura del proyecto

```
~/.config/nvim/
├── init.lua                 # Punto de entrada principal
├── lua/
│   ├── core/               # Configuraciones core
│   │   ├── lazy.lua        # Gestor de plugins (Lazy.nvim)
│   │   ├── keymaps.lua     # Atajos de teclado
│   │   ├── options.lua     # Opciones de Neovim
│   │   ├── opencode-panel.lua  # Panel de OpenCode
│   │   ├── nodejs.lua      # Configuración de Node.js
│   │   ├── java-helpers.lua    # Helpers de Java
│   │   ├── java-check.lua      # Validación de Java
│   │   └── runners.lua         # Runners de código
│   ├── plugins/            # Configuración de plugins
│   │   ├── treesitter.lua  # Treesitter (NUEVA API)
│   │   ├── telescope.lua   # Fuzzy finder
│   │   ├── lsp.lua         # LSP config
│   │   └── ...
│   └── config/             # Configuraciones adicionales
└── ftplugin/               # Configuraciones por filetype
```

---

## Plugins instalados

### Gestor de plugins
- **lazy.nvim**: Gestor de plugins moderno

### Navegación y búsqueda
- **telescope.nvim**: Fuzzy finder
- **nvim-tree.lua**: File explorer

### Edición
- **nvim-treesitter**: Parsing y highlighting (NUEVA API)
- **nvim-cmp**: Autocompletado
- **Comment.nvim**: Comentarios

### LSP y desarrollo
- **nvim-lspconfig**: Configuración de LSP
- **mason.nvim**: Gestor de LSP servers
- **null-ls.nvim** o **none-ls.nvim**: Formatters y linters

### Java
- **nvim-jdtls**: Java LSP
- Custom runners y helpers en `lua/core/`

### UI
- **rose-pine**: Color scheme
- **lualine.nvim**: Statusline
- **bufferline.nvim**: Buffer tabs
- **toggleterm.nvim**: Terminal integrado

### Utilidades
- **plenary.nvim**: Librería de utilidades
- **nvim-web-devicons**: Iconos

### Git
- **lazygit.nvim**: Interfaz TUI de lazygit integrada
  - **Toggle personalizado**: `lua/core/lazygit-toggle.lua`
  - **Keybinding**: `<leader>gg` - Abre/cierra como toggle
  - **Cómo cerrar**: Presiona `<leader>gg` nuevamente o `q` dentro de lazygit
  - **Comandos**: `:LazyGit`, `:LazyGitCurrentFile`, `:LazyGitConfig`
  - **Requiere**: `lazygit` instalado en el sistema

- **git-commands**: Comandos Git interactivos (`lua/core/git-commands.lua`)
  - `<leader>ga` - Add archivos (selector interactivo)
  - `<leader>gc` - Commit con mensaje
  - `<leader>gp` - Pull (minúscula)
  - `<leader>gP` - Push (mayúscula)
  - `<leader>gb` - Nueva rama + checkout
  - `<leader>go` - Checkout a otra rama (selector interactivo)
  - `<leader>gs` - Status en ventana flotante

---

## Reglas de instalación de plugins

### 1. Verificar compatibilidad
```bash
# SIEMPRE consultar el README oficial primero
# Buscar en el README: "Requirements" o "Neovim version"
```

### 2. Formato de instalación con Lazy.nvim
```lua
return {
  {
    'autor/nombre-plugin',
    branch = 'main',  -- o 'master', según el repo
    lazy = false,     -- true si quieres lazy loading
    dependencies = {  -- dependencias del plugin
      'dep1/plugin1',
      'dep2/plugin2',
    },
    config = function()
      -- Configuración del plugin
      require('plugin').setup({
        -- opciones
      })
    end
  }
}
```

### 3. Comandos de gestión
```vim
:Lazy sync          " Actualizar todos los plugins
:Lazy update        " Actualizar plugins específicos
:Lazy clean         " Limpiar plugins no usados
:Lazy clear         " Limpiar caché
```

---

## Treesitter (IMPORTANTE: Nueva API)

### Instalación de parsers
```lua
-- En lua/plugins/treesitter.lua
require('nvim-treesitter').install({ 'lua', 'python', 'javascript' })
```

### NO usar estas funciones (deprecadas en 0.11+)
```lua
-- ❌ NO USAR
require('nvim-treesitter.configs').setup({})

-- ✅ USAR
require('nvim-treesitter').install({ 'lenguaje' })
```

### Activar highlighting
```lua
-- En init.lua o ftplugin
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
```

---

## OpenCode Panel

El panel de OpenCode es una terminal integrada personalizada:

- **Toggle**: `<leader>aa` (abre/cierra el panel)
- **Ask about selection**: `<leader>as` (consulta sobre texto seleccionado)
- **Ask about buffer**: `<leader>ab` (consulta sobre el archivo actual)

**Comportamiento:**
- Se abre en modo insertar automáticamente
- Mantiene la sesión activa entre abre/cierra
- Panel lateral izquierdo de 60 columnas

---

## LSP y autocompletado

### Instalación de LSP servers
```vim
:Mason              " Abrir el gestor de LSP servers
:MasonInstall <server>  " Instalar un LSP server
```

### Servidores instalados
- `jdtls`: Java
- `lua_ls`: Lua
- `tsserver`: TypeScript/JavaScript
- (otros según necesidad)

---

## Dependencias del sistema

Algunos plugins requieren herramientas instaladas en el sistema:

### lazygit (para lazygit.nvim)
```bash
# Arch Linux / Manjaro
sudo pacman -S lazygit

# Ubuntu / Debian
sudo apt install lazygit

# macOS
brew install lazygit

# Verificar instalación
lazygit --version
```

---

## Comandos útiles de Neovim 0.11+

```vim
:checkhealth        " Verificar estado de Neovim
:Lazy               " Gestor de plugins
:Mason              " Gestor de LSP
:TSUpdate           " Actualizar parsers de Treesitter
:LspInfo            " Info de LSP activos
:Telescope          " Abrir fuzzy finder
:LazyGit            " Abrir lazygit (Ctrl+G)
```

---

## Antes de hacer cualquier cambio

1. **Consulta la documentación oficial** con WebFetch
2. **Verifica compatibilidad** con Neovim 0.11.5
3. **Lee los breaking changes** recientes del plugin
4. **Prueba en un archivo de prueba** antes de aplicar globalmente
5. **Notifica al usuario** de cambios importantes

---

## Recursos oficiales

- **Neovim docs**: https://neovim.io/doc/
- **Lazy.nvim**: https://github.com/folke/lazy.nvim
- **nvim-treesitter**: https://github.com/nvim-treesitter/nvim-treesitter
- **Telescope**: https://github.com/nvim-telescope/telescope.nvim
- **Mason**: https://github.com/williamboman/mason.nvim

---

## Notas finales

- Este es un entorno de desarrollo en **constante actualización**
- Prioriza **estabilidad** sobre features experimentales
- Siempre **documenta** los cambios que hagas
- Si algo no funciona, **consulta primero** antes de cambiar
