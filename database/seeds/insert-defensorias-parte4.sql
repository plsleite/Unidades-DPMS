-- Script para inserir defensorias - PARTE 4 (Unidades 61-65) - FINAL
-- Este script deve ser executado APÓS os scripts anteriores

-- ==============================================
-- 3. INSERIR DEFENSORIAS - PARTE 4 (FINAL)
-- ==============================================

-- BANDEIRANTES | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Bandeirantes', (SELECT id FROM unidades WHERE nome = 'BANDEIRANTES | FÓRUM'), 'Alberto Oksman', 'albertoo@defensoria.ms.def.br', false, false, NULL, NULL);

-- CAMAPUÃ | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Camapuã', (SELECT id FROM unidades WHERE nome = 'CAMAPUÃ | FÓRUM'), 'Vagner Fabricio Vieira Flausino', 'vagnerf@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Camapuã', (SELECT id FROM unidades WHERE nome = 'CAMAPUÃ | FÓRUM'), 'Kricilaine Oliveira Souza Oksman', 'kricilaineo@defensoria.ms.def.br', true, false, 'Vagner Fabricio Vieira Flausino', 'vagnerf@defensoria.ms.def.br');

-- RIO NEGRO | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Rio Negro', (SELECT id FROM unidades WHERE nome = 'RIO NEGRO | FÓRUM'), 'Rodrigo Duarte Quaresma', 'rodrigod@defensoria.ms.def.br', false, false, NULL, NULL);

-- RIO VERDE DE MATO GROSSO | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Rio Verde de Mato Grosso', (SELECT id FROM unidades WHERE nome = 'RIO VERDE DE MATO GROSSO | FÓRUM'), 'Pedro de Luna Souza Leite', 'pedrol@defensoria.ms.def.br', true, false, 'Rodrigo Duarte Quaresma', 'rodrigod@defensoria.ms.def.br');

-- SIDROLÂNDIA | CENTRO
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Criminal de Sidrolândia', (SELECT id FROM unidades WHERE nome = 'SIDROLÂNDIA | CENTRO'), NULL, NULL, false, true, 'Leonardo Gelatti Backes', 'lbackes@defensoria.ms.def.br'),
('1ª Defensoria Pública Cível de Sidrolândia', (SELECT id FROM unidades WHERE nome = 'SIDROLÂNDIA | CENTRO'), NULL, NULL, false, true, 'Marcos Braga da Fonseca', 'marcosb@defensoria.ms.def.br'),
('2ª Defensoria Pública Cível de Sidrolândia', (SELECT id FROM unidades WHERE nome = 'SIDROLÂNDIA | CENTRO'), 'Marcos Braga da Fonseca', 'marcosb@defensoria.ms.def.br', false, false, NULL, NULL);

-- ==============================================
-- VERIFICAÇÃO FINAL
-- ==============================================

-- Contar total de defensorias inseridas
SELECT 'Total de Defensorias:' as descricao, COUNT(*) as quantidade FROM orgaos
UNION ALL
SELECT 'Total de Unidades:' as descricao, COUNT(*) as quantidade FROM unidades
UNION ALL
SELECT 'Total de Regionais:' as descricao, COUNT(*) as quantidade FROM regionais;
