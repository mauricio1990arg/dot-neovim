# Configuración de React Router 7 para Neovim 0.11

## 📋 Resumen de Cambios (29 Enero 2026)

He configurado Neovim 0.11 para trabajar con **React Router 7** usando el método **ftplugin** y herramientas gestionadas por **Mason**.

## 🗂️ Estructura de Archivos

```
~/.config/nvim/
├── ftplugin/
│   ├── typescript.lua          # Configuración principal TS/React
│   ├── typescriptreact.lua     # TSX (React Router 7)
│   ├── javascript.lua          # JS
│   └── javascriptreact.lua     # JSX
├── lsp/
│   ├── tsserver.lua            # Config TypeScript LSP
│   ├── eslint.lua              # Config ESLint LSP
│   ├── lua_ls.lua
│   ├── jsonls.lua
│   ├── yamlls.lua
│   └── lemminx.lua
├── lua/
│   ├── core/
│   │   ├── react-helpers.lua   # Comandos helper React Router 7
│   │   ├── react-check.lua     # Diagnóstico instalación
│   │   ├── java-helpers.lua
│   │   └── java-check.lua
│   └── plugins/
│       ├── mason.lua           # Instalación herramientas
│       ├── lsp-config.lua      # LSP config
│       ├── treesitter.lua      # Parsers TS/TSX/JS/JSX
│       └── ...
└── init.lua
```

## ✅ Herramientas Instaladas vía Mason

- **typescript-language-server** - LSP para TypeScript/JavaScript
- **eslint-lsp** - Linting en tiempo real
- **prettier** - Formateo de código
- **vtsls** - Alternativa moderna a tsserver (opcional)

## 🔧 Características Configuradas

### 1. LSP TypeScript/JavaScript
- Autocompletado inteligente
- Inlay hints (tipos inferidos)
- Go to definition/references
- Rename refactoring
- Imports relativos por defecto

### 2. ESLint Integration
- Linting en tiempo real
- Fix on save (configurable)
- Code actions para reglas específicas

### 3. Treesitter
- Syntax highlighting para TS/TSX/JS/JSX
- Indentación inteligente
- Parsers auto-instalados

### 4. React Router 7 Específico
- Soporte para tipos generados en `.react-router/types`
- Detección automática de configuración
- Comandos helper para verificación

## 🚀 Cómo Usar

### 1. Reinicia Neovim
```bash
nvim
```

### 2. Verifica la instalación
```vim
:ReactCheckInstallation
```

Esto verificará:
- ✅ Herramientas Mason instaladas
- ✅ Node.js y npm disponibles
- ✅ Proyecto React Router 7 detectado
- ✅ tsconfig.json configurado
- ✅ LSP activos
- ✅ Treesitter parsers

### 3. Instala herramientas faltantes (si es necesario)
```vim
:Mason
```
- Busca: `typescript-language-server`, `eslint-lsp`, `prettier`
- Presiona `i` para instalar
- Espera a que termine

### 4. Instala parsers Treesitter (si es necesario)
```vim
:TSInstall typescript tsx javascript jsx
```

### 5. Abre un archivo React Router 7
```bash
cd tu-proyecto-react-router
nvim app/routes/home.tsx
```

El LSP debería iniciarse automáticamente.

## ⌨️ Atajos TypeScript/React (cuando LSP está activo)

### Atajos Específicos React Router 7
- `<leader>to` - **Organizar imports** (remove unused + sort)
- `<leader>tr` - **Remover imports no usados**
- `<leader>tf` - **Fix all ESLint issues**

### Atajos LSP Estándar (ya configurados)
- `gD` - Ir a declaración
- `gd` - Ir a definición
- `K` - Mostrar documentación (hover)
- `gi` - Ir a implementación
- `<leader>rn` - Renombrar símbolo
- `<leader>ca` - Code actions
- `gr` - Buscar referencias
- `<leader>f` - Formatear archivo

## 🔧 Comandos Disponibles

### React Router 7
- `:ReactCheckInstallation` - Verifica instalación completa
- `:ReactRouterSetup` - Verifica configuración del proyecto
- `:ReactRouterCheckTypes` - Verifica tipos generados
- `:ReactRouterConfig` - Abre react-router.config.ts

### General
- `:Mason` - Gestor de herramientas
- `:LspInfo` - Estado del LSP
- `:TSInstall <lang>` - Instalar parser Treesitter
- `:checkhealth vim.lsp` - Diagnóstico del LSP

## 📝 Configuración React Router 7

### tsconfig.json Requerido

Tu `tsconfig.json` debe incluir:

```json
{
  "include": [
    "**/*",
    ".react-router/types/**/*"
  ],
  "compilerOptions": {
    "rootDirs": [".", "./.react-router/types"],
    "types": ["@react-router/node", "vite/client"],
    "jsx": "react-jsx",
    "module": "ESNext",
    "target": "ES2022",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "moduleResolution": "Bundler",
    "resolveJsonModule": true,
    "allowJs": true,
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
```

### react-router.config.ts Ejemplo

```typescript
import type { Config } from "@react-router/dev/config";

export default {
  appDirectory: "app",
  buildDirectory: "build",
  ssr: true,
  prerender: ["/", "/about"],
} satisfies Config;
```

### Estructura de Proyecto Típica

```
tu-proyecto/
├── app/
│   ├── routes/
│   │   ├── _index.tsx
│   │   ├── about.tsx
│   │   └── posts.$id.tsx
│   ├── root.tsx
│   └── routes.ts
├── .react-router/
│   └── types/           # Generado automáticamente
├── react-router.config.ts
├── tsconfig.json
├── package.json
└── vite.config.ts
```

## 🐛 Solución de Problemas

### LSP no se inicia en archivos .tsx

**Causa**: typescript-language-server no instalado o ftplugin no cargado.

**Solución**:
```vim
:ReactCheckInstallation
:Mason
```
Instala `typescript-language-server` si falta.

### ESLint no muestra errores

**Causa**: eslint-lsp no instalado o no hay `.eslintrc` en el proyecto.

**Solución**:
1. Verifica instalación: `:Mason` → `eslint-lsp`
2. Crea `.eslintrc.js` en tu proyecto:
```javascript
module.exports = {
  extends: ['@react-router/eslint-config'],
  // o tu configuración preferida
}
```

### Tipos de React Router 7 no funcionan

**Causa**: `.react-router/types` no generado o tsconfig mal configurado.

**Solución**:
```bash
# En tu proyecto, ejecuta el dev server una vez
npm run dev
# Esto genera los tipos en .react-router/types
```

Luego verifica:
```vim
:ReactRouterCheckTypes
:ReactRouterSetup
```

### Imports no se organizan automáticamente

**Usa el atajo manual**:
```vim
<leader>to
```

O configura format-on-save en tu proyecto.

### Treesitter syntax highlighting no funciona

**Instala los parsers**:
```vim
:TSInstall typescript tsx javascript jsx
```

## 🔍 Issues Conocidos de React Router 7

### Versión Actual: v7.13.0 (23 Enero 2026)

**Fixes recientes importantes:**
- ✅ **v7.12.0**: Vulnerabilidades CSRF y XSS corregidas
- ✅ **v7.12.0**: HMR con imports cíclicos arreglado
- ✅ **v7.13.0**: Double slash en rutas con colon corregido
- ✅ **v7.13.0**: Missing nonce en criticalCss arreglado

**Problemas abiertos a considerar:**
- Duplicated styles con suspended components (v7.9.5+)
- Typegen bug con rutas en carpetas `*` (e.g., `/*/route.tsx`)
- Compatibilidad con `exactOptionalPropertyTypes: true`

**Recomendación**: Mantén React Router actualizado, pero revisa el CHANGELOG antes de actualizar.

## 📚 Referencias

- [React Router 7 Official Docs](https://reactrouter.com/)
- [React Router GitHub](https://github.com/remix-run/react-router)
- [React Router 7 Changelog](https://github.com/remix-run/react-router/blob/main/CHANGELOG.md)
- [TypeScript LSP Docs](https://github.com/typescript-language-server/typescript-language-server)
- [Neovim 0.11 LSP Changes](https://gpanders.com/blog/whats-new-in-neovim-0-11/)

## ✨ Por Qué Este Método

El método **ftplugin + Mason** es:
- ✅ Automático por tipo de archivo
- ✅ No depende de archivos externos
- ✅ Compatible con Neovim 0.11
- ✅ Fácil de mantener y actualizar
- ✅ Sigue las mejores prácticas de Neovim
- ✅ Herramientas gestionadas centralmente por Mason

## 🎯 Diferencias con Java Setup

| Aspecto | Java | React Router 7 |
|---------|------|----------------|
| LSP | jdtls (via nvim-jdtls) | ts_ls + eslint |
| Gestor | Mason | Mason |
| Método | ftplugin/java.lua | ftplugin/typescript.lua |
| Tipos | Lombok config | .react-router/types |
| Build | Maven/Gradle | Vite |
| Debugger | java-debug-adapter | (no configurado aún) |

---

**Fecha**: 29 de enero de 2026  
**Método**: ftplugin + Mason  
**Versión React Router**: 7.13.0  
**Neovim**: 0.11
