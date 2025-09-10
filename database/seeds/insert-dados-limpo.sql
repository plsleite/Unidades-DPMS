-- =====================================================
-- SCRIPT LIMPO DE INSERÇÃO DE DADOS - DEFENSORIA MS
-- =====================================================
-- Este script limpa os dados existentes e insere todos os dados
-- Execute no pgAdmin4 conectado ao banco 'defensoria_ms'

-- =====================================================
-- 1. LIMPAR DADOS EXISTENTES
-- =====================================================
DELETE FROM orgaos;
DELETE FROM unidades;
DELETE FROM regionais;

-- =====================================================
-- 2. INSERÇÃO DAS REGIONAIS
-- =====================================================
INSERT INTO regionais (nome, numero) VALUES
('1ª Regional de Campo Grande', 1),
('2ª Regional de Corumbá', 2),
('3ª Regional de Coxim', 3),
('4ª Regional de Dourados', 4),
('5ª Regional de Jardim', 5),
('6ª Regional de Nova Andradina', 6),
('7ª Regional de Paranaíba', 7),
('8ª Regional de Ponta Porã', 8),
('9ª Regional de Naviraí', 9),
('10ª Regional de Três Lagoas', 10),
('11ª Regional de Aquidauana', 11),
('12ª Regional de Chapadão do Sul', 12),
('13ª Regional de Maracaju', 13);

-- =====================================================
-- 3. INSERÇÃO DAS UNIDADES
-- =====================================================

-- ÁGUA CLARA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('ÁGUA CLARA | FÓRUM', 'Rua Francisco Vieira, S/nº - Fórum - CEP: 79680-000', '(67) 2025-0059', (SELECT id FROM regionais WHERE numero = 10 LIMIT 1), NULL, NULL, NULL, NULL);

-- AMAMBAI | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('AMAMBAI | CENTRO', 'Rua da República, 3223 - Centro - CEP: 79990-000', '(67) 2025-0060', (SELECT id FROM regionais WHERE numero = 8 LIMIT 1), NULL, NULL, NULL, NULL);

-- ANASTÁCIO | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('ANASTÁCIO | FÓRUM', 'Av. Juscelino Kubitschek de Oliveira, S/n. - S/nº - CEP: 79210-000', '(67) 2025-0063', (SELECT id FROM regionais WHERE numero = 11 LIMIT 1), NULL, NULL, NULL, NULL);

-- ANAURILÂNDIA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('ANAURILÂNDIA | FÓRUM', 'Rua Floriano Peixoto, 1001 - CEP: 79770-000', '(67) 3445-1152', (SELECT id FROM regionais WHERE numero = 6 LIMIT 1), NULL, NULL, NULL, NULL);

-- ANGÉLICA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('ANGÉLICA | FÓRUM', 'Av. Antônio Basílio de Lima, 258 - Imperial - CEP: 79785-000', '(67) 2025-0064', (SELECT id FROM regionais WHERE numero = 6 LIMIT 1), NULL, NULL, NULL, NULL);

-- APARECIDA DO TABOADO | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('APARECIDA DO TABOADO | CENTRO', 'Rua José Antonio de Carvalho, 4091 - Centro - CEP: 79570-000', '(67) 2025-0065', (SELECT id FROM regionais WHERE numero = 7 LIMIT 1), NULL, NULL, NULL, NULL);

-- AQUIDAUANA | ALTO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('AQUIDAUANA | ALTO', 'Rua Assis Ribeiro, 711 - Alto - CEP: 79200-000', '(67) 2025-0068', (SELECT id FROM regionais WHERE numero = 11 LIMIT 1), NULL, NULL, NULL, NULL);

-- BATAGUASSU | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('BATAGUASSU | CENTRO', 'Rua Ribas do Rio Pardo, 263 - Centro - CEP: 79780-000', '(67) 3541-2990', (SELECT id FROM regionais WHERE numero = 10 LIMIT 1), NULL, NULL, NULL, NULL);

-- BATAYPORÃ | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('BATAYPORÃ | FÓRUM', 'Avenida Brasil, 633 - CEP: 79760-000', '(67) 2025-0073', (SELECT id FROM regionais WHERE numero = 6 LIMIT 1), NULL, NULL, NULL, NULL);

-- BELA VISTA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('BELA VISTA | FÓRUM', 'Rua Barao do Ladario, 1595 - Fórum - CEP: 79260-000', '(67) 2025-0074', (SELECT id FROM regionais WHERE numero = 5 LIMIT 1), NULL, NULL, NULL, NULL);

-- BONITO | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('BONITO | FÓRUM', 'Rua Clóvis Cintra, 1035 - Vila Donária - CEP: 79290-000', '(67) 2025-0075', (SELECT id FROM regionais WHERE numero = 5 LIMIT 1), NULL, NULL, NULL, NULL);

-- BRASILÂNDIA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('BRASILÂNDIA | FÓRUM', 'Rua Manuel Vicente, 1390 - CEP: 79670-000', '(67) 2025-0076', (SELECT id FROM regionais WHERE numero = 10 LIMIT 1), NULL, NULL, NULL, NULL);

-- CAARAPÓ | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAARAPÓ | FÓRUM', 'Rua Dom Pedro II , 1700 - Vila Planalto - CEP: 79940-000', '(67) 2025-0077', (SELECT id FROM regionais WHERE numero = 4 LIMIT 1), NULL, NULL, NULL, NULL);

-- CAMPO GRANDE | 2ª INSTÂNCIA
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMPO GRANDE | 2ª INSTÂNCIA', 'Rua Raul Pires Barbosa, 1464 - Chácara Cachoeira - CEP: 79040-150', '(67) 3317-4110', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), NULL, NULL, NULL, NULL);

-- CAMPO GRANDE | AFONSO PENA/NUDEM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMPO GRANDE | AFONSO PENA/NUDEM', 'Av Afonso Pena, 3850 - Jardim dos Estados - CEP: 79020-001', '(67) 3313-4919', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Kricilaine Oliveira Souza Oksman', NULL, 'Edmeiry Silara Broch Festi', NULL);

-- CAMPO GRANDE | AFONSO PENA/NUDECA
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMPO GRANDE | AFONSO PENA/NUDECA', 'Av Afonso Pena, 3850 - Jardim dos Estados - CEP: 79020-001', '(67) 3313-4919', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Edson Cardoso', NULL, 'Edmeiry Silara Broch Festi', NULL);

-- CAMPO GRANDE | BARÃO DE MELGAÇO/NAS
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMPO GRANDE | BARÃO DE MELGAÇO/NAS', 'Rua Barão de Melgaço, 128 - Centro - CEP: 79002-090', '(67) 3317-8757', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Eni Maria Sezerino Diniz', NULL, 'Fabrício Cedro Dias de Aquino', NULL);

-- CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN', 'Rua Barão de Melgaço, 128 - Centro - CEP: 79002-090', '(67) 3317-4300', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Maurício Augusto Barbosa', NULL, 'Fabrício Cedro Dias de Aquino', NULL);

-- CAMPO GRANDE | BELMAR FIDALGO/NUFAM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMPO GRANDE | BELMAR FIDALGO/NUFAM', 'Rua Ermindo Leal, 555 - Bairro Ypê Branco - CEP: 79500-000', '(67) 3313-5800', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Marcelo Marinho da Silva', NULL, 'Carlos Felipe Guadanhim Bariani', NULL);

-- CAMPO GRANDE | CENTRO/NUCCON
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMPO GRANDE | CENTRO/NUCCON', 'Rua Antônio Maria Coelho, 1668 - Centro - CEP: 79002-220', '(67) 3317-8757', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Patrícia Feitosa de Lima', NULL, 'Anna Cláudia Rodrigues Santos', NULL);

-- CAMPO GRANDE | CENTRO/NUFAMD
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMPO GRANDE | CENTRO/NUFAMD', 'Rua Antônio Maria Coelho, 1668 - Centro - CEP: 79002-220', '(67) 3317-8757', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Danilo Hamano Silveira Campos', NULL, 'Anna Cláudia Rodrigues Santos', NULL);

-- CAMPO GRANDE | FÓRUM/NUCRIM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMPO GRANDE | FÓRUM/NUCRIM', 'Rua da Paz, 14 - Jardim dos Estados - CEP: 79002-919', '(67) 3317-4300', (SELECT id FROM regionais WHERE numero = 1 LIMIT 1), 'Francianny Cristine da Silva Santos', NULL, 'Helton Campos da Costa', NULL);

-- CASSILÂNDIA | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CASSILÂNDIA | CENTRO', 'Rua Laudemiro Ferreira de Freitas, 137 - CEP: 79540-000', '(67) 2025-0080', (SELECT id FROM regionais WHERE numero = 12 LIMIT 1), NULL, NULL, NULL, NULL);

-- CHAPADÃO DO SUL | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CHAPADÃO DO SUL | FÓRUM', 'Avenida Mato Grosso do Sul, 311 - CEP: 79560-000', '(67) 2025-0082', (SELECT id FROM regionais WHERE numero = 12 LIMIT 1), NULL, NULL, NULL, NULL);

-- CORONEL SAPUCAIA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CORONEL SAPUCAIA | FÓRUM', 'Rua José Amancio da Silva, 1866 - CEP: 79995-000', '(67) 2025-0083', (SELECT id FROM regionais WHERE numero = 8 LIMIT 1), NULL, NULL, NULL, NULL);

-- CORUMBÁ | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CORUMBÁ | CENTRO', 'Rua Luís Feitosa Rodrigues, 2094 - Nossa Senhora de Fátima - CEP: 79320-090', '(67) 2025-0086', (SELECT id FROM regionais WHERE numero = 2 LIMIT 1), NULL, NULL, NULL, NULL);

-- COSTA RICA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('COSTA RICA | FÓRUM', 'Rua José Pereira da Silva, 405 - Jardim Santos Dumont - CEP: 79550-000', '(67) 2025-0088', (SELECT id FROM regionais WHERE numero = 12 LIMIT 1), NULL, NULL, NULL, NULL);

-- COXIM | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('COXIM | CENTRO', 'Rua Barão do Rio Branco, 170 - Centro - CEP: 79400-000', '(67) 2025-0096', (SELECT id FROM regionais WHERE numero = 3 LIMIT 1), NULL, NULL, NULL, NULL);

-- DEODÁPOLIS | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('DEODÁPOLIS | FÓRUM', 'Avenida Francisco Alves da Silva, S/nº - CEP: 79790-000', '(67) 2025-0100', (SELECT id FROM regionais WHERE numero = 4 LIMIT 1), NULL, NULL, NULL, NULL);

-- DOIS IRMÃOS DO BURITI | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('DOIS IRMÃOS DO BURITI | FÓRUM', 'Avenida Reginaldo Lemes da Silva, 763 - CEP: 79215-000', '(67) 3243-1087', (SELECT id FROM regionais WHERE numero = 11 LIMIT 1), NULL, NULL, NULL, NULL);

-- DOURADOS | CIVEL I
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('DOURADOS | CIVEL I', 'Av Presidente Vargas, 177 - Centro - CEP: 79804-030', '(67) 3902-2700', (SELECT id FROM regionais WHERE numero = 4 LIMIT 1), NULL, NULL, NULL, NULL);

-- DOURADOS | CIVEL II
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('DOURADOS | CIVEL II', 'Rua Albino Torraca, 1255 - Vila Progresso - CEP: 79825-010', '(67) 3902-2700', (SELECT id FROM regionais WHERE numero = 4 LIMIT 1), NULL, NULL, NULL, NULL);

-- DOURADOS | CRIMINAL
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('DOURADOS | CRIMINAL', 'Rua Firmino Vieira de Matos, 1297 - Vila Progresso - CEP: 79825-050', '(67) 3411-8877', (SELECT id FROM regionais WHERE numero = 4 LIMIT 1), NULL, NULL, NULL, NULL);

-- ELDORADO | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('ELDORADO | FÓRUM', 'Rua Assis Chateaubriand, 1555 - CEP: 79970-000', '(67) 3473-1980', (SELECT id FROM regionais WHERE numero = 9 LIMIT 1), NULL, NULL, NULL, NULL);

-- FÁTIMA DO SUL | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('FÁTIMA DO SUL | FÓRUM', 'Rua Antônio Barbosa, 800 - CEP: 79700-000', '(67) 3467-1310', (SELECT id FROM regionais WHERE numero = 4 LIMIT 1), NULL, NULL, NULL, NULL);

-- GLÓRIA DE DOURADOS | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('GLÓRIA DE DOURADOS | FÓRUM', 'Rua Tancredo de Almeida Neves, S/nº - CEP: 79730-000', '(67) 3466-2437', (SELECT id FROM regionais WHERE numero = 4 LIMIT 1), NULL, NULL, NULL, NULL);

-- IGUATEMI | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('IGUATEMI | FÓRUM', 'Rua Lenira Nogueira Lopes, 548 - Centro - CEP: 79960-000', '(67) 2025-0100', (SELECT id FROM regionais WHERE numero = 9 LIMIT 1), NULL, NULL, NULL, NULL);

-- INOCÊNCIA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('INOCÊNCIA | FÓRUM', 'Av Albertina Garcia Dias, 377 - CEP: 79580-000', '(67) 2025-0102', (SELECT id FROM regionais WHERE numero = 7 LIMIT 1), NULL, NULL, NULL, NULL);

-- ITAPORÃ | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('ITAPORÃ | FÓRUM', 'Avenida São José, 2 - CEP: 79890-000', '(67) 2025-0103', (SELECT id FROM regionais WHERE numero = 13 LIMIT 1), NULL, NULL, NULL, NULL);

-- ITAQUIRAÍ | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('ITAQUIRAÍ | FÓRUM', 'Avenida Mato Grosso, 350 - CEP: 79965-000', '(67) 2025-0104', (SELECT id FROM regionais WHERE numero = 9 LIMIT 1), NULL, NULL, NULL, NULL);

-- IVINHEMA | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('IVINHEMA | CENTRO', 'Rua Joaquim Saraiva de Freitas, 284 - Centro - CEP: 79740-000', '(67) 3442-3976', (SELECT id FROM regionais WHERE numero = 6 LIMIT 1), NULL, NULL, NULL, NULL);

-- JARDIM | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('JARDIM | FÓRUM', 'Rua Campo Grande, S/n - Vila Angélica - CEP: 79240-000', '(67) 2180-0988', (SELECT id FROM regionais WHERE numero = 5 LIMIT 1), NULL, NULL, NULL, NULL);

-- MARACAJU | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('MARACAJU | CENTRO', 'Rua Luiz Porto Soares, 441 - Centro - CEP: 79150-000', '(67) 2025-0105', (SELECT id FROM regionais WHERE numero = 13 LIMIT 1), NULL, NULL, NULL, NULL);

-- MIRANDA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('MIRANDA | FÓRUM', 'Rua General Amaro Bittencourt, 875 - CEP: 79380-000', '(67) 2025-0109', (SELECT id FROM regionais WHERE numero = 11 LIMIT 1), NULL, NULL, NULL, NULL);

-- MUNDO NOVO | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('MUNDO NOVO | FÓRUM', 'Avenida Campo Grande, 375 - Berneck - CEP: 79980-000', '(67) 2025-0112', (SELECT id FROM regionais WHERE numero = 9 LIMIT 1), NULL, NULL, NULL, NULL);

-- NAVIRAÍ | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('NAVIRAÍ | FÓRUM', 'Rua Higino Gomes Duarte, 155 - Centro - CEP: 79950-000', '(67) 2025-0113', (SELECT id FROM regionais WHERE numero = 9 LIMIT 1), NULL, NULL, NULL, NULL);

-- NIOAQUE | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('NIOAQUE | FÓRUM', 'Rua Cel Juvêncio, 262 - CEP: 79220-000', '(67) 2025-0114', (SELECT id FROM regionais WHERE numero = 6 LIMIT 1), NULL, NULL, NULL, NULL);

-- NOVA ALVORADA DO SUL | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('NOVA ALVORADA DO SUL | FÓRUM', 'Rua Marcelino Risdem, 1040 - Jd Eldorado - CEP: 79140-000', '(67) 2025-0115', (SELECT id FROM regionais WHERE numero = 13 LIMIT 1), NULL, NULL, NULL, NULL);

-- NOVA ANDRADINA | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('NOVA ANDRADINA | CENTRO', 'Rua Luiz Antonio da Silva, 1482 - CEP: 79750-000', '(67) 3441-1001', (SELECT id FROM regionais WHERE numero = 6 LIMIT 1), NULL, NULL, NULL, NULL);

-- PARANAÍBA | YPÊ BRANCO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('PARANAÍBA | YPÊ BRANCO', 'Rua Ermindo Leal, 555 - Bairro Ypê Branco - CEP: 79500-000', '(67) 2025-0116', (SELECT id FROM regionais WHERE numero = 7 LIMIT 1), NULL, NULL, NULL, NULL);

-- PEDRO GOMES | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('PEDRO GOMES | FÓRUM', 'Rua Profª Diva Araújo Azambuja, 395 - CEP: 79410-000', '(67) 2025-0119', (SELECT id FROM regionais WHERE numero = 3 LIMIT 1), NULL, NULL, NULL, NULL);

-- PONTA PORÃ | VILA LUIZ CURVO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('PONTA PORÃ | VILA LUIZ CURVO', 'Avenida Presidente Vargas, 1850 - Vila Luiz Curvo - CEP: 79904-410', '(67) 2025-0127', (SELECT id FROM regionais WHERE numero = 8 LIMIT 1), NULL, NULL, NULL, NULL);

-- PORTO MURTINHO | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('PORTO MURTINHO | FÓRUM', 'Rua 13 de Maio, 444 - CEP: 79280-000', '(67) 2025-0132', (SELECT id FROM regionais WHERE numero = 5 LIMIT 1), NULL, NULL, NULL, NULL);

-- RIBAS DO RIO PARDO | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('RIBAS DO RIO PARDO | FÓRUM', 'Rua Waldemar Francisco da Silva, 1017 - Vila Nossa Senhora da Conceição - CEP: 79180-000', '(67) 2025-0133', (SELECT id FROM regionais WHERE numero = 10 LIMIT 1), NULL, NULL, NULL, NULL);

-- RIO BRILHANTE | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('RIO BRILHANTE | FÓRUM', 'Rua Rio Brilhante, 1060 - Vila Maria - CEP: 79130-000', '(67) 2025-0134', (SELECT id FROM regionais WHERE numero = 13 LIMIT 1), NULL, NULL, NULL, NULL);

-- SÃO GABRIEL DO OESTE | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('SÃO GABRIEL DO OESTE | FÓRUM', 'Avenida Mato Grosso do Sul, 2130 - CEP: 79490-000', '(67) 2025-0138', (SELECT id FROM regionais WHERE numero = 3 LIMIT 1), NULL, NULL, NULL, NULL);

-- SETE QUEDAS | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('SETE QUEDAS | FÓRUM', 'Rua Rui Barbosa, 780 - CEP: 79935-000', '(67) 2025-0139', (SELECT id FROM regionais WHERE numero = 8 LIMIT 1), NULL, NULL, NULL, NULL);

-- SONORA | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('SONORA | FÓRUM', 'Rua 3 de Junho, 90 - CEP: 79415-000', '(67) 2025-0144', (SELECT id FROM regionais WHERE numero = 3 LIMIT 1), NULL, NULL, NULL, NULL);

-- TERENOS | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('TERENOS | FÓRUM', 'Rua Pedro Celestino, S/n - CEP: 79190-000', '(67) 2025-0145', (SELECT id FROM regionais WHERE numero = 11 LIMIT 1), NULL, NULL, NULL, NULL);

-- TRÊS LAGOAS | PRAÇA DA JUSTIÇA
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('TRÊS LAGOAS | PRAÇA DA JUSTIÇA', 'Rua Alfredo Justino, 1108 - Praça Justiça - CEP: 79602-090', '(67) 3929-1370', (SELECT id FROM regionais WHERE numero = 10 LIMIT 1), NULL, NULL, NULL, NULL);

-- BANDEIRANTES | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('BANDEIRANTES | FÓRUM', 'Rua Pedro Celestino, 1460 - CEP: 79430-000', '(67) 2025-0072', (SELECT id FROM regionais WHERE numero = 3 LIMIT 1), NULL, NULL, NULL, NULL);

-- CAMAPUÃ | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('CAMAPUÃ | FÓRUM', 'Rua Ferreira da Cunha, 415 - CEP: 79420-000', '(67) 2025-0078', (SELECT id FROM regionais WHERE numero = 3 LIMIT 1), NULL, NULL, NULL, NULL);

-- RIO NEGRO | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('RIO NEGRO | FÓRUM', 'Rua 9 de Maio, 305 - Centro - CEP: 79470-000', '(67) 2025-0135', (SELECT id FROM regionais WHERE numero = 3 LIMIT 1), NULL, NULL, NULL, NULL);

-- RIO VERDE DE MATO GROSSO | FÓRUM
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('RIO VERDE DE MATO GROSSO | FÓRUM', 'Rua Eurico S. Ferreira, 640 - CEP: 79480-000', '(67) 2025-0136', (SELECT id FROM regionais WHERE numero = 3 LIMIT 1), NULL, NULL, NULL, NULL);

-- SIDROLÂNDIA | CENTRO
INSERT INTO unidades (nome, endereco, telefone, regional_id, coordenador, email_coordenador, supervisor, email_supervisor) VALUES
('SIDROLÂNDIA | CENTRO', 'Rua Distrito Federal, 986 - Centro - CEP: 79170-000', '(67) 2025-0143', (SELECT id FROM regionais WHERE numero = 11 LIMIT 1), NULL, NULL, NULL, NULL);

-- =====================================================
-- 4. VERIFICAÇÃO DOS DADOS INSERIDOS
-- =====================================================
SELECT '=== RESUMO DOS DADOS INSERIDOS ===' as status;

SELECT 'Regionais:' as tipo, COUNT(*) as total FROM regionais
UNION ALL
SELECT 'Unidades:', COUNT(*) FROM unidades
UNION ALL
SELECT 'Defensorias:', COUNT(*) FROM orgaos;

-- =====================================================
-- FIM DO SCRIPT
-- =====================================================
