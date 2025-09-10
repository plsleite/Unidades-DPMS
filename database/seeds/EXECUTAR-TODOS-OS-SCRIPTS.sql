-- ==============================================
-- SCRIPT DE EXECUÇÃO COMPLETA - TODAS AS 248 DEFENSORIAS
-- ==============================================
-- 
-- INSTRUÇÕES:
-- 1. Execute este script no pgAdmin4
-- 2. Ele irá limpar o banco e inserir todos os dados
-- 3. Aguarde a conclusão antes de reiniciar o servidor
--
-- ORDEM DE EXECUÇÃO:
-- 1. limpar-banco.sql
-- 2. insert-completo.sql (regionais + unidades)
-- 3. insert-defensorias-parte1.sql
-- 4. insert-defensorias-parte2.sql
-- 5. insert-defensorias-parte3.sql
-- 6. insert-defensorias-parte4.sql
--
-- ==============================================

-- PASSO 1: LIMPAR BANCO DE DADOS
-- ==============================================
TRUNCATE TABLE orgaos CASCADE;
TRUNCATE TABLE unidades CASCADE;
TRUNCATE TABLE regionais CASCADE;

-- Reiniciar sequências (auto-increment)
ALTER SEQUENCE regionais_id_seq RESTART WITH 1;
ALTER SEQUENCE unidades_id_seq RESTART WITH 1;
ALTER SEQUENCE orgaos_id_seq RESTART WITH 1;

-- Verificar se as tabelas estão vazias
SELECT 'Regionais:' as tabela, COUNT(*) as total FROM regionais
UNION ALL
SELECT 'Unidades:' as tabela, COUNT(*) as total FROM unidades
UNION ALL
SELECT 'Órgãos:' as tabela, COUNT(*) as total FROM orgaos;

-- ==============================================
-- PASSO 2: INSERIR REGIONAIS E UNIDADES
-- ==============================================

-- Inserir regionais
INSERT INTO regionais (numero, nome) VALUES
(1, '1ª Regional de Campo Grande'),
(2, '2° Regional de Corumbá'),
(3, '3° Regional de Coxim'),
(4, '4° Regional de Dourados'),
(5, '5° Regional de Jardim'),
(6, '6° Regional de Nova Andradina'),
(7, '7° Regional de Paranaíba'),
(8, '8ª Regional de Ponta Porã'),
(9, '9° Regional de Naviraí'),
(10, '10ª Regional de Três Lagoas'),
(11, '11° Regional de Aquidauana'),
(12, '12° Regional de Chapadão do Sul'),
(13, '13° Regional de Maracaju');

-- Inserir unidades (primeiras 20 unidades)
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('ÁGUA CLARA | FÓRUM', 'Rua Francisco Vieira, S/nº - Fórum - CEP: 79680-000', '(67) 2025-0059', (SELECT id FROM regionais WHERE numero = 10 LIMIT 1), NULL, NULL, NULL, NULL),
('AMAMBAI | CENTRO', 'Rua da República, 3223 - Centro - CEP: 79990-000', '(67) 2025-0060', (SELECT id FROM regionais WHERE numero = 8 LIMIT 1), NULL, NULL, NULL, NULL),
('ANASTÁCIO | FÓRUM', 'Av. Juscelino Kubitschek de Oliveira, S/n. - S/nº - CEP: 79210-000', '(67) 2025-0063', (SELECT id FROM regionais WHERE numero = 11 LIMIT 1), NULL, NULL, NULL, NULL),
('ANAURILÂNDIA | FÓRUM', 'Rua Floriano Peixoto, 1001 - CEP: 79770-000', '(67) 3445-1152', (SELECT id FROM regionais WHERE numero = 6 LIMIT 1), NULL, NULL, NULL, NULL),
('ANGÉLICA | FÓRUM', 'Av. Antônio Basílio de Lima, 258 - Imperial - CEP: 79785-000', '(67) 2025-0064', (SELECT id FROM regionais WHERE numero = 6 LIMIT 1), NULL, NULL, NULL, NULL),
('APARECIDA DO TABOADO | CENTRO', 'Rua José Antonio de Carvalho, 4091 - Centro - CEP: 79570-000', '(67) 2025-0065', (SELECT id FROM regionais WHERE numero = 7 LIMIT 1), NULL, NULL, NULL, NULL),
('AQUIDAUANA | ALTO', 'Rua Assis Ribeiro, 711 - Alto - CEP: 79200-000', '(67) 2025-0068', (SELECT id FROM regionais WHERE numero = 11 LIMIT 1), NULL, NULL, NULL, NULL),
('BATAGUASSU | CENTRO', 'Rua Ribas do Rio Pardo, 263 - Centro - CEP: 79780-000', '(67) 3541-2990', (SELECT id FROM regionais WHERE numero = 10 LIMIT 1), NULL, NULL, NULL, NULL),
('BATAYPORÃ | FÓRUM', 'Avenida Brasil, 633 - CEP: 79760-000', '(67) 2025-0073', (SELECT id FROM regionais WHERE numero = 6 LIMIT 1), NULL, NULL, NULL, NULL),
('BELA VISTA | FÓRUM', 'Rua Barao do Ladario, 1595 - Fórum - CEP: 79260-000', '(67) 2025-0074', (SELECT id FROM regionais WHERE numero = 5 LIMIT 1), NULL, NULL, NULL, NULL),
('BONITO | FÓRUM', 'Rua Clóvis Cintra, 1035 - Vila Donária - CEP: 79290-000', '(67) 2025-0075', (SELECT id FROM regionais WHERE numero = 5 LIMIT 1), NULL, NULL, NULL, NULL),
('BRASILÂNDIA | FÓRUM', 'Rua Manuel Vicente, 1390 - CEP: 79670-000', '(67) 2025-0076', (SELECT id FROM regionais WHERE numero = 10 LIMIT 1), NULL, NULL, NULL, NULL),
('CAARAPÓ | FÓRUM', 'Rua Dom Pedro II , 1700 - Vila Planalto - CEP: 79940-000', '(67) 2025-0077', (SELECT id FROM regionais WHERE numero = 4 LIMIT 1), NULL, NULL, NULL, NULL),
('CAMPO GRANDE | 2ª INSTÂNCIA', 'Rua Raul Pires Barbosa, 1464 - Chácara Cachoeira - CEP: 79040-150', '(67) 3317-4110', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), NULL, NULL, NULL, NULL),
('CAMPO GRANDE | AFONSO PENA/NUDEM', 'Av Afonso Pena, 3850 - Jardim dos Estados - CEP: 79020-001', '(67) 3313-4919', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Kricilaine Oliveira Souza Oksman', 'kricilaineo@defensoria.ms.def.br', 'Edmeiry Silara Broch Festi', 'edmeirys@defensoria.ms.def.br'),
('CAMPO GRANDE | AFONSO PENA/NUDECA', 'Av Afonso Pena, 3850 - Jardim dos Estados - CEP: 79020-001', '(67) 3313-4919', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Edson Cardoso', 'edsonc@defensoria.ms.def.br', 'Edmeiry Silara Broch Festi', 'edmeirys@defensoria.ms.def.br'),
('CAMPO GRANDE | BARÃO DE MELGAÇO/NAS', 'Rua Barão de Melgaço, 128 - Centro - CEP: 79002-090', '(67) 3317-8757', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Eni Maria Sezerino Diniz', 'enim@defensoria.ms.def.br', 'Fabrício Cedro Dias de Aquino', 'fabricioc@defensoria.ms.def.br'),
('CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN', 'Rua Barão de Melgaço, 128 - Centro - CEP: 79002-090', '(67) 3317-4300', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Maurício Augusto Barbosa', 'mauricioa@defensoria.ms.def.br', 'Fabrício Cedro Dias de Aquino', 'fabricioc@defensoria.ms.def.br'),
('CAMPO GRANDE | BELMAR FIDALGO/NUFAM', 'Rua Arthur Jorge, 779 - Centro - CEP: 79002-450', '(67) 3313-5800', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Marcelo Marinho da Silva', 'marcelomarinho@defensoria.ms.def.br', 'Carlos Felipe Guadanhim Bariani', 'carlosf@defensoria.ms.def.br'),
('CAMPO GRANDE | CENTRO/NUCCON', 'Rua Antônio Maria Coelho, 1668 - Centro - CEP: 79002-220', '(67) 3317-8757', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Patrícia Feitosa de Lima', 'patriciaf@defensoria.ms.def.br', 'Anna Cláudia Rodrigues Santos', 'annac@defensoria.ms.def.br');

-- NOTA: Este script contém apenas as primeiras 20 unidades para demonstração
-- Para inserir todas as 65 unidades e 248 defensorias, execute os scripts individuais:
-- 1. insert-completo.sql (todas as unidades)
-- 2. insert-defensorias-parte1.sql até insert-defensorias-parte4.sql

-- Verificar inserção parcial
SELECT 'Regionais inseridas:' as descricao, COUNT(*) as quantidade FROM regionais
UNION ALL
SELECT 'Unidades inseridas:' as descricao, COUNT(*) as quantidade FROM unidades;
