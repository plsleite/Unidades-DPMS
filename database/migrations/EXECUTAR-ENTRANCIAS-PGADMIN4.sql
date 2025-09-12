-- =====================================================
-- SCRIPT PARA EXECUTAR NO PGADMIN4 - ESTRUTURA DE ENTRÂNCIAS
-- =====================================================
-- Execute este script completo no pgAdmin4
-- Cole todo o conteúdo e execute (F5)

-- =====================================================
-- 1. CRIAR TABELA DE ENTRÂNCIAS
-- =====================================================

CREATE TABLE IF NOT EXISTS entrancias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    ordem INTEGER NOT NULL UNIQUE,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para melhor performance
CREATE INDEX IF NOT EXISTS idx_entrancias_nome ON entrancias(nome);
CREATE INDEX IF NOT EXISTS idx_entrancias_ordem ON entrancias(ordem);

-- =====================================================
-- 2. INSERIR DADOS DAS ENTRÂNCIAS
-- =====================================================

INSERT INTO entrancias (nome, ordem, descricao) VALUES
('Primeira Entrância', 1, 'Comarcas de primeira entrância'),
('Segunda Entrância', 2, 'Comarcas de segunda entrância'),
('Entrância Especial', 3, 'Comarcas de entrância especial'),
('Segunda Instância', 4, 'Defensorias de segunda instância')
ON CONFLICT (nome) DO NOTHING;

-- =====================================================
-- 3. ADICIONAR CAMPO ENTRANCIA_ID NA TABELA UNIDADES
-- =====================================================

-- Adicionar coluna entrancia_id na tabela unidades
ALTER TABLE unidades 
ADD COLUMN IF NOT EXISTS entrancia_id INTEGER REFERENCES entrancias(id);

-- Adicionar comentário para documentar o campo
COMMENT ON COLUMN unidades.entrancia_id IS 'Referência à entrância da comarca';

-- Criar índice para melhor performance
CREATE INDEX IF NOT EXISTS idx_unidades_entrancia_id ON unidades(entrancia_id);

-- =====================================================
-- 4. CLASSIFICAR COMARCAS DE ENTRÂNCIA ESPECIAL
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
-- 5. CLASSIFICAR COMARCAS DE SEGUNDA ENTRÂNCIA
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
    'MUNDO NOVO | FÓRUM',
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
-- 6. CLASSIFICAR DEFENSORIAS DE SEGUNDA INSTÂNCIA
-- =====================================================

UPDATE unidades 
SET entrancia_id = (SELECT id FROM entrancias WHERE nome = 'Segunda Instância')
WHERE nome IN (
    'CAMPO GRANDE | 2ª INSTÂNCIA'
);

-- =====================================================
-- 7. CLASSIFICAR COMARCAS DE PRIMEIRA ENTRÂNCIA
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
    'ITAPORÃ | FÓRUM',
    'ITAQUIRAÍ | FÓRUM',
    'NIOAQUE | FÓRUM',
    'PEDRO GOMES | FÓRUM',
    'PORTO MURTINHO | FÓRUM',
    'RIO NEGRO | FÓRUM',
    'SETE QUEDAS | FÓRUM',
    'SONORA | FÓRUM'
);

-- =====================================================
-- 8. VERIFICAÇÃO E RELATÓRIO FINAL
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

-- =====================================================
-- FIM DO SCRIPT
-- =====================================================
