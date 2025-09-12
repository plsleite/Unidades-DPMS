# Domain Entities

Este diretório contém as entidades de domínio do sistema, representando os conceitos centrais do negócio da Defensoria Pública MS.

## Entidades Principais

### Unidade
Representa uma unidade da Defensoria Pública (comarca, núcleo, etc.)

**Propriedades:**
- id: Identificador único
- nome: Nome da unidade
- endereco: Endereço físico
- telefone: Telefone de contato
- regionalId: Referência à regional
- coordenador: Nome do coordenador
- emailCoordenador: Email do coordenador
- supervisor: Nome do supervisor
- emailSupervisor: Email do supervisor

### Defensoria (Orgão)
Representa uma defensoria específica dentro de uma unidade

**Propriedades:**
- id: Identificador único
- nome: Nome da defensoria
- unidadeId: Referência à unidade
- titularNome: Nome do titular
- titularEmail: Email do titular
- titularAfastado: Se o titular está afastado
- vaga: Se a defensoria está vaga
- dataVacancia: Data da vacância
- portariaVacancia: Portaria que ensejou a vacância
- substitutoNome: Nome do substituto
- substitutoEmail: Email do substituto

### Regional
Representa uma regional da Defensoria Pública

**Propriedades:**
- id: Identificador único
- nome: Nome da regional
- numero: Número da regional

### Coordenacao
Representa uma coordenação dentro de uma unidade

**Propriedades:**
- id: Identificador único
- unidadeId: Referência à unidade
- tipoCoordenacao: Tipo (ADMINISTRATIVA, CIVEL, CRIMINAL)
- nomeCoordenador: Nome do coordenador
- emailCoordenador: Email do coordenador
- ativo: Se está ativa

## Princípios

1. **Encapsulamento**: Entidades encapsulam suas regras de negócio
2. **Imutabilidade**: Propriedades são imutáveis após criação
3. **Validação**: Validações de domínio ficam nas entidades
4. **Independência**: Não dependem de frameworks ou infraestrutura
