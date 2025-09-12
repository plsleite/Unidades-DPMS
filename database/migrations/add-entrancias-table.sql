-- =====================================================
-- SCRIPT DE CRIAÇÃO DA TABELA DE ENTRÂNCIAS
-- =====================================================
-- Este script cria a tabela de entrâncias para classificar as comarcas
-- Execute no pgAdmin4 conectado ao banco 'defensoria_ms'

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
-- 4. VERIFICAR ESTRUTURA CRIADA
-- =====================================================

-- Verificar se a tabela foi criada corretamente
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'entrancias' 
ORDER BY ordinal_position;

-- Verificar se o campo foi adicionado na tabela unidades
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'unidades' 
    AND column_name = 'entrancia_id';

-- Mostrar dados inseridos
SELECT * FROM entrancias ORDER BY ordem;
