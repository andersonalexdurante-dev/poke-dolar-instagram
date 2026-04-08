# ---------- Stage 1: Build nativo ----------
FROM ghcr.io/graalvm/native-image-community:21 AS builder

WORKDIR /app

# Instalar dos2unix para converter line endings do Windows
RUN microdnf install -y dos2unix

# Copiar arquivos de build (melhor cache)
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Baixar dependências
RUN dos2unix mvnw \
    && chmod +x mvnw \
    && ./mvnw -B -q -DskipTests dependency:go-offline

# Copiar código
COPY src src

# Gerar binário nativo
RUN ./mvnw -B clean package -Dnative -DskipTests


# ---------- Stage 2: Extrair artefatos ----------
FROM alpine:latest

WORKDIR /app

# Copiar target do builder
COPY --from=builder /app/target ./target