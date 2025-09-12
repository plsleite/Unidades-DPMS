-- =====================================================
-- SCRIPT DE CLASSIFICAÇÃO DAS COMARCAS POR ENTRÂNCIA
-- =====================================================
-- Este script classifica as comarcas existentes por entrância
-- Execute APÓS executar o add-entrancias-table.sql

-- =====================================================
-- 1. CLASSIFICAR COMARCAS DE ENTRÂNCIA ESPECIAL
-- =====================================================

UPDATE unidades 
SET entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Entrância Especial')
WHERE nome IN (
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
);

-- =====================================================
-- 2. CLASSIFICAR COMARCAS DE SEGUNDA ENTRÂNCIA
-- =====================================================

UPDATE unidades 
SET entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Segunda Entrância')
WHERE nome IN (
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
);

-- =====================================================
-- 3. CLASSIFICAR DEFENSORIAS DE SEGUNDA INSTÂNCIA
-- =====================================================

UPDATE unidades 
SET entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Segunda Instância')
WHERE nome IN (
    'CAMPO GRANDE | 2ª INSTÂNCIA'
);

-- =====================================================
-- 4. CLASSIFICAR COMARCAS DE PRIMEIRA ENTRÂNCIA
-- =====================================================

UPDATE unidades 
SET entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Primeira Entrância')
WHERE nome IN (
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
);

-- =====================================================
-- 5. VERIFICAR CLASSIFICAÇÃO REALIZADA
-- =====================================================

-- Mostrar resumo da classificação por entrância
SELECT 
    e.nome as entrancia,
    COUNT(u.id) as total_unidades,
    STRING_AGG(u.nome, ', ' ORDER BY u.nome) as unidades
FROM entrancias e
LEFT JOIN unidades u ON e.id = u.entrancia_id
GROUP BY e.id, e.nome, e.ordem
ORDER BY e.ordem;

-- Mostrar unidades não classificadas (se houver)
SELECT 
    u.id,
    u.nome,
    u.entrancia_id
FROM unidades u
WHERE u.entrancia_id IS NULL
ORDER BY u.nome;

-- Mostrar detalhes da classificação
SELECT 
    u.nome as unidade,
    e.nome as entrancia,
    e.ordem
FROM unidades u
LEFT JOIN entrancias e ON u.entrancia_id = e.id
ORDER BY e.ordem, u.nome;

-- =====================================================
-- 5. VALIDAÇÃO FINAL
-- =====================================================

-- Verificar se todas as unidades foram classificadas
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN '✅ Todas as unidades foram classificadas'
        ELSE '❌ Existem ' || COUNT(*) || ' unidades não classificadas'
    END as status
FROM unidades 
WHERE entrancia_id IS NULL;

-- Contar unidades por entrância
SELECT 
    COALESCE(e.nome, 'Não Classificada') as entrancia,
    COUNT(u.id) as total
FROM unidades u
LEFT JOIN entrancias e ON u.entrancia_id = e.id
GROUP BY e.id, e.nome
ORDER BY COALESCE(e.ordem, 999);
