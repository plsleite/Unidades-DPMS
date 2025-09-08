-- Script para limpar o banco de dados
-- ATENÇÃO: Este script irá apagar TODOS os dados das tabelas

-- Limpar tabelas na ordem correta (respeitando foreign keys)
TRUNCATE TABLE orgaos CASCADE;
TRUNCATE TABLE unidades CASCADE;
TRUNCATE TABLE regionais CASCADE;

-- Reiniciar sequências (auto-increment)
ALTER SEQUENCE regionais_id_seq RESTART WITH 1;
ALTER SEQUENCE unidades_id_seq RESTART WITH 1;
ALTER SEQUENCE orgaos_id_seq RESTART WITH 1;

-- Verificar se as tabelas estão vazias
SELECT 'Regionais:' as tabela, COUNT(*) as total FROM regionais
UNION ALL
SELECT 'Unidades:' as tabela, COUNT(*) as total FROM unidades
UNION ALL
SELECT 'Órgãos:' as tabela, COUNT(*) as total FROM orgaos;
