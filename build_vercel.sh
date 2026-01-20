#!/bin/bash

echo "--------------------------------------------------------------------------------"
echo "🚀 Starting Flutter Web Build for Vercel"
echo "--------------------------------------------------------------------------------"

# 1. Instalar o Flutter
if [ -d "flutter" ]; then
    echo "ℹ️  Flutter directory already exists. Pulling latest..."
    cd flutter && git pull && cd ..
else
    echo "⬇️  Cloning Flutter SDK (stable channel)..."
    git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# 2. Configurar o PATH
echo "⚙️  Adding Flutter to PATH..."
export PATH="$PATH:`pwd`/flutter/bin"

# 3. Verificar instalação
echo "✅ Flutter version:"
flutter --version

# 4. Limpar e baixar dependências
echo "🧹 Cleaning and getting dependencies..."
# flutter clean # Opcional, economiza tempo não rodar no CI limpo, mas bom pra garantir
flutter pub get

# 5. Buildar o projeto
echo "🏗️  Building web application..."
flutter build web --release --no-tree-shake-icons

echo "--------------------------------------------------------------------------------"
echo "🎉 Build finished successfully!"
echo "--------------------------------------------------------------------------------"
