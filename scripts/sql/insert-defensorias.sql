-- =====================================================
-- SCRIPT DE INSERÇÃO DAS DEFENSORIAS (ÓRGÃOS)
-- =====================================================
-- Execute este script APÓS executar o insert-dados-completos.sql

-- =====================================================
-- INSERÇÃO DAS DEFENSORIAS POR UNIDADE
-- =====================================================

-- ÁGUA CLARA | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Água Clara', (SELECT id FROM unidades WHERE nome = 'ÁGUA CLARA | FÓRUM'), 'Raphaela da Silva Nascimento', 'rnascimento@defensoria.ms.def.br', false, false, NULL, NULL);

-- AMAMBAI | CENTRO
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de Amambai', (SELECT id FROM unidades WHERE nome = 'AMAMBAI | CENTRO'), 'Eurico Bartolomeu Ribeiro Neto', 'euricob@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Cível de Amambai', (SELECT id FROM unidades WHERE nome = 'AMAMBAI | CENTRO'), NULL, NULL, false, true, 'Eurico Bartolomeu Ribeiro Neto', 'euricob@defensoria.ms.def.br'),
('1ª Defensoria Pública Criminal de Amambai', (SELECT id FROM unidades WHERE nome = 'AMAMBAI | CENTRO'), NULL, NULL, false, true, 'Matheus Paulo de Andrade', 'mpandrade@defensoria.ms.def.br');

-- ANASTÁCIO | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Anastácio', (SELECT id FROM unidades WHERE nome = 'ANASTÁCIO | FÓRUM'), 'Sara Curcino Martins de Oliveira', 'sarac@defensoria.ms.def.br', false, false, NULL, NULL);

-- ANAURILÂNDIA | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Anaurilândia', (SELECT id FROM unidades WHERE nome = 'ANAURILÂNDIA | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- ANGÉLICA | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Angélica', (SELECT id FROM unidades WHERE nome = 'ANGÉLICA | FÓRUM'), 'Bruno Augusto de Resende Louzada', 'brunol@defensoria.ms.def.br', false, false, NULL, NULL);

-- APARECIDA DO TABOADO | CENTRO
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Aparecida do Taboado', (SELECT id FROM unidades WHERE nome = 'APARECIDA DO TABOADO | CENTRO'), 'Vinícius Fernandes Cherem Curi', 'viniciusf@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Aparecida do Taboado', (SELECT id FROM unidades WHERE nome = 'APARECIDA DO TABOADO | CENTRO'), NULL, NULL, false, true, NULL, NULL);

-- AQUIDAUANA | ALTO
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de Aquidauana', (SELECT id FROM unidades WHERE nome = 'AQUIDAUANA | ALTO'), 'Janaína de Araújo Sant´ana', 'janainaa@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Cível de Aquidauana', (SELECT id FROM unidades WHERE nome = 'AQUIDAUANA | ALTO'), 'Danilo Iano Shiroma', 'daniloi@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública Criminal de Aquidauana', (SELECT id FROM unidades WHERE nome = 'AQUIDAUANA | ALTO'), 'Mauricio Augusto Barbosa', 'mauricioa@defensoria.ms.def.br', true, false, NULL, NULL);

-- BATAGUASSU | CENTRO
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Bataguassu', (SELECT id FROM unidades WHERE nome = 'BATAGUASSU | CENTRO'), 'Elias Augusto de Lima Filho', 'eliasf@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Bataguassu', (SELECT id FROM unidades WHERE nome = 'BATAGUASSU | CENTRO'), 'Elisiane Cristina Boço do Rosário', 'elisianec@defensoria.ms.def.br', false, false, NULL, NULL);

-- BATAYPORÃ | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Batayporã', (SELECT id FROM unidades WHERE nome = 'BATAYPORÃ | FÓRUM'), 'Marcel Leonardo Pelagio Gaio', 'marcelp@defensoria.ms.def.br', false, false, NULL, NULL);

-- BELA VISTA | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Bela Vista', (SELECT id FROM unidades WHERE nome = 'BELA VISTA | FÓRUM'), 'Yuri César Novais Magalhães Lopes', 'yuric@defensoria.ms.def.br', false, false, NULL, NULL);

-- BONITO | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Bonito', (SELECT id FROM unidades WHERE nome = 'BONITO | FÓRUM'), NULL, NULL, false, true, 'Vinícius Azevêdo Viana', 'vviana@defensoria.ms.def.br'),
('2ª Defensoria Pública de Bonito', (SELECT id FROM unidades WHERE nome = 'BONITO | FÓRUM'), 'Thaís Roque Sagin Lazzaroto', 'thaisr@defensoria.ms.def.br', false, false, NULL, NULL);

-- BRASILÂNDIA | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Brasilândia', (SELECT id FROM unidades WHERE nome = 'BRASILÂNDIA | FÓRUM'), 'Sara Zam Segura Marçal', 'saras@defensoria.ms.def.br', false, false, NULL, NULL);

-- CAARAPÓ | FÓRUM
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Caarapó', (SELECT id FROM unidades WHERE nome = 'CAARAPÓ | FÓRUM'), NULL, NULL, false, true, NULL, NULL),
('2ª Defensoria Pública de Caarapó', (SELECT id FROM unidades WHERE nome = 'CAARAPÓ | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- CAMPO GRANDE | 2ª INSTÂNCIA - CÍVEIS
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Marisa Nunes dos Santos Rodrigues', 'marisan@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Glória de Fátima Fernandes Galbiati', 'gloriaf@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Salete de Fátima do Nascimento', 'saletef@defensoria.ms.def.br', true, false, NULL, NULL),
('4ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Júlio César Ocampos Gonçalves', 'jcocampos@defensoria.ms.def.br', false, false, NULL, NULL),
('5ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Maria Rita Barbato', 'mrita@defensoria.ms.def.br', false, false, NULL, NULL),
('6ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Edna Regina Batista Nunes da Cunha', 'ednar@defensoria.ms.def.br', false, false, NULL, NULL),
('7ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Jane Inês Dietrich', 'janei@defensoria.ms.def.br', false, false, NULL, NULL),
('8ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Francisco Jose Soares Barroso', 'fbarroso@defensoria.ms.def.br', false, false, NULL, NULL),
('9ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), NULL, NULL, false, true, NULL, NULL),
('10ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Maria José do Nascimento', 'mjose@defensoria.ms.def.br', false, false, NULL, NULL),
('11ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Almir Silva Paixão', 'paixao@defensoria.ms.def.br', false, false, NULL, NULL),
('12ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Neyla Ferreira Mendes', 'neylaf@defensoria.ms.def.br', false, false, NULL, NULL),
('13ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Cacilda Kimiko Nakashima', 'cacildak@defensoria.ms.def.br', false, false, NULL, NULL),
('14ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Geni Tibúrcio Zawierucha', 'genit@defensoria.ms.def.br', false, false, NULL, NULL),
('15ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Silvio Fernando de Barros Corrêa', 'silviof@defensoria.ms.def.br', false, false, NULL, NULL),
('16ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Paulo Roberto Mattos', 'pmattos@defensoria.ms.def.br', false, false, NULL, NULL),
('17ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Olga Lemos Cardoso de Marco', 'olgal@defensoria.ms.def.br', false, false, NULL, NULL),
('18ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Fábio Rogério Rombi da Silva', 'fabior@defensoria.ms.def.br', false, false, NULL, NULL),
('19ª Defensoria Pública Cível de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), NULL, NULL, false, true, NULL, NULL);

-- CAMPO GRANDE | 2ª INSTÂNCIA - CRIMINAIS
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Nancy Gomes de Carvalho', 'nancyg@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Mônica Maria de Salvo Fontoura', 'monicam@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Elias Cesar Kesrouani', 'eliaskesrouani@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Zeliana Luzia Delarissa Sabala', 'zelianasabala@defensoria.ms.def.br', false, false, NULL, NULL),
('5ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Antonio João de Andrade', 'ajoao@defensoria.ms.def.br', false, false, NULL, NULL),
('6ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Paula Ferraz de Mello', 'paulaf@defensoria.ms.def.br', false, false, NULL, NULL),
('7ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Christiane Maria dos Santos Pereira Jucá Interlando', 'christianem@defensoria.ms.def.br', false, false, NULL, NULL),
('8ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Aparecido Martinez Espínola', 'aparecidom@defensoria.ms.def.br', false, false, NULL, NULL),
('9ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Marcos Francisco Perassolo', 'perassolo@defensoria.ms.def.br', true, false, NULL, NULL),
('10ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Angela Rosseti Chamorro Belli', 'angelac@defensoria.ms.def.br', false, false, NULL, NULL),
('11ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Antônio Farias de Souza', 'afarias@defensoria.ms.def.br', false, false, NULL, NULL),
('12ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Iran Pereira da Costa Neves', 'iranp@defensoria.ms.def.br', false, false, NULL, NULL),
('13ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Sandra Regina Santos de Vasconcelos', 'sandrar@defensoria.ms.def.br', false, false, NULL, NULL),
('14ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Francisco Carlos Bariani', 'fbariani@defensoria.ms.def.br', false, false, NULL, NULL),
('15ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Vera Regina Prado Martins', 'verar@defensoria.ms.def.br', false, false, NULL, NULL),
('16ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Renata Gomes Bernardes Leal', 'renatag@defensoria.ms.def.br', true, false, NULL, NULL),
('17ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Oziel Miranda', 'ozielm@defensoria.ms.def.br', false, false, NULL, NULL),
('18ª Defensoria Pública Criminal de 2ª Instância', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | 2ª INSTÂNCIA'), 'Eliana Etsumi Tsunoda', 'elianae@defensoria.ms.def.br', false, false, NULL, NULL);

-- =====================================================
-- CONTINUAÇÃO DAS DEFENSORIAS...
-- =====================================================
-- Nota: Devido ao tamanho, o restante das defensorias será inserido em partes
-- Execute este script primeiro e depois os scripts adicionais se necessário

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

-- =====================================================
-- VERIFICAÇÃO FINAL
-- =====================================================
SELECT 'Total de defensorias inseridas:' as status, COUNT(*) as quantidade FROM orgaos;
