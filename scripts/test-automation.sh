#!/bin/bash

# Script de automação de testes
# Executa testes automaticamente em diferentes cenários

set -e  # Parar em caso de erro

echo "🧪 Iniciando automação de testes..."

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
    error "Execute este script na raiz do projeto (onde está o package.json)"
    exit 1
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

log "Verificando dependências..."

# Instalar dependências se necessário
if [ ! -d "node_modules" ]; then
    log "Instalando dependências..."
    npm install
fi

# Função para executar testes
run_tests() {
    local test_type=$1
    local test_command=$2
    
    log "Executando $test_type..."
    
    if eval "$test_command"; then
        success "$test_type executado com sucesso!"
        return 0
    else
        error "$test_type falhou!"
        return 1
    fi
}

# Função para executar testes com coverage
run_tests_with_coverage() {
    log "Executando testes com coverage..."
    
    if npm run test:coverage; then
        success "Testes com coverage executados com sucesso!"
        
        # Verificar se o arquivo de coverage foi gerado
        if [ -f "coverage/lcov.info" ]; then
            log "Arquivo de coverage gerado: coverage/lcov.info"
        fi
        
        return 0
    else
        error "Testes com coverage falharam!"
        return 1
    fi
}

# Função para executar testes em watch mode
run_tests_watch() {
    log "Iniciando testes em watch mode..."
    log "Pressione Ctrl+C para parar"
    
    npm run test:watch
}

# Função para executar testes específicos
run_specific_tests() {
    local test_pattern=$1
    
    if [ -z "$test_pattern" ]; then
        error "Padrão de teste não especificado"
        return 1
    fi
    
    log "Executando testes que correspondem ao padrão: $test_pattern"
    
    if npm test -- --testNamePattern="$test_pattern"; then
        success "Testes específicos executados com sucesso!"
        return 0
    else
        error "Testes específicos falharam!"
        return 1
    fi
}

# Função para executar testes de integração
run_integration_tests() {
    log "Executando testes de integração..."
    
    if npm test tests/integration/; then
        success "Testes de integração executados com sucesso!"
        return 0
    else
        error "Testes de integração falharam!"
        return 1
    fi
}

# Função para executar testes unitários
run_unit_tests() {
    log "Executando testes unitários..."
    
    if npm test tests/unit/; then
        success "Testes unitários executados com sucesso!"
        return 0
    else
        error "Testes unitários falharam!"
        return 1
    fi
}

# Função para executar linting
run_linting() {
    log "Executando linting..."
    
    # Verificar se eslint está instalado
    if npm list eslint &> /dev/null; then
        if npx eslint src/ tests/; then
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

# Função para executar todos os testes
run_all_tests() {
    log "Executando todos os testes..."
    
    local exit_code=0
    
    # Testes unitários
    if ! run_unit_tests; then
        exit_code=1
    fi
    
    # Testes de integração
    if ! run_integration_tests; then
        exit_code=1
    fi
    
    # Linting
    if ! run_linting; then
        exit_code=1
    fi
    
    if [ $exit_code -eq 0 ]; then
        success "Todos os testes executados com sucesso!"
    else
        error "Alguns testes falharam!"
    fi
    
    return $exit_code
}

# Função para mostrar ajuda
show_help() {
    echo "🧪 Script de Automação de Testes"
    echo ""
    echo "Uso: $0 [comando] [opções]"
    echo ""
    echo "Comandos:"
    echo "  all                    Executar todos os testes"
    echo "  unit                   Executar apenas testes unitários"
    echo "  integration            Executar apenas testes de integração"
    echo "  coverage               Executar testes com coverage"
    echo "  watch                  Executar testes em watch mode"
    echo "  specific <padrão>      Executar testes específicos"
    echo "  lint                   Executar apenas linting"
    echo "  help                   Mostrar esta ajuda"
    echo ""
    echo "Exemplos:"
    echo "  $0 all                 # Executar todos os testes"
    echo "  $0 unit                # Apenas testes unitários"
    echo "  $0 coverage            # Testes com coverage"
    echo "  $0 watch               # Watch mode"
    echo "  $0 specific 'API'      # Testes que contenham 'API'"
    echo ""
}

# Função principal
main() {
    local command=${1:-"all"}
    
    case $command in
        "all")
            run_all_tests
            ;;
        "unit")
            run_unit_tests
            ;;
        "integration")
            run_integration_tests
            ;;
        "coverage")
            run_tests_with_coverage
            ;;
        "watch")
            run_tests_watch
            ;;
        "specific")
            run_specific_tests "$2"
            ;;
        "lint")
            run_linting
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            error "Comando desconhecido: $command"
            show_help
            exit 1
            ;;
    esac
}

# Executar função principal
main "$@"
