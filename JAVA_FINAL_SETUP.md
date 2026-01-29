# Configuración Final de Java para Neovim 0.11

## 📋 Resumen de Cambios (29 Enero 2026)

He migrado completamente tu configuración a **Neovim 0.11** usando el método **ftplugin** recomendado por nvim-jdtls.

## 🗂️ Estructura Final

```
~/.config/nvim/
├── ftplugin/
│   └── java.lua              # Configuración de jdtls (NUEVO)
├── lsp/
│   ├── lua_ls.lua
│   ├── jsonls.lua
│   ├── yamlls.lua
│   └── lemminx.lua
├── lua/
│   ├── core/
│   │   ├── java-helpers.lua  # Comandos helper
│   │   └── java-check.lua    # Diagnóstico
│   └── plugins/
│       ├── mason.lua         # Instalación de herramientas
│       ├── lsp-config.lua    # LSP para Lua, JSON, YAML, XML
│       ├── dap.lua           # Debugger
│       └── luasnip.lua       # Snippets
└── init.lua
```

## ✅ Qué Cambió

### 1. Eliminado `java-lsp.lua` del directorio plugins
- Este archivo causaba conflictos con el sistema de plugins

### 2. Creado `ftplugin/java.lua`
- Este es el método **oficial** recomendado por nvim-jdtls
- Se ejecuta automáticamente cuando abres un archivo `.java`
- Usa `require('jdtls').start_or_attach(config)` directamente

### 3. Validación robusta
- Verifica que nvim-jdtls esté instalado
- Verifica que jdtls esté instalado vía Mason
- Verifica que el launcher JAR exista
- Muestra mensajes claros si falta algo

## 🚀 Cómo Usar

### 1. Reinicia Neovim
```bash
nvim
```

### 2. Verifica la instalación
```vim
:JavaCheckInstallation
```

### 3. Instala jdtls si falta
```vim
:Mason
```
- Busca `jdtls`
- Presiona `i` para instalar
- Espera a que termine (puede tardar varios minutos)

### 4. Abre un archivo Java
```bash
cd tu-proyecto-java
nvim src/main/java/Main.java
```

El LSP debería iniciarse automáticamente sin errores.

### 5. Genera lombok.config
```vim
:JavaSetupLombok
```

## 🔧 Comandos Disponibles

- `:JavaCheckInstallation` - Verifica instalación completa
- `:JavaSetupLombok` - Genera lombok.config en el proyecto
- `:Mason` - Gestor de herramientas
- `:LspInfo` - Estado del LSP
- `:checkhealth vim.lsp` - Diagnóstico del LSP

## ⌨️ Atajos Java (cuando jdtls está activo)

- `<leader>jo` - Organizar imports
- `<leader>jv` - Extraer variable
- `<leader>jc` - Extraer constante
- `<leader>jm` - Extraer método (visual mode)
- `<leader>tc` - Ejecutar test de clase
- `<leader>tm` - Ejecutar test del método actual

## 🐛 Solución de Problemas

### Error al abrir archivo Java

**Causa**: jdtls no está instalado o el launcher JAR no se encuentra.

**Solución**:
```vim
:JavaCheckInstallation
```
Esto te dirá exactamente qué falta.

### jdtls no se inicia

**Verifica**:
1. Java está instalado: `java -version`
2. jdtls está instalado: `:Mason` → busca `jdtls`
3. Estás en un proyecto Java válido (tiene `pom.xml` o `build.gradle`)

### Lombok no funciona

```vim
:JavaSetupLombok
```

Esto genera el archivo `lombok.config` necesario.

## 📚 Referencias

- [nvim-jdtls Official Docs](https://github.com/mfussenegger/nvim-jdtls)
- [Neovim 0.11 LSP Changes](https://gpanders.com/blog/whats-new-in-neovim-0-11/)
- [Reddit: JDTLS with Neovim 0.11](https://www.reddit.com/r/neovim/comments/1jwke3l/jdtls_configuration_with_new_lsp_api_in_neovim_011/)

## ✨ Por Qué Este Método

El método **ftplugin** es:
- ✅ Recomendado oficialmente por nvim-jdtls
- ✅ Compatible con Neovim 0.11
- ✅ Más simple y directo
- ✅ Se ejecuta automáticamente por archivo
- ✅ No requiere `jdtls` en el PATH

---

**Fecha**: 29 de enero de 2026  
**Método**: ftplugin con nvim-jdtls
