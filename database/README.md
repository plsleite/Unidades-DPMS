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

### Scripts de Migração (NOVOS)
- `add-entrancias-table.sql` - Cria tabela de entrâncias e adiciona campo na tabela unidades
- `classify-comarcas-entrancias.sql` - Classifica comarcas existentes por entrância
- `setup-entrancias-completo.sql` - Script completo de configuração das entrâncias
- `test-entrancias-classification.sql` - Script de teste para verificar classificação

### Scripts de Verificação
- `verificar-dados.sql` - Script para verificar se os dados foram inseridos corretamente

## Como Usar

### Configuração Inicial (Recomendado)
1. **Executar script completo com entrâncias**:
   ```sql
   \i database/seeds/EXECUTAR-COM-ENTRANCIAS.sql
   ```

2. **Inserir dados completos**:
   ```sql
   \i database/seeds/insert-completo.sql
   \i database/seeds/insert-defensorias-parte1.sql
   \i database/seeds/insert-defensorias-parte2.sql
   \i database/seeds/insert-defensorias-parte3.sql
   \i database/seeds/insert-defensorias-parte4.sql
   ```

3. **Configurar entrâncias**:
   ```sql
   \i database/migrations/setup-entrancias-completo.sql
   ```

4. **Testar classificação**:
   ```sql
   \i database/migrations/test-entrancias-classification.sql
   ```

### Configuração Manual (Alternativa)
1. **Limpar o banco** (se necessário):
   ```sql
   \i database/maintenance/limpar-banco.sql
   ```

2. **Inserir dados completos**:
   ```sql
   \i database/seeds/insert-dados-limpo.sql
   ```

3. **Configurar entrâncias**:
   ```sql
   \i database/migrations/setup-entrancias-completo.sql
   ```

## Dados Inseridos

- **13 Regionais** da Defensoria Pública
- **65 Unidades** em todo o estado
- **249 Defensorias** distribuídas pelas unidades
- **4 Entrâncias** para classificação das comarcas e defensorias

## Classificação por Entrância

### Entrância Especial (3 comarcas)
- Campo Grande (unidades de primeira instância)
- Corumbá
- Dourados (todas as unidades)
- Três Lagoas

### Segunda Entrância (30 comarcas)
- Amambai, Anastácio, Aparecida do Taboado, Aquidauana, Bataguassu, Bela Vista, Bonito, Caarapó, Camapuã, Cassilândia, Chapadão do Sul, Costa Rica, Coxim, Fátima do Sul, Iguatemi, Ivinhema, Jardim, Maracaju, Miranda, Naviraí, Nova Alvorada do Sul, Nova Andradina, Paranaíba, Ponta Porã, Ribas do Rio Pardo, Rio Brilhante, Rio Verde de Mato Grosso, São Gabriel do Oeste, Sidrolândia, Terenos

### Primeira Entrância (19 comarcas)
- Água Clara, Anaurilândia, Angélica, Bandeirantes, Batayporã, Brasilândia, Coronel Sapucaia, Deodápolis, Dois Irmãos do Buriti, Eldorado, Glória de Dourados, Inocência, Itaquiraí, Nioaque, Pedro Gomes, Porto Murtinho, Rio Negro, Sete Quedas, Sonora

### Segunda Instância (1 unidade)
- Campo Grande | 2ª Instância

## Observações

- Todos os scripts foram testados e funcionam corretamente
- Os dados estão organizados por regional e unidade
- Cada defensoria possui informações sobre titular, substituto e status de vaga
- **NOVO**: Comarcas classificadas por entrância para ordem de vacância
- **NOVO**: Campo `data_vacancia` para controle temporal das vagas
