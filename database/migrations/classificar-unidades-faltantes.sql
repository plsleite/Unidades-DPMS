-- =====================================================
-- SCRIPT PARA CLASSIFICAR UNIDADES FALTANTES
-- =====================================================
-- Execute este script para classificar as unidades que estavam sem classificação

-- =====================================================
-- 1. CLASSIFICAR MUNDO NOVO COMO SEGUNDA ENTRÂNCIA
-- =====================================================

UPDATE unidades 
SET entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Segunda Entrância')
WHERE nome = 'MUNDO NOVO | FÓRUM';

-- =====================================================
-- 2. CLASSIFICAR ITAPORÃ COMO PRIMEIRA ENTRÂNCIA
-- =====================================================

UPDATE unidades 
SET entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Primeira Entrância')
WHERE nome = 'ITAPORÃ | FÓRUM';

-- =====================================================
-- 3. VERIFICAR CLASSIFICAÇÃO
-- =====================================================

-- Verificar se as unidades foram classificadas
SELECT 
    u.nome,
    e.nome as entrancia,
    CASE 
        WHEN u.entrancia_id IS NOT NULL THEN '✅ Classificada' 
        ELSE '❌ Não classificada' 
    END as status
FROM unidades u
LEFT JOIN entrancias e ON u.entrancia_id = e.id
WHERE u.nome IN ('MUNDO NOVO | FÓRUM', 'ITAPORÃ | FÓRUM')
ORDER BY u.nome;

-- Verificar resumo final
SELECT 
    e.nome as entrancia,
    COUNT(u.id) as total_unidades
FROM entrancias e
LEFT JOIN unidades u ON e.id = u.entrancia_id
GROUP BY e.id, e.nome, e.ordem
ORDER BY e.ordem;

-- Verificar se ainda há unidades não classificadas
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN '✅ Todas as unidades foram classificadas'
        ELSE '❌ Existem ' || COUNT(*) || ' unidades não classificadas'
    END as status
FROM unidades 
WHERE entrancia_id IS NULL;


