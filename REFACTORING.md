# Plano de Refatoração - Clean Architecture

## Visão Geral

Este documento descreve o plano de refatoração do sistema Defensoria Pública MS para implementar Clean Architecture, reduzindo acoplamento e melhorando manutenibilidade.

## Estrutura da Branch

```
feature/clean-architecture-refactor (branch principal)
├── feature/domain-extraction (Fase 1)
├── feature/use-cases-implementation (Fase 2)
├── feature/infrastructure-layer (Fase 3)
└── feature/ui-modernization (Fase 4)
```

## Fases de Refatoração

### Fase 1: Extração de Domínio (3 semanas)
**Branch:** `feature/domain-extraction`

**Objetivos:**
- Criar entidades de domínio (Unidade, Defensoria, Regional, Coordenacao)
- Implementar value objects (Email, Telefone, Endereco)
- Definir interfaces de repositório
- Criar testes unitários para entidades

**Entregáveis:**
- [ ] Entidade Unidade com validações
- [ ] Entidade Defensoria com validações
- [ ] Entidade Regional com validações
- [ ] Entidade Coordenacao com validações
- [ ] Value Objects (Email, Telefone, Endereco)
- [ ] Interfaces de repositório
- [ ] Testes unitários (cobertura > 80%)

### Fase 2: Casos de Uso (4 semanas)
**Branch:** `feature/use-cases-implementation`

**Objetivos:**
- Extrair lógica de negócio para use cases
- Implementar DTOs para comunicação
- Criar controllers limpos
- Refatorar endpoints um por vez

**Entregáveis:**
- [ ] CreateUnidadeUseCase
- [ ] UpdateUnidadeUseCase
- [ ] DeleteUnidadeUseCase
- [ ] ListUnidadesUseCase
- [ ] CreateDefensoriaUseCase
- [ ] UpdateDefensoriaUseCase
- [ ] DeleteDefensoriaUseCase
- [ ] ListDefensoriasUseCase
- [ ] DTOs para todas as operações
- [ ] Controllers refatorados
- [ ] Testes de casos de uso

### Fase 3: Infraestrutura (3 semanas)
**Branch:** `feature/infrastructure-layer`

**Objetivos:**
- Implementar repositórios concretos
- Configurar injeção de dependências
- Migrar logging para infraestrutura
- Isolar acesso a dados

**Entregáveis:**
- [ ] UnidadeRepository (PostgreSQL)
- [ ] DefensoriaRepository (PostgreSQL)
- [ ] RegionalRepository (PostgreSQL)
- [ ] CoordenacaoRepository (PostgreSQL)
- [ ] Container de injeção de dependências
- [ ] Logger refatorado
- [ ] Testes de repositórios

### Fase 4: UI Moderna (4 semanas)
**Branch:** `feature/ui-modernization`

**Objetivos:**
- Componentizar frontend
- Implementar state management
- Separar API clients
- Refatorar interface gradualmente

**Entregáveis:**
- [ ] Componentes React/Vue
- [ ] State management (Redux/Vuex)
- [ ] API clients separados
- [ ] Páginas refatoradas
- [ ] Testes de componentes

## Feature Flags

O sistema usa feature flags para permitir transição gradual:

```javascript
const FEATURES = {
  NEW_UNIT_CRUD: process.env.FEATURE_NEW_UNIT_CRUD === 'true',
  NEW_DEFENSORIA_CRUD: process.env.FEATURE_NEW_DEFENSORIA_CRUD === 'true',
  NEW_REGIONAL_CRUD: process.env.FEATURE_NEW_REGIONAL_CRUD === 'true',
  NEW_AUTH_FLOW: process.env.FEATURE_NEW_AUTH_FLOW === 'true'
};
```

## Critérios de Sucesso

### Métricas Técnicas
- **Acoplamento**: Fan-out médio < 2.0
- **Complexidade**: Ciclomática < 5 por método
- **Cobertura**: Testes > 80%
- **Duplicação**: Código duplicado < 5%
- **Tamanho**: Arquivos < 200 linhas

### Métricas de Negócio
- **Performance**: Tempo de resposta < 200ms
- **Disponibilidade**: Uptime > 99.9%
- **Manutenibilidade**: Tempo de desenvolvimento de features -50%

## Riscos e Mitigações

### Riscos Identificados
1. **Degradação de Performance**: Overhead de abstrações
2. **Bugs de Regressão**: Mudanças em código crítico
3. **Tempo de Desenvolvimento**: Complexidade inicial maior

### Mitigações
1. **Profiling Contínuo**: Monitoramento de performance
2. **Testes de Regressão**: Suite completa de testes
3. **Feature Flags**: Rollback rápido se necessário
4. **Code Review**: Revisão obrigatória de PRs

## Cronograma

| Fase | Duração | Início | Fim | Responsável |
|------|---------|--------|-----|-------------|
| Preparação | 2 semanas | Semana 1 | Semana 2 | Equipe |
| Domínio | 3 semanas | Semana 3 | Semana 5 | Dev 1 |
| Casos de Uso | 4 semanas | Semana 6 | Semana 9 | Dev 1 + Dev 2 |
| Infraestrutura | 3 semanas | Semana 10 | Semana 12 | Dev 2 |
| UI | 4 semanas | Semana 13 | Semana 16 | Dev 1 |

**Total:** 16 semanas (4 meses)

## Próximos Passos

1. ✅ Criar branch principal `feature/clean-architecture-refactor`
2. ✅ Configurar estrutura de pastas
3. ✅ Criar documentação inicial
4. 🔄 Iniciar Fase 1: Extração de Domínio
5. ⏳ Implementar primeira entidade (Unidade)
6. ⏳ Criar testes unitários
7. ⏳ Configurar CI/CD para nova estrutura

## Comandos Úteis

```bash
# Criar sub-branch para fase
git checkout feature/clean-architecture-refactor
git checkout -b feature/domain-extraction

# Executar testes
npm run test:unit
npm run test:integration
npm run test:coverage

# Verificar cobertura
npm run test:coverage -- --coverageReporters=text

# Executar linting
npm run lint
npm run lint:fix
```
