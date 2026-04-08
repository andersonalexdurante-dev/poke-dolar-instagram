@echo off
REM Build do binário nativo com Docker + GraalVM

setlocal enabledelayedexpansion

set IMAGE_NAME=poke-dolar:native
set CONTAINER_NAME=poke-dolar-builder

echo 🚀 Iniciando build nativo com Docker + GraalVM...

REM Build da imagem Docker
docker build -t !IMAGE_NAME! .

if errorlevel 1 (
    echo ❌ Erro durante o build
    exit /b 1
)

echo ✅ Build concluído!

REM Limpar container anterior se existir
docker rm !CONTAINER_NAME! >nul 2>&1

REM Criar container temporário para extrair os artefatos
docker create --name !CONTAINER_NAME! !IMAGE_NAME! >nul

REM Copiar target para a máquina local
echo 📦 Extraindo artefatos do target...
docker cp !CONTAINER_NAME!:/app/target ./target

REM Limpar container temporário
docker rm !CONTAINER_NAME! >nul

echo ✅ Arquivos gerados em ./target
echo.
echo Para executar:
echo   docker run -p 8080:8080 !IMAGE_NAME!
