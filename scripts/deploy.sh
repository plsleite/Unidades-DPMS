#!/bin/bash

# Script de Deploy para Produção
# Uso: ./scripts/deploy.sh [environment]

set -e

ENVIRONMENT=${1:-production}
echo "🚀 Iniciando deploy para ambiente: $ENVIRONMENT"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para log
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

warn() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

# Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    error "Docker não está instalado"
fi

if ! command -v docker-compose &> /dev/null; then
    error "Docker Compose não está instalado"
fi

# Parar containers existentes
log "Parando containers existentes..."
docker-compose down

# Fazer backup do banco (se existir)
if [ -d "data/postgres" ]; then
    log "Fazendo backup do banco de dados..."
    docker-compose exec -T db pg_dump -U postgres defensoria_ms > backup_$(date +%Y%m%d_%H%M%S).sql
fi

# Pull das imagens mais recentes
log "Atualizando imagens Docker..."
docker-compose pull

# Build da aplicação
log "Fazendo build da aplicação..."
docker-compose build --no-cache

# Iniciar serviços
log "Iniciando serviços..."
docker-compose up -d

# Aguardar banco estar pronto
log "Aguardando banco de dados..."
sleep 10

# Executar migrações
log "Executando migrações do banco..."
docker-compose exec -T db psql -U postgres -d defensoria_ms -f /docker-entrypoint-initdb.d/migrations/setup-coordenacoes.sql
docker-compose exec -T db psql -U postgres -d defensoria_ms -f /docker-entrypoint-initdb.d/migrations/setup-admin.sql

# Executar seeds
log "Executando seeds do banco..."
docker-compose exec -T db psql -U postgres -d defensoria_ms -f /docker-entrypoint-initdb.d/seeds/insert-completo.sql

# Verificar saúde dos serviços
log "Verificando saúde dos serviços..."
sleep 5

if curl -f http://localhost:3000/api/test > /dev/null 2>&1; then
    log "✅ Aplicação está funcionando!"
else
    error "❌ Aplicação não está respondendo"
fi

# Mostrar status dos containers
log "Status dos containers:"
docker-compose ps

log "🎉 Deploy concluído com sucesso!"
log "Aplicação disponível em: http://localhost:3000"
