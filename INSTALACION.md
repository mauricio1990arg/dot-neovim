# 📦 Guía de Instalación - Configuración Neovim

Esta guía detalla todos los requisitos y pasos necesarios para usar esta configuración de Neovim en cualquier PC.

## 🔧 Requisitos del Sistema

### 1. Neovim 0.11+
```bash
# Verificar versión
nvim --version

# Debe mostrar: NVIM v0.11.0 o superior
```

**Instalación:**
- **Ubuntu/Debian:**
  ```bash
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt install neovim
  ```
- **Arch Linux:**
  ```bash
  sudo pacman -S neovim
  ```
- **Fedora:**
  ```bash
  sudo dnf install neovim
  ```

### 2. Git
```bash
sudo apt install git  # Ubuntu/Debian
sudo pacman -S git    # Arch
sudo dnf install git  # Fedora
```

### 3. Node.js y npm (Para LSP de TypeScript/JavaScript)
```bash
# Verificar instalación
node --version  # v18+ recomendado
npm --version

# Instalación con nvm (recomendado)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install --lts
nvm use --lts
```

### 4. Compilador C/C++ (Para Treesitter)
```bash
# Ubuntu/Debian
sudo apt install build-essential

# Arch Linux
sudo pacman -S base-devel

# Fedora
sudo dnf groupinstall "Development Tools"
```

### 5. Ripgrep (Para Telescope búsqueda de texto)
```bash
# Ubuntu/Debian
sudo apt install ripgrep

# Arch Linux
sudo pacman -S ripgrep

# Fedora
sudo dnf install ripgrep
```

### 6. fd (Para Telescope búsqueda de archivos)
```bash
# Ubuntu/Debian
sudo apt install fd-find

# Arch Linux
sudo pacman -S fd

# Fedora
sudo dnf install fd-find
```

### 7. Nerd Font (Para iconos en Neo-tree y Bufferline)
Descarga e instala una Nerd Font desde: https://www.nerdfonts.com/

**Recomendadas:**
- JetBrainsMono Nerd Font
- FiraCode Nerd Font
- Hack Nerd Font

```bash
# Instalación rápida (Ubuntu/Debian)
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
```

**Importante:** Configura tu terminal para usar la Nerd Font instalada.

### 8. Java JDK 17+ (Solo para desarrollo Java/Spring Boot)
```bash
# Ubuntu/Debian
sudo apt install openjdk-17-jdk

# Arch Linux
sudo pacman -S jdk17-openjdk

# Fedora
sudo dnf install java-17-openjdk-devel

# Verificar
java -version
```

### 9. Python 3 y pip (Para algunos plugins)
```bash
# Ubuntu/Debian
sudo apt install python3 python3-pip

# Arch Linux
sudo pacman -S python python-pip

# Fedora
sudo dnf install python3 python3-pip
```

## 📥 Instalación de la Configuración

### 1. Clonar o copiar la configuración
```bash
# Opción 1: Si tienes backup
cp -r /ruta/backup/.config/nvim ~/.config/

# Opción 2: Desde repositorio git (si lo tienes)
git clone <tu-repo> ~/.config/nvim

# Opción 3: Copiar manualmente
# Copia toda la carpeta .config/nvim a ~/.config/nvim
```

### 2. Primera ejecución de Neovim
```bash
nvim
```

**¿Qué sucede automáticamente?**

✅ **Lazy.nvim** se instala automáticamente (gestor de plugins)  
✅ **Todos los plugins** se descargan e instalan automáticamente  
✅ **Mason** se instala y configura automáticamente  
✅ **Herramientas LSP** se instalan automáticamente vía Mason:
   - `typescript-language-server` (TypeScript/JavaScript/React)
   - `eslint-lsp` (Linting JS/TS)
   - `prettier` (Formateo)
   - `vtsls` (TypeScript alternativo)
   - `jdtls` (Java)
   - `java-debug-adapter` (Debug Java)
   - `java-test` (Testing Java)
   - `lua-language-server` (Lua)
   - `json-lsp` (JSON)
   - `yaml-language-server` (YAML)
   - `lemminx` (XML)

✅ **Parsers de Treesitter** se compilan automáticamente:
   - `lua`, `vim`, `vimdoc`, `query`
   - `java`, `javascript`, `typescript`, `tsx`, `jsx`
   - `json`, `yaml`, `xml`, `html`, `css`
   - `markdown`, `markdown_inline`

### 3. Verificar instalación
Dentro de Neovim:
```vim
:checkhealth
```

Esto mostrará el estado de todas las dependencias.

## 🔍 Comandos Útiles de Mason

```vim
:Mason              " Abrir interfaz de Mason
:MasonInstall <tool> " Instalar herramienta específica
:MasonUpdate        " Actualizar todas las herramientas
:MasonUninstall <tool> " Desinstalar herramienta
```

## 🎨 Configuración del Terminal

Para que los iconos y colores se vean correctamente:

1. **Instala una Nerd Font** (ver arriba)
2. **Configura tu terminal** para usar la Nerd Font
3. **Habilita true color** en tu terminal

**Ejemplo para Alacritty** (`~/.config/alacritty/alacritty.yml`):
```yaml
font:
  normal:
    family: "JetBrainsMono Nerd Font"
    style: Regular
  size: 12.0
```

**Ejemplo para Kitty** (`~/.config/kitty/kitty.conf`):
```
font_family JetBrainsMono Nerd Font
font_size 12.0
```

**Ejemplo para GNOME Terminal:**
1. Preferencias → Perfil → Texto
2. Selecciona "JetBrainsMono Nerd Font"

## 🚀 Proyectos React Router 7

Para que funcione el autocompletado de React Router 7:

1. **Instala React Router 7 en tu proyecto:**
   ```bash
   cd tu-proyecto
   npm install react-router@7
   ```

2. **Configura `tsconfig.json`:**
   ```json
   {
     "include": [
       "**/*",
       ".react-router/types/**/*"
     ],
     "compilerOptions": {
       "rootDirs": [".", "./.react-router/types"],
       "types": ["@react-router/node", "vite/client"]
     }
   }
   ```

3. **Reinicia el LSP:**
   ```vim
   :LspRestart
   ```

## 🐛 Solución de Problemas

### Treesitter no compila parsers
```bash
# Instala compilador C
sudo apt install build-essential  # Ubuntu/Debian
```

### Icons no se ven (cuadrados o símbolos raros)
- Instala una Nerd Font
- Configura tu terminal para usarla
- Reinicia el terminal

### LSP no funciona
```vim
:LspInfo           " Ver estado de LSP
:Mason             " Verificar herramientas instaladas
:checkhealth lsp   " Diagnóstico LSP
```

### Telescope no encuentra archivos
```bash
# Instala ripgrep y fd
sudo apt install ripgrep fd-find
```

### Java LSP no funciona
```bash
# Verifica Java instalado
java -version  # Debe ser 17+

# Reinstala jdtls
:MasonUninstall jdtls
:MasonInstall jdtls
```

## 📝 Resumen de Comandos Post-Instalación

```bash
# 1. Instalar dependencias del sistema
sudo apt install neovim git build-essential ripgrep fd-find nodejs npm openjdk-17-jdk python3 python3-pip

# 2. Instalar Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip && rm JetBrainsMono.zip
fc-cache -fv

# 3. Copiar configuración
cp -r /backup/.config/nvim ~/.config/

# 4. Abrir Neovim (instalación automática)
nvim

# 5. Verificar
:checkhealth
```

## ✅ Checklist de Instalación

- [ ] Neovim 0.11+ instalado
- [ ] Git instalado
- [ ] Node.js y npm instalados
- [ ] Compilador C (build-essential) instalado
- [ ] Ripgrep instalado
- [ ] fd instalado
- [ ] Nerd Font instalada y configurada en terminal
- [ ] Java JDK 17+ (si usas Java)
- [ ] Python 3 y pip instalados
- [ ] Configuración de nvim copiada a ~/.config/nvim
- [ ] Primera ejecución de nvim completada
- [ ] `:checkhealth` sin errores críticos
- [ ] Iconos se ven correctamente
- [ ] LSP funciona (`:LspInfo`)

## 🎯 Atajos de Teclado

Todos los atajos están documentados en:
- `~/.config/nvim/lua/core/keymaps.lua`

Presiona `<Space>` (leader) para ver los atajos disponibles con which-key.

## 📚 Recursos Adicionales

- [Neovim Documentation](https://neovim.io/doc/)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Nerd Fonts](https://www.nerdfonts.com/)
