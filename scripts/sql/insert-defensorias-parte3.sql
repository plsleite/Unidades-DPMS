-- Script para inserir defensorias - PARTE 3 (Unidades 41-60)
-- Este script deve ser executado APÓS os scripts anteriores

-- ==============================================
-- 3. INSERIR DEFENSORIAS - PARTE 3
-- ==============================================

-- DOURADOS | CIVEL I (4 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Família e Sucessões de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL I'), 'Reginaldo Marinho da Silva', 'reginaldom@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Família e Sucessões de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL I'), NULL, NULL, false, true, NULL, NULL),
('3ª Defensoria Pública de Família e Sucessões de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL I'), 'Gabriela Noronha de Sousa', 'gabrielan@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública de Família e Sucessões de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL I'), 'Santina Domingues de Oliveira', 'santinad@defensoria.ms.def.br', false, false, NULL, NULL);

-- DOURADOS | CIVEL II (10 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível Residual de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Maria Arnar Ribeiro', 'marnar@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Cível Residual de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Aléscio Artiolle', 'alescioa@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública Cível Residual de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Alex Batista de Souza', 'alexb@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública Cível Residual de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Maria Inêz Dias dos Santos', 'minez@defensoria.ms.def.br', false, false, NULL, NULL),
('5ª Defensoria Pública Cível Residual de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Danilo Hamano Silveira Campos', 'daniloh@defensoria.ms.def.br', true, false, NULL, NULL),
('6ª Defensoria Pública Cível Residual de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Astolfo Lopes Cançado Netto', 'astolfol@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública da Defesa do Consumidor', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Agenor Marinho de Souza Júnior', 'agenorm@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública da Defesa do Consumidor', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Mariza Fatima Gonçalves', 'marizaf@defensoria.ms.def.br', false, false, NULL, NULL),
('Defensoria Pública de Defesa da Mulher de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Inês Batisti Dantas Vieira', 'inesb@defensoria.ms.def.br', false, false, NULL, NULL),
('Defensoria Pública de Defesa da Saúde de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CIVEL II'), 'Leonardo Ferreira Mendes', 'leonardof@defensoria.ms.def.br', false, false, NULL, NULL);

-- DOURADOS | CRIMINAL (9 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Criminal de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CRIMINAL'), 'Vitor Plenamente de Calazans Ramos', 'vitorp@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública da Cidadania Criminal e Execução Penal', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CRIMINAL'), 'Lucas Colares Pimentel', 'lucasc@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública do Tribunal do Júri', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CRIMINAL'), 'Ligiane Cristina Motoki', 'ligianec@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Criminal de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CRIMINAL'), 'Cícero Feitosa de Lima', 'cicerof@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública do Tribunal do Júri', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CRIMINAL'), 'José Ricardo Merini', 'joser@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública Criminal de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CRIMINAL'), 'Rodrigo Vasconcelos Compri', 'rodrigov@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública Criminal de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CRIMINAL'), 'Samuel Sebastião Magalhães', 'samuels@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública da Infância e Adolescência de Dourados', (SELECT id FROM unidades WHERE nome = 'DOURADOS | CRIMINAL'), 'Bruno Bertoli Grassani', 'brunog@defensoria.ms.def.br', false, false, NULL, NULL);

-- ELDORADO | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Eldorado', (SELECT id FROM unidades WHERE nome = 'ELDORADO | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- FÁTIMA DO SUL | FÓRUM (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Fátima do Sul', (SELECT id FROM unidades WHERE nome = 'FÁTIMA DO SUL | FÓRUM'), 'Haroldo Hermenegildo Ribeiro', 'haroldoh@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Fátima do Sul', (SELECT id FROM unidades WHERE nome = 'FÁTIMA DO SUL | FÓRUM'), 'Pollyana Siqueira de Oliveira', 'pollyanas@defensoria.ms.def.br', false, false, NULL, NULL);

-- GLÓRIA DE DOURADOS | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Glória de Dourados', (SELECT id FROM unidades WHERE nome = 'GLÓRIA DE DOURADOS | FÓRUM'), 'Karina Figueiredo de Freitas', 'karinaf@defensoria.ms.def.br', false, false, NULL, NULL);

-- IGUATEMI | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Iguatemi', (SELECT id FROM unidades WHERE nome = 'IGUATEMI | FÓRUM'), 'Amanda Gabriela Silva Nassaro', 'anassaro@defensoria.ms.def.br', false, false, NULL, NULL);

-- INOCÊNCIA | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Inocência', (SELECT id FROM unidades WHERE nome = 'INOCÊNCIA | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- ITAPORÃ | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Itaporã', (SELECT id FROM unidades WHERE nome = 'ITAPORÃ | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- ITAQUIRAÍ | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Itaquiraí', (SELECT id FROM unidades WHERE nome = 'ITAQUIRAÍ | FÓRUM'), 'Juliana Esteves Teixeira Braga', 'julianae@defensoria.ms.def.br', false, false, NULL, NULL);

-- IVINHEMA | CENTRO (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Ivinhema', (SELECT id FROM unidades WHERE nome = 'IVINHEMA | CENTRO'), 'Seme Mattar Neto', 'semeneto@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Ivinhema', (SELECT id FROM unidades WHERE nome = 'IVINHEMA | CENTRO'), 'André Santelli Antunes', 'andres@defensoria.ms.def.br', false, false, NULL, NULL);

-- JARDIM | FÓRUM (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Jardim', (SELECT id FROM unidades WHERE nome = 'JARDIM | FÓRUM'), NULL, NULL, false, true, 'Andréa Pereira Nardon', 'andreanardon@defensoria.ms.def.br'),
('2ª Defensoria Pública de Jardim', (SELECT id FROM unidades WHERE nome = 'JARDIM | FÓRUM'), 'Andréa Pereira Nardon', 'andreanardon@defensoria.ms.def.br', false, false, NULL, NULL);

-- MARACAJU | CENTRO (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Maracaju', (SELECT id FROM unidades WHERE nome = 'MARACAJU | CENTRO'), 'Marcel Antão de Macedo', 'marcelm@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Maracaju', (SELECT id FROM unidades WHERE nome = 'MARACAJU | CENTRO'), NULL, NULL, false, true, 'Marcel Antão de Macedo', 'marcelm@defensoria.ms.def.br');

-- MIRANDA | FÓRUM (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Miranda', (SELECT id FROM unidades WHERE nome = 'MIRANDA | FÓRUM'), 'Maria Clara de Morais Porfírio', 'mariac@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Miranda', (SELECT id FROM unidades WHERE nome = 'MIRANDA | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- MUNDO NOVO | FÓRUM (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Mundo Novo', (SELECT id FROM unidades WHERE nome = 'MUNDO NOVO | FÓRUM'), 'Marta Rosangela da Silva', 'martar@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Mundo Novo', (SELECT id FROM unidades WHERE nome = 'MUNDO NOVO | FÓRUM'), 'Stela Maria Pereira de Souza', 'stelam@defensoria.ms.def.br', false, false, NULL, NULL);

-- NAVIRAÍ | FÓRUM (4 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de Naviraí', (SELECT id FROM unidades WHERE nome = 'NAVIRAÍ | FÓRUM'), 'Denise Banci dos Santos Cocaroli', 'deniseb@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Cível de Naviraí', (SELECT id FROM unidades WHERE nome = 'NAVIRAÍ | FÓRUM'), 'Solange Nobre Torres Jorge', 'solangen@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública Criminal de Naviraí', (SELECT id FROM unidades WHERE nome = 'NAVIRAÍ | FÓRUM'), 'Guilherme Lunelli', 'guilhermel@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Criminal de Naviraí', (SELECT id FROM unidades WHERE nome = 'NAVIRAÍ | FÓRUM'), 'Vandir Zulato Jorge', 'vandirz@defensoria.ms.def.br', false, false, NULL, NULL);

-- NIOAQUE | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Nioaque', (SELECT id FROM unidades WHERE nome = 'NIOAQUE | FÓRUM'), NULL, NULL, false, true, 'Diogo Alexandre de Freitas', 'dfreitas@defensoria.ms.def.br');

-- NOVA ALVORADA DO SUL | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Nova Alvorada do Sul', (SELECT id FROM unidades WHERE nome = 'NOVA ALVORADA DO SUL | FÓRUM'), 'Cássio Sanches Barbi', 'cassios@defensoria.ms.def.br', false, false, NULL, NULL);

-- NOVA ANDRADINA | CENTRO (4 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de Nova Andradina', (SELECT id FROM unidades WHERE nome = 'NOVA ANDRADINA | CENTRO'), 'Rivana de Lima Souza Coimbra', 'rivana@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Cível de Nova Andradina', (SELECT id FROM unidades WHERE nome = 'NOVA ANDRADINA | CENTRO'), 'Natanael Claudino de Araujo Junior', 'natanaelc@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública Cível de Nova Andradina', (SELECT id FROM unidades WHERE nome = 'NOVA ANDRADINA | CENTRO'), 'Edson Cardoso', 'edsonc@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública Criminal de Nova Andradina', (SELECT id FROM unidades WHERE nome = 'NOVA ANDRADINA | CENTRO'), 'Diego Bortoloni Disperati', 'diegob@defensoria.ms.def.br', false, false, NULL, NULL);

-- PARANAÍBA | YPÊ BRANCO (3 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de Paranaíba', (SELECT id FROM unidades WHERE nome = 'PARANAÍBA | YPÊ BRANCO'), NULL, NULL, false, true, NULL, NULL),
('2ª Defensoria Pública Cível de Paranaíba', (SELECT id FROM unidades WHERE nome = 'PARANAÍBA | YPÊ BRANCO'), 'Gustavo Peres de Oliveira Terra', 'gustavop@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública Criminal de Paranaíba', (SELECT id FROM unidades WHERE nome = 'PARANAÍBA | YPÊ BRANCO'), 'Andrew Robalinho da Silva Filho', 'robalinho@defensoria.ms.def.br', true, false, 'Gabriela Sant''anna Barcellos', 'gbarcellos@defensoria.ms.def.br');

-- PEDRO GOMES | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Pedro Gomes', (SELECT id FROM unidades WHERE nome = 'PEDRO GOMES | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- PONTA PORÃ | VILA LUIZ CURVO (5 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de Ponta Porã', (SELECT id FROM unidades WHERE nome = 'PONTA PORÃ | VILA LUIZ CURVO'), 'Juliane de Assis e Silva Holmes Lins', 'julianea@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Cível de Ponta Porã', (SELECT id FROM unidades WHERE nome = 'PONTA PORÃ | VILA LUIZ CURVO'), NULL, NULL, false, true, 'Bianca Reitmann Pagliarini', 'bpagliarini@defensoria.ms.def.br'),
('3ª Defensoria Pública Cível de Ponta Porã', (SELECT id FROM unidades WHERE nome = 'PONTA PORÃ | VILA LUIZ CURVO'), NULL, NULL, false, true, 'Vitória Davalos de Souza', 'vdsouza@defensoria.ms.def.br'),
('1ª Defensoria Pública Criminal de Ponta Porã', (SELECT id FROM unidades WHERE nome = 'PONTA PORÃ | VILA LUIZ CURVO'), 'Túlio Cruz Nogueira', 'tulioc@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Criminal de Ponta Porã', (SELECT id FROM unidades WHERE nome = 'PONTA PORÃ | VILA LUIZ CURVO'), 'Eduardo Adriano Torres', 'eduardot@defensoria.ms.def.br', false, false, NULL, NULL);

-- PORTO MURTINHO | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Porto Murtinho', (SELECT id FROM unidades WHERE nome = 'PORTO MURTINHO | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- RIBAS DO RIO PARDO | FÓRUM (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Ribas do Rio Pardo', (SELECT id FROM unidades WHERE nome = 'RIBAS DO RIO PARDO | FÓRUM'), 'Luana Simões de Oliveira Gomes', 'luanas@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Ribas do Rio Pardo', (SELECT id FROM unidades WHERE nome = 'RIBAS DO RIO PARDO | FÓRUM'), NULL, NULL, false, true, 'Luana Simões de Oliveira Gomes', 'luanas@defensoria.ms.def.br');

-- RIO BRILHANTE | FÓRUM (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública Cível de Rio Brilhante', (SELECT id FROM unidades WHERE nome = 'RIO BRILHANTE | FÓRUM'), NULL, NULL, false, true, 'João Pedro Rodrigues Nascimento', 'jprodrigues@defensoria.ms.def.br'),
('Defensoria Pública Criminal de Rio Brilhante', (SELECT id FROM unidades WHERE nome = 'RIO BRILHANTE | FÓRUM'), 'Nádia Beatriz Farias da Silva Maggioni', 'nadiab@defensoria.ms.def.br', false, false, NULL, NULL);

-- SÃO GABRIEL DO OESTE | FÓRUM (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de São Gabriel do Oeste', (SELECT id FROM unidades WHERE nome = 'SÃO GABRIEL DO OESTE | FÓRUM'), NULL, NULL, false, true, NULL, NULL),
('2ª Defensoria Pública de São Gabriel do Oeste', (SELECT id FROM unidades WHERE nome = 'SÃO GABRIEL DO OESTE | FÓRUM'), NULL, NULL, false, true, 'Larissa Romero de Souza', 'lsouza@defensoria.ms.def.br');

-- SETE QUEDAS | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Sete Quedas', (SELECT id FROM unidades WHERE nome = 'SETE QUEDAS | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- SONORA | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Sonora', (SELECT id FROM unidades WHERE nome = 'SONORA | FÓRUM'), 'Fernanda Leal Barbosa', 'fernandal@defensoria.ms.def.br', false, false, NULL, NULL);

-- TERENOS | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Terenos', (SELECT id FROM unidades WHERE nome = 'TERENOS | FÓRUM'), 'Ester Quintanilha Nogueira', 'esterq@defensoria.ms.def.br', false, false, NULL, NULL);

-- TRÊS LAGOAS | PRAÇA DA JUSTIÇA (8 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de Três Lagoas', (SELECT id FROM unidades WHERE nome = 'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'), 'Olavo Colli Júnior', 'olavoc@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Cível de Três Lagoas', (SELECT id FROM unidades WHERE nome = 'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'), 'Evandro Cesar Casali', 'evandroc@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública Cível de Três Lagoas', (SELECT id FROM unidades WHERE nome = 'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'), 'Darvino Antonio Maciel Júnior', 'darvinoa@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública Cível de Três Lagoas', (SELECT id FROM unidades WHERE nome = 'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'), 'Flávio Antonio de Oliveira', 'flavioa@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública Criminal (tribunal do Júri, Infância )', (SELECT id FROM unidades WHERE nome = 'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'), 'Bruno Henrique Gobbo Gutierrez', 'brunoh@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Criminal de Três Lagoas', (SELECT id FROM unidades WHERE nome = 'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'), 'Fábio Luiz Sant''ana de Oliveira', 'fabiol@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública Criminal de Três Lagoas', (SELECT id FROM unidades WHERE nome = 'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'), 'Danilo Augusto Formágio', 'daniloa@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública Criminal de Três Lagoas', (SELECT id FROM unidades WHERE nome = 'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'), 'Eduardo Cavichioli Mondoni', 'eduardoc@defensoria.ms.def.br', false, false, NULL, NULL),
('Defensoria Pública de Atendimento À Mulher de Três Lagoas', (SELECT id FROM unidades WHERE nome = 'TRÊS LAGOAS | PRAÇA DA JUSTIÇA'), 'Rita de Cássia Vendrami Pusch de Souza', 'ritac@defensoria.ms.def.br', false, false, NULL, NULL);
