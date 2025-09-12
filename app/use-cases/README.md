# Use Cases

Este diretório contém os casos de uso da aplicação, implementando a lógica de negócio específica de cada operação.

## Casos de Uso por Entidade

### Unidade Use Cases

#### CreateUnidadeUseCase
Cria uma nova unidade com validações de negócio

**Entrada:**
- nome: string
- endereco: string
- telefone: string
- regionalId: number
- coordenador?: string
- emailCoordenador?: string
- supervisor?: string
- emailSupervisor?: string

**Saída:**
- Unidade criada

**Regras de Negócio:**
- Nome e endereço são obrigatórios
- Telefone deve ter formato válido
- Regional deve existir
- Email deve ter formato válido se fornecido

#### UpdateUnidadeUseCase
Atualiza uma unidade existente

**Entrada:**
- id: number
- dados de atualização

**Saída:**
- Unidade atualizada

**Regras de Negócio:**
- Unidade deve existir
- Validações similares ao CreateUnidadeUseCase

#### DeleteUnidadeUseCase
Remove uma unidade

**Entrada:**
- id: number

**Saída:**
- Confirmação de exclusão

**Regras de Negócio:**
- Unidade não pode ter defensorias vinculadas
- Unidade deve existir

#### ListUnidadesUseCase
Lista unidades com filtros opcionais

**Entrada:**
- regionalId?: number
- search?: string

**Saída:**
- Array de Unidades

### Defensoria Use Cases

#### CreateDefensoriaUseCase
Cria uma nova defensoria

#### UpdateDefensoriaUseCase
Atualiza uma defensoria existente

#### DeleteDefensoriaUseCase
Remove uma defensoria

#### ListDefensoriasUseCase
Lista defensorias com filtros

#### MarcarDefensoriaVagaUseCase
Marca uma defensoria como vaga

#### DesignarSubstitutoUseCase
Designa um substituto para uma defensoria

## Princípios

1. **Single Responsibility**: Cada use case tem uma responsabilidade específica
2. **Independência**: Não dependem de frameworks ou UI
3. **Testabilidade**: Fáceis de testar isoladamente
4. **Reutilização**: Podem ser usados por diferentes interfaces (REST, GraphQL, CLI)
5. **Validação**: Contêm validações de negócio específicas
