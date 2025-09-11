#!/bin/bash

# Script para executar testes em background (daemon)
# Monitora mudanças nos arquivos e executa testes automaticamente

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para log
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Verificar se estamos no diretório correto
if [ ! -f "package.json" ]; then
    error "Execute este script na raiz do projeto"
    exit 1
fi

# Verificar se fswatch está instalado (para monitoramento de arquivos)
if ! command -v fswatch &> /dev/null; then
    warning "fswatch não está instalado. Instalando via Homebrew..."
    
    if command -v brew &> /dev/null; then
        brew install fswatch
    else
        error "Homebrew não está instalado. Instale fswatch manualmente:"
        echo "  macOS: brew install fswatch"
        echo "  Ubuntu: sudo apt-get install fswatch"
        echo "  CentOS: sudo yum install fswatch"
        exit 1
    fi
fi

# Verificar se Node.js está instalado
if ! command -v node &> /dev/null; then
    error "Node.js não está instalado"
    exit 1
fi

# Verificar se npm está instalado
if ! command -v npm &> /dev/null; then
    error "npm não está instalado"
    exit 1
fi

# Instalar dependências se necessário
if [ ! -d "node_modules" ]; then
    log "Instalando dependências..."
    npm install
fi

# Função para executar testes
run_tests() {
    local test_type=$1
    
    log "Executando $test_type..."
    
    if npm test; then
        success "$test_type executado com sucesso!"
        return 0
    else
        error "$test_type falhou!"
        return 1
    fi
}

# Função para executar testes específicos
run_specific_tests() {
    local test_pattern=$1
    
    if [ -z "$test_pattern" ]; then
        run_tests "todos os testes"
    else
        log "Executando testes que correspondem ao padrão: $test_pattern"
        
        if npm test -- --testNamePattern="$test_pattern"; then
            success "Testes específicos executados com sucesso!"
            return 0
        else
            error "Testes específicos falharam!"
            return 1
        fi
    fi
}

# Função para executar linting
run_linting() {
    log "Executando linting..."
    
    if npm list eslint &> /dev/null; then
        if npx eslint src/ tests/ --quiet; then
            success "Linting executado com sucesso!"
            return 0
        else
            error "Linting falhou!"
            return 1
        fi
    else
        warning "ESLint não está instalado, pulando linting..."
        return 0
    fi
}

# Função para processar mudanças de arquivo
process_file_change() {
    local file_path=$1
    
    # Verificar se é um arquivo relevante
    if [[ "$file_path" =~ \.(js|ts|json)$ ]] && [[ ! "$file_path" =~ package-lock\.json$ ]]; then
        log "Arquivo modificado: $file_path"
        
        # Aguardar um pouco para evitar execuções múltiplas
        sleep 1
        
        # Executar testes
        if run_specific_tests; then
            # Executar linting se disponível
            run_linting
        fi
    fi
}

# Função para mostrar ajuda
show_help() {
    echo "🧪 Test Daemon - Execução Automática de Testes"
    echo ""
    echo "Uso: $0 [opções]"
    echo ""
    echo "Opções:"
    echo "  -w, --watch <diretório>    Monitorar diretório específico (padrão: src/)"
    echo "  -t, --test <padrão>        Executar apenas testes específicos"
    echo "  -l, --lint                 Executar linting também"
    echo "  -h, --help                 Mostrar esta ajuda"
    echo ""
    echo "Exemplos:"
    echo "  $0                         # Monitorar src/ e executar todos os testes"
    echo "  $0 -w tests/               # Monitorar tests/ e executar todos os testes"
    echo "  $0 -t 'API'                # Monitorar src/ e executar testes com 'API'"
    echo "  $0 -l                      # Monitorar src/ e executar testes + linting"
    echo ""
    echo "Pressione Ctrl+C para parar o daemon"
    echo ""
}

# Função principal
main() {
    local watch_dir="src/"
    local test_pattern=""
    local run_lint=false
    
    # Processar argumentos
    while [[ $# -gt 0 ]]; do
        case $1 in
            -w|--watch)
                watch_dir="$2"
                shift 2
                ;;
            -t|--test)
                test_pattern="$2"
                shift 2
                ;;
            -l|--lint)
                run_lint=true
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                error "Opção desconhecida: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # Verificar se o diretório existe
    if [ ! -d "$watch_dir" ]; then
        error "Diretório não encontrado: $watch_dir"
        exit 1
    fi
    
    log "Iniciando Test Daemon..."
    log "Monitorando diretório: $watch_dir"
    
    if [ -n "$test_pattern" ]; then
        log "Padrão de teste: $test_pattern"
    else
        log "Executando todos os testes"
    fi
    
    if [ "$run_lint" = true ]; then
        log "Linting habilitado"
    fi
    
    echo ""
    success "✅ Test Daemon iniciado! Pressione Ctrl+C para parar"
    echo ""
    
    # Executar testes iniciais
    log "Executando testes iniciais..."
    if [ -n "$test_pattern" ]; then
        run_specific_tests "$test_pattern"
    else
        run_tests "todos os testes"
    fi
    
    if [ "$run_lint" = true ]; then
        run_linting
    fi
    
    echo ""
    log "Aguardando mudanças em $watch_dir..."
    echo ""
    
    # Monitorar mudanças de arquivo
    fswatch -o "$watch_dir" | while read; do
        # Processar mudanças
        for file in $(find "$watch_dir" -name "*.js" -o -name "*.ts" -o -name "*.json" | head -10); do
            if [ -f "$file" ]; then
                process_file_change "$file"
            fi
        done
    done
}

# Capturar Ctrl+C
trap 'echo ""; log "Parando Test Daemon..."; exit 0' INT

# Executar função principal
main "$@"
