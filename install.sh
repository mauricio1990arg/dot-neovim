#!/bin/bash

# ============================================================================
# Script de instalación de Neovim Nightly
# Instala Neovim en /opt/nvim usando binarios pre-compilados
# ============================================================================

set -e  # Salir si algún comando falla

echo "============================================"
echo "Instalador de Neovim Nightly"
echo "============================================"
echo ""

# URL del binario pre-compilado (nightly)
NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz"
INSTALL_DIR="/opt/nvim"
SHELL_RC="${HOME}/.bashrc"

# Detectar si está usando zsh
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="${HOME}/.zshrc"
fi

echo "📦 Descargando Neovim Nightly..."
echo ""

# Descargar el binario
curl -LO "$NVIM_URL"

echo ""
echo "🗑️  Eliminando instalación anterior (si existe)..."
sudo rm -rf /opt/nvim /opt/nvim-linux-x86_64

echo ""
echo "📂 Extrayendo archivos en /opt..."
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

echo ""
echo "🔄 Renombrando directorio..."
sudo mv /opt/nvim-linux-x86_64 /opt/nvim

echo ""
echo "🧹 Limpiando archivo temporal..."
rm nvim-linux-x86_64.tar.gz

echo ""
echo "⚙️  Configurando PATH..."

# Verificar si ya existe la línea en el archivo de configuración
if grep -q 'export PATH="$PATH:/opt/nvim/bin"' "$SHELL_RC"; then
    echo "✅ PATH ya configurado en $SHELL_RC"
else
    echo "" >> "$SHELL_RC"
    echo "# Neovim" >> "$SHELL_RC"
    echo 'export PATH="$PATH:/opt/nvim/bin"' >> "$SHELL_RC"
    echo "✅ PATH agregado a $SHELL_RC"
fi

echo ""
echo "============================================"
echo "✅ Instalación completada exitosamente!"
echo "============================================"
echo ""
echo "📋 Próximos pasos:"
echo ""
echo "1. Recarga tu shell para aplicar los cambios:"
echo "   source $SHELL_RC"
echo ""
echo "2. Verifica la instalación:"
echo "   nvim --version"
echo ""
echo "3. Inicia Neovim:"
echo "   nvim"
echo ""
echo "============================================"
