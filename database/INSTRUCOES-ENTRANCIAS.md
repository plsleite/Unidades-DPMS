# Instruções para Configuração das Entrâncias

## Resumo da Implementação

Foi implementada a estrutura de banco de dados para classificar as comarcas por entrância, conforme solicitado. A classificação segue a seguinte distribuição:

- **Entrância Especial**: 3 comarcas (Campo Grande - 1ª instância, Corumbá, Dourados, Três Lagoas)
- **Segunda Entrância**: 30 comarcas
- **Primeira Entrância**: 19 comarcas
- **Segunda Instância**: 1 unidade (Campo Grande | 2ª Instância)

## Scripts Criados

### 1. Estrutura do Banco
- `add-entrancias-table.sql` - Cria tabela de entrâncias e adiciona campo na tabela unidades
- `classify-comarcas-entrancias.sql` - Classifica comarcas existentes por entrância
- `setup-entrancias-completo.sql` - Script completo que executa toda a configuração

### 2. Testes e Validação
- `test-entrancias-classification.sql` - Script de teste para verificar se a classificação foi realizada corretamente

### 3. Execução
- `EXECUTAR-COM-ENTRANCIAS.sql` - Script de execução que inclui a configuração das entrâncias

## Como Executar

### Opção 1: Execução Completa (Recomendada)
```sql
-- Execute no pgAdmin4 conectado ao banco 'defensoria_ms'
\i database/migrations/setup-entrancias-completo.sql
```

### Opção 2: Execução por Partes
```sql
-- 1. Criar estrutura
\i database/migrations/add-entrancias-table.sql

-- 2. Classificar comarcas
\i database/migrations/classify-comarcas-entrancias.sql

-- 3. Testar classificação
\i database/migrations/test-entrancias-classification.sql
```

## Verificação da Classificação

Após executar os scripts, você pode verificar se a classificação foi realizada corretamente executando:

```sql
-- Verificar resumo por entrância
SELECT 
    e.nome as entrancia,
    COUNT(u.id) as total_unidades
FROM entrancias e
LEFT JOIN unidades u ON e.id = u.entrancia_id
GROUP BY e.id, e.nome, e.ordem
ORDER BY e.ordem;

-- Verificar unidades não classificadas
SELECT 
    u.nome,
    u.entrancia_id
FROM unidades u
WHERE u.entrancia_id IS NULL;
```

## Estrutura Criada

### Tabela `entrancias`
```sql
CREATE TABLE entrancias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    ordem INTEGER NOT NULL UNIQUE,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Campo adicionado na tabela `unidades`
```sql
ALTER TABLE unidades 
ADD COLUMN entrancia_id INTEGER REFERENCES entrancias(id);
```

## Próximos Passos

Com a estrutura do banco configurada, os próximos passos serão:

1. **Criar endpoint da API** para listar ordem de vacância por entrância
2. **Implementar interface** na página principal para exibir a ordem de vacância
3. **Adicionar funcionalidades** de ordenação e filtros

## Observações Importantes

- A classificação foi feita baseada nos nomes das unidades existentes
- Todas as unidades de Campo Grande foram classificadas como Entrância Especial
- Todas as unidades de Dourados foram classificadas como Entrância Especial
- O campo `data_vacancia` já existe na tabela `orgaos` e será utilizado para a ordenação
- A classificação é baseada na comarca (parte antes do "|" no nome da unidade)

## Suporte

Se houver problemas na execução dos scripts, verifique:

1. Se o banco de dados está acessível
2. Se as tabelas `regionais`, `unidades` e `orgaos` existem
3. Se há dados nas tabelas antes de executar a classificação
4. Se as permissões de usuário permitem criar tabelas e alterar estruturas
