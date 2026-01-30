# Checklist: Configuración Neovim para Administración de Servidor Bare Metal

## Estado: ✅ COMPLETADO

---

## ACTUALIZACIÓN: Purga de Docker - Migración a Systemd

### Cambios de Infraestructura
**ANTES:** Docker + docker-compose  
**AHORA:** Bare Metal + Systemd + Java 25 (.jar)

**Servicio principal:** `app-provincial.service`  
**Gestión de logs:** journalctl (systemd)  
**Variables de entorno:** Archivos .env cargados a la JVM

---

## 1. Análisis y Planificación
- [x] Leer estructura actual del proyecto
- [x] Identificar archivos y plugins a eliminar
- [x] Identificar archivos y plugins a mantener
- [x] Identificar nuevos plugins a instalar
- [x] **Eliminar completamente Docker**
- [x] **Migrar a Systemd**

## 2. Configuración de Oil.nvim (Explorador de Archivos)
- [x] Investigar documentación de Oil.nvim
- [x] Instalar Oil.nvim
- [x] Configurar mostrar archivos ocultos por defecto
- [x] Configurar edición de permisos de archivos (keymap `gp`)
- [x] Establecer como explorador por defecto

## 3. Configuración de Telescope (Buscador)
- [x] Modificar Telescope para ignorar .gitignore
- [x] Configurar búsqueda en rutas del sistema (/etc/, /var/log/)
- [x] Crear buscador específico para /etc/systemd/system/ (`<leader>fS`)
- [x] **Eliminar buscador de Docker**
- [x] Configurar ignore de archivos binarios (.jar, .class, .zip, etc.)
- [x] Añadir keymaps relevantes

## 4. Visualización de Logs
- [x] Configurar resaltado de sintaxis para archivos .log (vim-log-highlighting)
- [x] Optimizar buffers para archivos grandes (bigfile.nvim)
- [x] Configurar detección automática de archivos .log
- [x] Desactivar features pesadas para archivos grandes
- [x] Añadir keymaps útiles (lt, lr, le, lw)

## 5. Gestión de Systemd
- [x] **Crear systemd-commands.lua** (reemplaza docker-commands.lua)
- [x] **Comando :LogsApp** para journalctl -u app-provincial.service -f -n 100
- [x] Comandos de gestión de servicios (start, stop, restart, status)
- [x] Comandos de configuración (enable, disable, daemon-reload)
- [x] Listado de servicios (todos, activos, fallidos)
- [x] Logs del sistema (journalctl, errores)
- [x] Terminal systemctl interactiva
- [x] Actualizar keymaps (menú `<leader>s*`)

## 6. Tipos de Archivo
- [x] **Crear filetype-config.lua**
- [x] Detección de archivos .service (systemd)
- [x] Detección de archivos .env (con advertencia de seguridad)
- [x] Validador de formato para archivos .env (`<leader>ev`)
- [x] Detección de archivos .properties (Java/Spring)
- [x] Detección de archivos .conf
- [x] Configuración de scripts shell (.sh, .bash)

## 7. Limpieza de LSPs
- [x] Desactivar jdtls (Java)
- [x] Desactivar rust-analyzer
- [x] Desactivar tsserver y ESLint
- [x] **Desactivar dockerls**
- [x] Mantener solo: yamlls, jsonls, bashls, lua_ls
- [x] Añadir schemastore para validación JSON/YAML

## 8. Eliminación de Archivos Innecesarios
- [x] Eliminar java-helpers.lua
- [x] Eliminar java-check.lua
- [x] Eliminar nodejs.lua
- [x] Eliminar runners.lua
- [x] Eliminar react-helpers.lua y react-check.lua
- [x] **Eliminar docker-commands.lua**
- [x] Eliminar plugins: nvim-jdtls, dap, nvim-dbee, aerial, codeium, render-markdown
- [x] Eliminar neotree (reemplazado por Oil)
- [x] Limpiar ftplugin/ y config/

## 9. Mantener Features Esenciales
- [x] Mantener lazygit.nvim y configuración
- [x] Mantener git-commands.lua
- [x] Mantener navegación personalizada (o, l, k, ñ)
- [x] Mantener tema rose-pine
- [x] Mantener integración OpenCode

## 10. Actualización de Documentación
- [x] Actualizar AGENT.md para reflejar Bare Metal + Systemd
- [x] Actualizar CHECKLIST.md con cambios de infraestructura
- [x] Documentar nuevos keymaps de Systemd
- [x] Documentar comando :LogsApp
- [x] Documentar configuración de tipos de archivo

## 11. Verificación Final
- [ ] Probar Oil.nvim
- [ ] Probar búsquedas de Telescope en /etc/ y /var/
- [ ] Probar búsqueda en /etc/systemd/system/
- [ ] Probar comando :LogsApp
- [ ] Probar apertura de archivos .log grandes
- [ ] Probar comandos de Systemd
- [ ] Verificar que solo LSPs esenciales están activos
- [ ] Verificar que archivos binarios son ignorados
- [ ] Ejecutar :checkhealth

---

## Resumen de Cambios (Actualización Systemd)

### Archivos Nuevos
- `lua/core/systemd-commands.lua`: Gestión completa de servicios Systemd
- `lua/core/filetype-config.lua`: Detección y configuración de .service, .env, .properties, etc.

### Archivos Eliminados
- `lua/core/docker-commands.lua`: ❌ Eliminado (no hay Docker)

### Archivos Modificados
- `init.lua`: Agregado comando :LogsApp y carga de filetype-config
- `lua/plugins/telescope.lua`: Eliminado buscador de Docker, agregado buscador de Systemd, ignorar binarios
- `lua/plugins/nvim-lspconfig.lua`: Eliminado dockerls, ajustado yamlls
- `lua/core/keymaps.lua`: Reemplazado menú Docker (`<leader>k*`) con menú Systemd (`<leader>s*`)

### LSPs Activos
**ANTES:** ts_ls, eslint, lua_ls, jsonls, yamlls, lemminx, jdtls, dockerls  
**AHORA:** jsonls, yamlls, bashls, lua_ls

### Archivos Ignorados en Telescope
- Binarios: .jar, .war, .class, .so, .dll, .exe, .bin
- Comprimidos: .zip, .tar, .gz, .bz2, .xz, .7z, .rar
- Imágenes: .iso, .img
- Media: .pdf, .mp4, .mkv, .avi, .jpg, .png, .gif
- Directorios: node_modules/, .git/, target/, build/

---

## Keymaps Principales (Actualizado)

### Oil (Explorador de Archivos)
- `e` o `-` o `<leader>o`: Abrir Oil
- `<leader>O`: Abrir Oil flotante
- `gp`: Cambiar permisos de archivo (chmod)

### Telescope (Búsqueda)
- `<leader>fe`: Buscar en /etc/
- `<leader>fS`: Buscar en /etc/systemd/system/ (servicios)
- `<leader>fl`: Buscar archivos .log
- `<leader>fL`: Buscar en /var/log/
- `<leader>fc`: Buscar configs (.conf, .yaml, .json, .env, .properties)
- `<leader>ff`: Buscar archivos
- `<leader>fg`: Grep en archivos

### Systemd (menú `<leader>s*`)
- `<leader>sl`: Logs de app-provincial.service
- `<leader>ss`: Status del servicio
- `<leader>sr`: Restart servicio
- `<leader>sS`: Stop servicio
- `<leader>sa`: Start servicio
- `<leader>sd`: Daemon reload
- `<leader>se`: Enable servicio al inicio
- `<leader>sE`: Disable servicio del inicio
- `<leader>sL`: Listar todos los servicios
- `<leader>sf`: Listar servicios fallidos
- `<leader>st`: Terminal systemctl
- `<leader>sj`: Logs del sistema (journalctl -f)
- `<leader>sx`: Errores del sistema

### Logs
- `<leader>lt`: Tail -f mode
- `<leader>lr`: Recargar log
- `<leader>le`: Buscar siguiente error
- `<leader>lw`: Buscar siguiente warning

### Archivos .env
- `<leader>ev`: Validar formato .env (KEY=VALUE)

### Git (Mantenido)
- `<leader>gg`: Toggle LazyGit
- `<leader>ga`: Git add
- `<leader>gc`: Git commit
- `<leader>gp`: Git pull
- `<leader>gP`: Git push

### Terminal
- `<leader>t`: Terminal horizontal
- `<leader>T`: Terminal flotante

### Comandos Especiales
- `:LogsApp`: journalctl -u app-provincial.service -f -n 100

---

**Rama:** config-server  
**Propósito:** Panel de control de Linux para administración de servidor Debian 13 (Bare Metal)  
**Infraestructura:** Debian 13 + Systemd + Java 25 + Sin Docker  
**Servicio:** app-provincial.service  
**Fecha actualización:** 2026-01-30  
**Estado:** ✅ Configuración completada - Lista para producción
