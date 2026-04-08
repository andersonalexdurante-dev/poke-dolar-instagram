#!/bin/bash

# Build do binário nativo com Docker + GraalVM

set -e

IMAGE_NAME="poke-dolar:native"
CONTAINER_NAME="poke-dolar-builder"

echo "🚀 Iniciando build nativo com Docker + GraalVM..."

# Build da imagem Docker
docker build -t $IMAGE_NAME .

echo "✅ Build concluído!"
echo "📦 Imagem criada: $IMAGE_NAME"
echo ""
echo "Para executar:"
echo "  docker run -p 8080:8080 $IMAGE_NAME"
