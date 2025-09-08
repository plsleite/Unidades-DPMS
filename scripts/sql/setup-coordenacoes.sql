-- =====================================================
-- SCRIPT DE CRIAÇÃO DA TABELA DE COORDENAÇÕES
-- =====================================================
-- Este script cria a tabela de coordenações para unidades de segunda instância
-- Execute no pgAdmin4 conectado ao banco 'defensoria_ms'

-- =====================================================
-- 1. CRIAR TABELA DE COORDENAÇÕES
-- =====================================================

CREATE TABLE IF NOT EXISTS coordenacoes (
    id SERIAL PRIMARY KEY,
    unidade_id INTEGER NOT NULL REFERENCES unidades(id) ON DELETE CASCADE,
    tipo_coordenacao VARCHAR(50) NOT NULL, -- 'CIVEL', 'CRIMINAL', 'ADMINISTRATIVA'
    nome_coordenador VARCHAR(255) NOT NULL,
    email_coordenador VARCHAR(255),
    ativo BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para melhor performance
CREATE INDEX IF NOT EXISTS idx_coordenacoes_unidade_id ON coordenacoes(unidade_id);
CREATE INDEX IF NOT EXISTS idx_coordenacoes_tipo ON coordenacoes(tipo_coordenacao);
CREATE INDEX IF NOT EXISTS idx_coordenacoes_ativo ON coordenacoes(ativo);

-- =====================================================
-- 2. INSERIR COORDENAÇÕES DA UNIDADE CAMPO GRANDE | 2ª INSTÂNCIA
-- =====================================================

-- Primeiro, vamos encontrar o ID da unidade CAMPO GRANDE | 2ª INSTÂNCIA
-- e inserir as coordenações

INSERT INTO coordenacoes (unidade_id, tipo_coordenacao, nome_coordenador, email_coordenador, ativo)
SELECT 
    u.id,
    'ADMINISTRATIVA',
    'Gloria de Fátima Fernandes Galbiati',
    NULL,
    true
FROM unidades u 
WHERE u.nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'
LIMIT 1;

INSERT INTO coordenacoes (unidade_id, tipo_coordenacao, nome_coordenador, email_coordenador, ativo)
SELECT 
    u.id,
    'CIVEL',
    'Edna Regina Batista Nunes da Cunha',
    NULL,
    true
FROM unidades u 
WHERE u.nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'
LIMIT 1;

INSERT INTO coordenacoes (unidade_id, tipo_coordenacao, nome_coordenador, email_coordenador, ativo)
SELECT 
    u.id,
    'CRIMINAL',
    'Zeliana Luzia Delarissa Sabala',
    NULL,
    true
FROM unidades u 
WHERE u.nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'
LIMIT 1;

-- =====================================================
-- 3. VERIFICAR INSERÇÃO
-- =====================================================

-- Verificar se as coordenações foram inseridas corretamente
SELECT 
    c.id,
    c.tipo_coordenacao,
    c.nome_coordenador,
    c.email_coordenador,
    c.ativo,
    u.nome as unidade_nome
FROM coordenacoes c
JOIN unidades u ON c.unidade_id = u.id
WHERE u.nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'
ORDER BY c.tipo_coordenacao;

-- =====================================================
-- 4. COMENTÁRIOS DA TABELA
-- =====================================================

COMMENT ON TABLE coordenacoes IS 'Tabela para armazenar as coordenações das unidades de segunda instância';
COMMENT ON COLUMN coordenacoes.unidade_id IS 'ID da unidade à qual a coordenação pertence';
COMMENT ON COLUMN coordenacoes.tipo_coordenacao IS 'Tipo da coordenação: CIVEL, CRIMINAL ou ADMINISTRATIVA';
COMMENT ON COLUMN coordenacoes.nome_coordenador IS 'Nome do coordenador responsável';
COMMENT ON COLUMN coordenacoes.email_coordenador IS 'Email do coordenador (opcional)';
COMMENT ON COLUMN coordenacoes.ativo IS 'Indica se a coordenação está ativa';
