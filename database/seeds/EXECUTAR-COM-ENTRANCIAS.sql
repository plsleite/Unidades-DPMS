-- ==============================================
-- SCRIPT DE EXECUÇÃO COMPLETA COM ENTRÂNCIAS
-- ==============================================
-- 
-- INSTRUÇÕES:
-- 1. Execute este script no pgAdmin4
-- 2. Ele irá limpar o banco, inserir todos os dados e configurar entrâncias
-- 3. Aguarde a conclusão antes de reiniciar o servidor
--
-- ORDEM DE EXECUÇÃO:
-- 1. limpar-banco.sql
-- 2. insert-completo.sql (regionais + unidades)
-- 3. insert-defensorias-parte1.sql
-- 4. insert-defensorias-parte2.sql
-- 5. insert-defensorias-parte3.sql
-- 6. insert-defensorias-parte4.sql
-- 7. setup-entrancias-completo.sql (NOVO)
--
-- ==============================================

-- PASSO 1: LIMPAR BANCO DE DADOS
-- ==============================================
TRUNCATE TABLE orgaos CASCADE;
TRUNCATE TABLE unidades CASCADE;
TRUNCATE TABLE regionais CASCADE;
TRUNCATE TABLE entrancias CASCADE;

-- Reiniciar sequências (auto-increment)
ALTER SEQUENCE regionais_id_seq RESTART WITH 1;
ALTER SEQUENCE unidades_id_seq RESTART WITH 1;
ALTER SEQUENCE orgaos_id_seq RESTART WITH 1;
ALTER SEQUENCE entrancias_id_seq RESTART WITH 1;

-- Verificar se as tabelas estão vazias
SELECT 'Regionais:' as tabela, COUNT(*) as total FROM regionais
UNION ALL
SELECT 'Unidades:' as tabela, COUNT(*) as total FROM unidades
UNION ALL
SELECT 'Órgãos:' as tabela, COUNT(*) as total FROM orgaos
UNION ALL
SELECT 'Entrâncias:' as tabela, COUNT(*) as total FROM entrancias;

-- ==============================================
-- PASSO 2: INSERIR REGIONAIS E UNIDADES
-- ==============================================

-- Inserir regionais
INSERT INTO regionais (numero, nome) VALUES
(1, '1ª Regional de Campo Grande'),
(2, '2° Regional de Corumbá'),
(3, '3° Regional de Coxim'),
(4, '4° Regional de Dourados'),
(5, '5° Regional de Jardim'),
(6, '6° Regional de Nova Andradina'),
(7, '7° Regional de Paranaíba'),
(8, '8ª Regional de Ponta Porã'),
(9, '9° Regional de Naviraí'),
(10, '10ª Regional de Três Lagoas'),
(11, '11° Regional de Aquidauana'),
(12, '12° Regional de Chapadão do Sul'),
(13, '13° Regional de Maracaju');

-- NOTA: Para inserir todas as unidades e defensorias, execute os scripts individuais:
-- 1. insert-completo.sql (todas as unidades)
-- 2. insert-defensorias-parte1.sql até insert-defensorias-parte4.sql
-- 3. setup-entrancias-completo.sql (configurar entrâncias)

-- Verificar inserção parcial
SELECT 'Regionais inseridas:' as descricao, COUNT(*) as quantidade FROM regionais
UNION ALL
SELECT 'Unidades inseridas:' as descricao, COUNT(*) as quantidade FROM unidades;

-- ==============================================
-- INSTRUÇÕES PARA CONTINUAÇÃO
-- ==============================================

-- Para completar a configuração, execute os seguintes scripts em ordem:
-- 
-- 1. \i database/seeds/insert-completo.sql
-- 2. \i database/seeds/insert-defensorias-parte1.sql
-- 3. \i database/seeds/insert-defensorias-parte2.sql
-- 4. \i database/seeds/insert-defensorias-parte3.sql
-- 5. \i database/seeds/insert-defensorias-parte4.sql
-- 6. \i database/migrations/setup-entrancias-completo.sql
--
-- OU execute diretamente o script completo:
-- \i database/migrations/setup-entrancias-completo.sql


