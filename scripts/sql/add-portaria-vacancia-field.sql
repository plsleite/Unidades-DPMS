-- ==============================================
-- SCRIPT PARA ADICIONAR CAMPO PORTARIA_VACANCIA
-- ==============================================
-- 
-- Este script adiciona o campo portaria_vacancia na tabela orgaos
-- para registrar a portaria que ensejou a vacância da defensoria
--
-- INSTRUÇÕES:
-- 1. Execute este script no pgAdmin4
-- 2. O campo será adicionado como VARCHAR (pode ser NULL)
-- 3. Após a execução, reinicie o servidor
--
-- ==============================================

-- Adicionar coluna portaria_vacancia na tabela orgaos
ALTER TABLE orgaos 
ADD COLUMN portaria_vacancia VARCHAR(255);

-- Adicionar comentário para documentar o campo
COMMENT ON COLUMN orgaos.portaria_vacancia IS 'Portaria que ensejou a vacância da defensoria';

-- Verificar se a coluna foi adicionada corretamente
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default,
    character_maximum_length
FROM information_schema.columns 
WHERE table_name = 'orgaos' 
    AND column_name = 'portaria_vacancia';

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
