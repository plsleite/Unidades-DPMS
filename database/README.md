# Scripts SQL - Defensoria Pública MS

Esta pasta contém todos os scripts SQL utilizados no projeto da Defensoria Pública de Mato Grosso do Sul.

## Estrutura dos Arquivos

### Scripts de Limpeza
- `limpar-banco.sql` - Script para limpar todas as tabelas do banco

### Scripts de Inserção de Dados
- `insert-dados-limpo.sql` - Script principal com todas as unidades e defensorias
- `insert-completo.sql` - Script completo de inserção
- `insert-defensorias.sql` - Script apenas com defensorias
- `insert-defensorias-parte1.sql` - Primeira parte das defensorias
- `insert-defensorias-parte2.sql` - Segunda parte das defensorias
- `insert-defensorias-parte3.sql` - Terceira parte das defensorias
- `insert-defensorias-parte4.sql` - Quarta parte das defensorias

### Scripts de Verificação
- `verificar-dados.sql` - Script para verificar se os dados foram inseridos corretamente

## Como Usar

1. **Limpar o banco** (se necessário):
   ```sql
   \i scripts/sql/limpar-banco.sql
   ```

2. **Inserir dados completos**:
   ```sql
   \i scripts/sql/insert-dados-limpo.sql
   ```

3. **Verificar dados**:
   ```sql
   \i scripts/sql/verificar-dados.sql
   ```

## Dados Inseridos

- **13 Regionais** da Defensoria Pública
- **65 Unidades** em todo o estado
- **249 Defensorias** distribuídas pelas unidades

## Observações

- Todos os scripts foram testados e funcionam corretamente
- Os dados estão organizados por regional e unidade
- Cada defensoria possui informações sobre titular, substituto e status de vaga
