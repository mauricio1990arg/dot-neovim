# AGENT INSTRUCTIONS - Rama config-server

## ⚠️ IMPORTANTE: Esta es la rama config-server

**Propósito de esta rama:** Configuración especializada de Neovim como **panel de control de Linux** para administración manual de servidor Debian 13 (KVM 4) en **Bare Metal**.

**NO ES UN EDITOR DE CÓDIGO.** Esta configuración está optimizada para:
- Gestión de archivos del sistema (/etc/, /var/log/, etc.)
- Administración de servicios Systemd
- Monitoreo de logs del sistema con journalctl
- Edición de archivos de configuración (YAML, JSON, .service, .env, .conf, etc.)
- Gestión de aplicación Java ejecutada directamente con Systemd (sin contenedores)

**Infraestructura:** Bare Metal - Debian 13 - Systemd - Java 25 - Sin Docker

---

## Información del entorno

**Versión de Neovim:** `0.11.5` (actualizado en diciembre 2025)  
**Fecha actual:** Enero 2026  
**Sistema operativo:** Linux (Debian 13)  
**Servidor:** KVM 4  
**Infraestructura:** Bare Metal (sin contenedores)  
**Aplicación:** Java 25 (.jar) ejecutado vía Systemd  
**Servicio principal:** `app-provincial.service`

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

---

## Estructura del proyecto (optimizada para Sysadmin)

```
~/.config/nvim/
├── init.lua                       # Punto de entrada principal
├── CHECKLIST.md                   # Lista de tareas de configuración
├── AGENT.md                       # Este archivo
├── lua/
│   ├── core/                      # Configuraciones core
│   │   ├── lazy.lua               # Gestor de plugins (Lazy.nvim)
│   │   ├── keymaps.lua            # Atajos de teclado
│   │   ├── options.lua            # Opciones de Neovim
│   │   ├── opencode-panel.lua     # Panel de OpenCode
│   │   ├── lazygit-toggle.lua     # Toggle de LazyGit
│   │   ├── git-commands.lua       # Comandos Git interactivos
│   │   ├── systemd-commands.lua   # Comandos Systemd (NEW)
│   │   ├── log-config.lua         # Configuración para logs
│   │   ├── filetype-config.lua    # Configuración de tipos de archivo (NEW)
│   │   └── zoom.lua               # Zoom dual
│   └── plugins/                   # Configuración de plugins
│       ├── oil.lua                # Oil.nvim (explorador de archivos)
│       ├── telescope.lua          # Fuzzy finder para servidor
│       ├── log-viewer.lua         # Visualización de logs
│       ├── nvim-lspconfig.lua     # LSP minimalista (sin Docker)
│       ├── schemastore.lua        # Schemas para JSON/YAML
│       ├── lazygit.lua            # LazyGit
│       ├── toggleterm.lua         # Terminal integrada
│       ├── theme.lua              # Rose Pine theme
│       └── ...                    # Otros plugins UI
```

---

## Plugins instalados (específicos para Sysadmin)

### Gestor de plugins
- **lazy.nvim**: Gestor de plugins moderno

### Navegación y búsqueda
- **oil.nvim**: Explorador de archivos (edita el filesystem como un buffer)
  - Muestra archivos ocultos por defecto
  - Columnas: icon, permissions, size, mtime
  - Keymap: `-` para subir directorio, `gp` para cambiar permisos
- **telescope.nvim**: Fuzzy finder configurado para ignorar .gitignore y binarios
  - `<leader>fe`: Buscar en /etc/
  - `<leader>fS`: Buscar en /etc/systemd/system/ (Servicios)
  - `<leader>fl`: Buscar archivos .log
  - `<leader>fL`: Buscar en /var/log/
  - `<leader>fc`: Buscar archivos de configuración (.conf, .yaml, .json, etc.)
  - **Ignora archivos binarios:** .jar, .class, .so, .zip, .tar.gz, .pdf, imágenes, etc.

### Gestión de Systemd
- **systemd-commands.lua**: Comandos personalizados para gestión de servicios
  - `<leader>sl`: Logs de app-provincial.service (journalctl -f)
  - `<leader>ss`: Status del servicio
  - `<leader>sr`: Restart servicio
  - `<leader>sS`: Stop servicio
  - `<leader>sa`: Start servicio
  - `<leader>sd`: Daemon reload (después de editar .service)
  - `<leader>se`: Enable servicio al inicio
  - `<leader>sE`: Disable servicio del inicio
  - `<leader>sL`: Listar todos los servicios
  - `<leader>sf`: Listar servicios fallidos
  - `<leader>st`: Terminal systemctl
  - `<leader>sj`: Logs del sistema completo
  - `<leader>sx`: Errores del sistema
  - **Comando especial:** `:LogsApp` - journalctl -u app-provincial.service -f -n 100

### Visualización de logs
- **vim-log-highlighting**: Resaltado de sintaxis para archivos .log
- **bigfile.nvim**: Optimización para archivos grandes (>2MB)
- **log-config.lua**: Configuración personalizada para logs
  - Detección automática de archivos .log
  - Modo solo lectura para /var/log/ y /etc/
  - `<leader>lt`: Tail -f mode (auto-scroll)
  - `<leader>lr`: Recargar log
  - `<leader>le`: Buscar siguiente error
  - `<leader>lw`: Buscar siguiente warning

### Tipos de archivo
- **filetype-config.lua**: Configuración especializada para archivos del servidor
  - `.service`, `.timer`, `.socket`: Detectados como systemd
  - `.env`: Detectados como sh, advertencia de seguridad, validador de formato
  - `.properties`: Para configuraciones Java/Spring
  - `.conf`, `.config`: Configuraciones generales
  - Scripts shell: Indentación automática de 2 espacios

### LSP y autocompletado (minimalista)
- **nvim-lspconfig**: Solo LSPs esenciales para Bare Metal:
  - `jsonls`: Para archivos JSON
  - `yamlls`: Para archivos YAML
  - `bashls`: Para scripts shell
  - `lua_ls`: Para configurar Neovim
  - **❌ SIN dockerls** (no hay Docker en este servidor)
- **schemastore.nvim**: Validación de schemas para JSON/YAML
- **nvim-cmp**: Autocompletado básico
- **mason.nvim**: Gestor de LSP servers

### Git
- **lazygit.nvim**: Interfaz TUI de lazygit integrada
  - **Toggle**: `<leader>gg` - Abre/cierra como toggle
  
- **git-commands**: Comandos Git interactivos
  - `<leader>ga`: Add archivos (selector interactivo)
  - `<leader>gc`: Commit con mensaje
  - `<leader>gp`: Pull
  - `<leader>gP`: Push
  - `<leader>gb`: Nueva rama + checkout
  - `<leader>go`: Checkout a otra rama
  - `<leader>gs`: Status en ventana flotante
  - `<leader>gr`: Restore (deshacer cambios)

### UI y tema
- **rose-pine**: Color scheme
- **lualine.nvim**: Statusline
- **bufferline.nvim**: Buffer tabs
- **toggleterm.nvim**: Terminal integrado
  - `<leader>t`: Terminal horizontal
  - `<leader>T`: Terminal flotante
- **which-key.nvim**: Guía de keymaps
- **nvim-notify**: Notificaciones

### OpenCode (IA)
- **opencode.nvim**: Integración con OpenCode
  - `<leader>aa`: Toggle panel
  - `<leader>ac`: Consultar selección
  - `<leader>as`: Consultar buffer

---

## Características principales

### 1. Oil.nvim - Explorador de archivos

Oil permite editar el filesystem como un buffer normal de Neovim:

```
- Abrir: Presiona `e` o `-` o `<leader>o`
- Navegar: Usa las teclas de movimiento normales (o, l, k, ñ)
- Editar: Modifica nombres, permisos, etc. directamente
- Guardar: `:w` para aplicar cambios
- Permisos: Presiona `gp` sobre un archivo para cambiar permisos (chmod)
- Ocultos: `g.` para toggle archivos ocultos
```

### 2. Telescope - Búsqueda optimizada para servidor

Configurado para buscar sin respetar .gitignore e ignorar binarios:

```
<leader>fe  → Buscar en /etc/
<leader>fS  → Buscar en /etc/systemd/system/ (servicios)
<leader>fl  → Buscar archivos .log
<leader>fL  → Buscar en /var/log/
<leader>fc  → Buscar configs (.conf, .yaml, .json, .env, .properties)
<leader>ff  → Buscar archivos en directorio actual
<leader>fg  → Grep en archivos
```

**Archivos ignorados:** .jar, .class, .so, .zip, .tar.gz, .pdf, imágenes, videos, etc.

### 3. Systemd Management

Gestión completa de servicios del sistema:

```
<leader>sl  → Logs de app-provincial.service (journalctl -f)
<leader>ss  → Status del servicio
<leader>sr  → Restart servicio (con confirmación)
<leader>sS  → Stop servicio (con confirmación)
<leader>sa  → Start servicio
<leader>sd  → Daemon reload (después de editar .service)
<leader>se  → Enable servicio al inicio
<leader>sE  → Disable servicio del inicio
<leader>sL  → Listar todos los servicios
<leader>sf  → Listar servicios fallidos
<leader>st  → Terminal systemctl interactiva
<leader>sj  → Logs del sistema completo (journalctl -f)
<leader>sx  → Errores del sistema (journalctl -p err)

:LogsApp    → journalctl -u app-provincial.service -f -n 100
```

### 4. Visualización de logs

Optimizado para ver y analizar logs del sistema:

```
- Detección automática de archivos .log
- Resaltado de sintaxis para logs
- Modo solo lectura para logs del sistema
- <leader>lt: Tail -f mode (auto-scroll)
- <leader>lr: Recargar log
- <leader>le: Buscar siguiente ERROR/FATAL
- <leader>lE: Buscar error anterior
- <leader>lw: Buscar siguiente WARNING
```

### 5. Archivos especiales

**Archivos .service (Systemd):**
- Detectados automáticamente como `systemd`
- Comentarios con `#`
- Keymap: `<leader>sr` para recordatorio de daemon-reload

**Archivos .env (Variables de entorno):**
- Detectados como `sh`
- Advertencia de seguridad al abrir
- Validador de formato: `<leader>ev` (valida KEY=VALUE)

**Archivos .properties (Java/Spring):**
- Detectados como `jproperties`

---

## Lo que NO está disponible en esta rama

Esta configuración NO incluye:

- ❌ Docker / Docker Compose
- ❌ Java (jdtls, runners, helpers)
- ❌ Node.js / React
- ❌ Spring Boot runners
- ❌ Debugger (DAP)
- ❌ Base de datos (nvim-dbee)
- ❌ Snippets de código
- ❌ LSPs de programación (TypeScript, ESLint, Rust, etc.)
- ❌ Codeium / Copilot
- ❌ Tree-sitter para lenguajes de programación

**Esta es una configuración 100% enfocada en administración de servidores Linux.**

---

## Comandos útiles de Neovim 0.11+

```vim
:checkhealth        " Verificar estado de Neovim
:Lazy               " Gestor de plugins
:Mason              " Gestor de LSP (solo YAML, JSON, Bash)
:Oil                " Abrir Oil en directorio actual
:Oil --float        " Abrir Oil flotante
:LazyGit            " Abrir lazygit
:Telescope          " Abrir fuzzy finder
:LogsApp            " journalctl -u app-provincial.service -f -n 100
```

---

## Navegación personalizada

Esta configuración usa un layout de teclado personalizado:

```
o = arriba (k)
l = abajo (j)
k = izquierda (h)
ñ = derecha (l)
```

**Respetar esta navegación en todos los plugins y configuraciones.**

---

## Infraestructura del servidor

**Servidor:** Debian 13 (Bare Metal)  
**Aplicación:** Java 25 ejecutando .jar  
**Gestor de servicios:** Systemd  
**Servicio principal:** app-provincial.service  
**Variables de entorno:** Archivos .env cargados a la JVM  
**Logs:** journalctl (systemd) + archivos .log en /var/log/  
**Sin contenedores:** No hay Docker, Podman, ni ningún tipo de virtualización de contenedores

---

## Antes de hacer cualquier cambio

1. **Consulta la documentación oficial** con WebFetch
2. **Verifica compatibilidad** con Neovim 0.11.5
3. **Lee los breaking changes** recientes del plugin
4. **Recuerda que esta es una configuración para SERVIDOR BARE METAL**, no para programación ni Docker
5. **Notifica al usuario** de cambios importantes

---

## Recursos oficiales

- **Neovim docs**: https://neovim.io/doc/
- **Lazy.nvim**: https://github.com/folke/lazy.nvim
- **Oil.nvim**: https://github.com/stevearc/oil.nvim
- **Telescope**: https://github.com/nvim-telescope/telescope.nvim
- **Mason**: https://github.com/williamboman/mason.nvim
- **Systemd**: https://www.freedesktop.org/software/systemd/man/

---

## Notas finales

- Esta es la rama **config-server**, optimizada para administración de servidores Bare Metal
- Prioriza **rendimiento**, **simplicidad** y **control del sistema** sobre features avanzadas
- Neovim actúa como **panel de control de Linux**, no como editor de código
- Si algo no funciona, **consulta primero** antes de cambiar
- Mantén la configuración **ligera** y **enfocada en tareas de Sysadmin**
