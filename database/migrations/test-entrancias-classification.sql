-- =====================================================
-- SCRIPT DE TESTE DA CLASSIFICAÇÃO DAS ENTRÂNCIAS
-- =====================================================
-- Execute este script APÓS executar o setup-entrancias-completo.sql
-- para verificar se a classificação foi realizada corretamente

-- =====================================================
-- 1. VERIFICAR ESTRUTURA DAS TABELAS
-- =====================================================

-- Verificar se a tabela entrancias foi criada
SELECT 
    'Tabela entrancias:' as verificacao,
    CASE 
        WHEN EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'entrancias') 
        THEN '✅ Criada' 
        ELSE '❌ Não encontrada' 
    END as status;

-- Verificar se o campo entrancia_id foi adicionado na tabela unidades
SELECT 
    'Campo entrancia_id:' as verificacao,
    CASE 
        WHEN EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'unidades' AND column_name = 'entrancia_id') 
        THEN '✅ Adicionado' 
        ELSE '❌ Não encontrado' 
    END as status;

-- =====================================================
-- 2. VERIFICAR DADOS DAS ENTRÂNCIAS
-- =====================================================

-- Mostrar entrâncias cadastradas
SELECT 
    id,
    nome,
    ordem,
    descricao
FROM entrancias 
ORDER BY ordem;

-- =====================================================
-- 3. VERIFICAR CLASSIFICAÇÃO DAS UNIDADES
-- =====================================================

-- Contar unidades por entrância
SELECT 
    COALESCE(e.nome, 'Não Classificada') as entrancia,
    COUNT(u.id) as total_unidades,
    ROUND((COUNT(u.id) * 100.0 / (SELECT COUNT(*) FROM unidades)), 2) as percentual
FROM unidades u
LEFT JOIN entrancias e ON u.entrancia_id = e.id
GROUP BY e.id, e.nome, e.ordem
ORDER BY COALESCE(e.ordem, 999);

-- =====================================================
-- 4. VERIFICAR UNIDADES NÃO CLASSIFICADAS
-- =====================================================

-- Mostrar unidades que não foram classificadas
SELECT 
    u.id,
    u.nome,
    u.entrancia_id
FROM unidades u
WHERE u.entrancia_id IS NULL
ORDER BY u.nome;

-- =====================================================
-- 5. VERIFICAR CLASSIFICAÇÃO ESPECÍFICA POR ENTRÂNCIA
-- =====================================================

-- Entrância Especial
SELECT 
    'Entrância Especial' as entrancia,
    u.nome as unidade,
    CASE 
        WHEN u.entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Entrância Especial') 
        THEN '✅ Classificada' 
        ELSE '❌ Não classificada' 
    END as status
FROM unidades u
WHERE u.nome IN (
    'CAMPO GRANDE | AFONSO PENA/NUDEM',
    'CAMPO GRANDE | AFONSO PENA/NUDECA',
    'CAMPO GRANDE | BARÃO DE MELGAÇO/NAS',
    'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN',
    'CAMPO GRANDE | BELMAR FIDALGO/NUFAM',
    'CAMPO GRANDE | CENTRO/NUCCON',
    'CAMPO GRANDE | CENTRO/NUFAMD',
    'CAMPO GRANDE | FÓRUM/NUCRIM',
    'CORUMBÁ | CENTRO',
    'DOURADOS | CIVEL I',
    'DOURADOS | CIVEL II',
    'DOURADOS | CRIMINAL',
    'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'
)
ORDER BY u.nome;

-- Segunda Entrância
SELECT 
    'Segunda Entrância' as entrancia,
    u.nome as unidade,
    CASE 
        WHEN u.entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Segunda Entrância') 
        THEN '✅ Classificada' 
        ELSE '❌ Não classificada' 
    END as status
FROM unidades u
WHERE u.nome IN (
    'AMAMBAI | CENTRO',
    'ANASTÁCIO | FÓRUM',
    'APARECIDA DO TABOADO | CENTRO',
    'AQUIDAUANA | ALTO',
    'BATAGUASSU | CENTRO',
    'BELA VISTA | FÓRUM',
    'BONITO | FÓRUM',
    'CAARAPÓ | FÓRUM',
    'CAMAPUÃ | FÓRUM',
    'CASSILÂNDIA | CENTRO',
    'CHAPADÃO DO SUL | FÓRUM',
    'COSTA RICA | FÓRUM',
    'COXIM | CENTRO',
    'FÁTIMA DO SUL | FÓRUM',
    'IGUATEMI | FÓRUM',
    'IVINHEMA | CENTRO',
    'JARDIM | FÓRUM',
    'MARACAJU | CENTRO',
    'MIRANDA | FÓRUM',
    'NAVIRAÍ | FÓRUM',
    'NOVA ALVORADA DO SUL | FÓRUM',
    'NOVA ANDRADINA | CENTRO',
    'PARANAÍBA | YPÊ BRANCO',
    'PONTA PORÃ | VILA LUIZ CURVO',
    'RIBAS DO RIO PARDO | FÓRUM',
    'RIO BRILHANTE | FÓRUM',
    'RIO VERDE DE MATO GROSSO | FÓRUM',
    'SÃO GABRIEL DO OESTE | FÓRUM',
    'SIDROLÂNDIA | CENTRO',
    'TERENOS | FÓRUM'
)
ORDER BY u.nome;

-- Segunda Instância
SELECT 
    'Segunda Instância' as entrancia,
    u.nome as unidade,
    CASE 
        WHEN u.entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Segunda Instância') 
        THEN '✅ Classificada' 
        ELSE '❌ Não classificada' 
    END as status
FROM unidades u
WHERE u.nome IN (
    'CAMPO GRANDE | 2ª INSTÂNCIA'
)
ORDER BY u.nome;

-- Primeira Entrância
SELECT 
    'Primeira Entrância' as entrancia,
    u.nome as unidade,
    CASE 
        WHEN u.entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Primeira Entrância') 
        THEN '✅ Classificada' 
        ELSE '❌ Não classificada' 
    END as status
FROM unidades u
WHERE u.nome IN (
    'ÁGUA CLARA | FÓRUM',
    'ANAURILÂNDIA | FÓRUM',
    'ANGÉLICA | FÓRUM',
    'BANDEIRANTES | FÓRUM',
    'BATAYPORÃ | FÓRUM',
    'BRASILÂNDIA | FÓRUM',
    'CORONEL SAPUCAIA | FÓRUM',
    'DEODÁPOLIS | FÓRUM',
    'DOIS IRMÃOS DO BURITI | FÓRUM',
    'ELDORADO | FÓRUM',
    'GLÓRIA DE DOURADOS | FÓRUM',
    'INOCÊNCIA | FÓRUM',
    'ITAQUIRAÍ | FÓRUM',
    'NIOAQUE | FÓRUM',
    'PEDRO GOMES | FÓRUM',
    'PORTO MURTINHO | FÓRUM',
    'RIO NEGRO | FÓRUM',
    'SETE QUEDAS | FÓRUM',
    'SONORA | FÓRUM'
)
ORDER BY u.nome;

-- =====================================================
-- 6. RELATÓRIO FINAL DE VALIDAÇÃO
-- =====================================================

-- Resumo geral
SELECT 
    'Total de entrâncias cadastradas:' as item,
    COUNT(*)::text as valor
FROM entrancias

UNION ALL

SELECT 
    'Total de unidades no sistema:' as item,
    COUNT(*)::text as valor
FROM unidades

UNION ALL

SELECT 
    'Unidades classificadas:' as item,
    COUNT(*)::text as valor
FROM unidades 
WHERE entrancia_id IS NOT NULL

UNION ALL

SELECT 
    'Unidades não classificadas:' as item,
    COUNT(*)::text as valor
FROM unidades 
WHERE entrancia_id IS NULL

UNION ALL

SELECT 
    'Percentual de classificação:' as item,
    ROUND((COUNT(CASE WHEN entrancia_id IS NOT NULL THEN 1 END) * 100.0 / COUNT(*)), 2)::text || '%' as valor
FROM unidades;

-- =====================================================
-- 7. VERIFICAÇÃO DE INTEGRIDADE
-- =====================================================

-- Verificar se existem referências órfãs
SELECT 
    'Referências órfãs encontradas:' as verificacao,
    CASE 
        WHEN COUNT(*) = 0 THEN '✅ Nenhuma' 
        ELSE '❌ ' || COUNT(*)::text || ' encontradas' 
    END as status
FROM unidades u
WHERE u.entrancia_id IS NOT NULL 
  AND NOT EXISTS (SELECT 1 FROM entrancias e WHERE e.id = u.entrancia_id);

-- =====================================================
-- FIM DO SCRIPT DE TESTE
-- =====================================================
