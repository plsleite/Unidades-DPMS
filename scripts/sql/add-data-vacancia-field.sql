-- ==============================================
-- SCRIPT PARA ADICIONAR CAMPO DATA_VACANCIA
-- ==============================================
-- 
-- Este script adiciona o campo data_vacancia na tabela orgaos
-- para registrar quando uma defensoria ficou vacante
--
-- INSTRUÇÕES:
-- 1. Execute este script no pgAdmin4
-- 2. O campo será adicionado como DATE (pode ser NULL)
-- 3. Após a execução, reinicie o servidor
--
-- ==============================================

-- Adicionar coluna data_vacancia na tabela orgaos
ALTER TABLE orgaos 
ADD COLUMN data_vacancia DATE;

-- Adicionar comentário para documentar o campo
COMMENT ON COLUMN orgaos.data_vacancia IS 'Data em que a defensoria ficou vacante';

-- Verificar se a coluna foi adicionada corretamente
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'orgaos' 
    AND column_name = 'data_vacancia';

-- Mostrar estrutura atualizada da tabela
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default,
    character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'orgaos' 
ORDER BY ordinal_position;
