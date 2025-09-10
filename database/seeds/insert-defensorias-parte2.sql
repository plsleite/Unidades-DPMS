-- Script para inserir defensorias - PARTE 2 (Unidades 21-40)
-- Este script deve ser executado APÓS o insert-completo.sql e insert-defensorias-parte1.sql

-- ==============================================
-- 3. INSERIR DEFENSORIAS - PARTE 2
-- ==============================================

-- CAMPO GRANDE | AFONSO PENA/NUDEM (4 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Defesa da Mulher', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | AFONSO PENA/NUDEM'), 'Thaís Dominato Silva Teixeira', 'thaisd@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Defesa da Mulher', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | AFONSO PENA/NUDEM'), 'Edmeiry Silara Broch Festi', 'edmeirys@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública de Defesa da Mulher', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | AFONSO PENA/NUDEM'), 'Graziele Carra Dias', 'grazielec@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública de Defesa da Mulher', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | AFONSO PENA/NUDEM'), 'Camila Maués dos Santos Flausino', 'camilam@defensoria.ms.def.br', false, false, NULL, NULL);

-- CAMPO GRANDE | AFONSO PENA/NUDECA (5 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública da Infância e Adolescência de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | AFONSO PENA/NUDECA'), 'Carlos Alberto Souza Gomes', 'carlosalberto@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública da Infância e Adolescência de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | AFONSO PENA/NUDECA'), 'Paulo Andre Defante', 'pandre@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública da Infância e Adolescência de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | AFONSO PENA/NUDECA'), 'Eugênio Luiz Dameão', 'eugeniol@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública da Infância e Adolescência de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | AFONSO PENA/NUDECA'), 'Débora Maria de Souza Paulino', 'deboram@defensoria.ms.def.br', false, false, NULL, NULL),
('5ª Defensoria Pública da Infância e Adolescência de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | AFONSO PENA/NUDECA'), 'Rodrigo Zoccal Rosa', 'rodrigoz@defensoria.ms.def.br', false, false, NULL, NULL);

-- CAMPO GRANDE | BARÃO DE MELGAÇO/NAS (4 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Atenção à Saúde - DPAS', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NAS'), 'Hiram Nascimento Cabrita de Santana', 'hiramn@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensora Pública de Atenção À Saúde - DPAS', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NAS'), 'Fabrício Cedro Dias de Aquino', 'fabricioc@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública de Atenção À Saúde - DPAS', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NAS'), 'Eni Maria Sezerino Diniz', 'enim@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública de Atenção À Saúde - DPAS', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NAS'), 'Nilton Marcelo de Camargo', 'niltonm@defensoria.ms.def.br', false, false, NULL, NULL);

-- CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN (10 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), 'Paulo José Patuto', 'ppatuto@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), 'Jaqueline Linhares Granemann', 'jaquelinel@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), 'Thaisa Raquel Medeiros de Albuquerque Defante', 'thaisar@defensoria.ms.def.br', true, false, NULL, NULL),
('4ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), 'Humberto Bernardino Sena', 'humbertob@defensoria.ms.def.br', false, false, NULL, NULL),
('5ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), 'Pedro Paulo Gasparini', 'pedrop@defensoria.ms.def.br', true, false, NULL, NULL),
('6ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), 'Cahuê Duarte e Urdiales', 'cahued@defensoria.ms.def.br', false, false, NULL, NULL),
('7ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), 'Euclides Nunes Júnior', 'euclidesn@defensoria.ms.def.br', false, false, NULL, NULL),
('8ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), NULL, NULL, false, true, NULL, NULL),
('9ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), 'Thales Chalub Cerqueira', 'thalesc@defensoria.ms.def.br', false, false, NULL, NULL),
('10ª Defensoria Pública de Execução Penal', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BARÃO DE MELGAÇO/NUSPEN'), 'Carmen Lúcia Trindade Dutra', 'carmenl@defensoria.ms.def.br', false, false, NULL, NULL);

-- CAMPO GRANDE | BELMAR FIDALGO/NUFAM (16 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('40ª Defensoria Pública Estadual (1ª e 2ª Varas de Direitos Difusos, Coletivos e Individuais Homogêneos)', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Amarildo Cabral', 'amarildoc@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Paulo Dinis Martins Brum', 'pdinis@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Renato Rodrigues dos Santos', 'renator@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Marco Antonio Zeferino da Silva', 'marcoa@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Maria Amélia de Araújo Sant''ana', 'mamelia@defensoria.ms.def.br', false, false, NULL, NULL),
('5ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), NULL, NULL, false, true, NULL, NULL),
('6ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), NULL, NULL, false, true, NULL, NULL),
('7ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Daniel de Oliveira Falleiros Calemes', 'danielo@defensoria.ms.def.br', false, false, NULL, NULL),
('8ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Carlos Eduardo Bruno Marietto', 'carlosb@defensoria.ms.def.br', false, false, NULL, NULL),
('9ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'William Coelho Abdonor', 'williamc@defensoria.ms.def.br', false, false, NULL, NULL),
('10ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Marcelo Marinho da Silva', 'marcelomarinho@defensoria.ms.def.br', false, false, NULL, NULL),
('11ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Linda Maria Silva Costa Rabelo', 'lindam@defensoria.ms.def.br', false, false, NULL, NULL),
('12ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Carlos Felipe Guadanhim Bariani', 'carlosf@defensoria.ms.def.br', false, false, NULL, NULL),
('13ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Marcelo Moraes Salles', 'marcelosalles@defensoria.ms.def.br', false, false, NULL, NULL),
('14ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Joanara Hanny Messias Gomes', 'joanarah@defensoria.ms.def.br', false, false, NULL, NULL),
('15ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Daniel Provenzano Pereira', 'danielp@defensoria.ms.def.br', false, false, NULL, NULL),
('16ª Defensoria Pública de Família e Sucessões', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | BELMAR FIDALGO/NUFAM'), 'Valdir Florentino de Souza', 'valdirf@defensoria.ms.def.br', false, false, NULL, NULL);

-- CAMPO GRANDE | CENTRO/NUCCON (20 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Luciano Montali', 'lucianom@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Claudia Bossay Assumpção Fassa', 'claudiab@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Lídia Helena da Silva', 'lidiah@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Carlos Eduardo Oliveira de Souza', 'carlose@defensoria.ms.def.br', true, false, NULL, NULL),
('5ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Anna Claudia Rodrigues Santos', 'annac@defensoria.ms.def.br', false, false, NULL, NULL),
('6ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Ilton Barreto da Motta', 'iltonb@defensoria.ms.def.br', false, false, NULL, NULL),
('7ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Mateus Augusto Sutana e Silva', 'mateuss@defensoria.ms.def.br', true, false, NULL, NULL),
('8ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Homero Lupo Medeiros', 'homerol@defensoria.ms.def.br', true, false, NULL, NULL),
('9ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Cristiano Ronchi Lobo', 'cristianor@defensoria.ms.def.br', false, false, NULL, NULL),
('10ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Valdirene Gaetani Faria', 'valdireneg@defensoria.ms.def.br', false, false, NULL, NULL),
('11ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Lauro Moreira Schöler', 'laurom@defensoria.ms.def.br', false, false, NULL, NULL),
('12ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Rafael Ribas Biziak', 'rafaelr@defensoria.ms.def.br', false, false, NULL, NULL),
('13ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Leslie dos Reis', 'leslier@defensoria.ms.def.br', false, false, NULL, NULL),
('14ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Patrícia Feitosa de Lima', 'patriciaf@defensoria.ms.def.br', true, false, NULL, NULL),
('15ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Patrícia Elias Cozzolino de Oliveira', 'patriciae@defensoria.ms.def.br', true, false, NULL, NULL),
('16ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Paulo Henrique Paixão', 'ppaixao@defensoria.ms.def.br', false, false, NULL, NULL),
('17ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), NULL, NULL, false, true, NULL, NULL),
('18ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Kriscia Cavalcante Nakasone Gusso', 'krisciac@defensoria.ms.def.br', false, false, NULL, NULL),
('19ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'Faber Pereira Kamachi', 'faberp@defensoria.ms.def.br', false, false, NULL, NULL),
('20ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUCCON'), 'João Miguel de Souza', 'joaom@defensoria.ms.def.br', false, false, NULL, NULL);

-- CAMPO GRANDE | CENTRO/NUFAMD (4 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública da Fazenda Pública, Moradia e Direitos Sociais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUFAMD'), NULL, NULL, false, true, NULL, NULL),
('2ª Defensoria Pública de Fazenda Pública, Moradia e Direitos Sociais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUFAMD'), 'Kátia Maria Souza Cardoso', 'katiam@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública da Fazenda Pública, Moradia e Direitos Sociais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUFAMD'), 'Regina Célia Rodrigues Magro', 'reginac@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública da Fazenda Pública, Moradia e Direitos Sociais', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | CENTRO/NUFAMD'), 'Alceu Conterato Junior', 'alceuc@defensoria.ms.def.br', false, false, NULL, NULL);

-- CAMPO GRANDE | FÓRUM/NUCRIM (22 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Guilherme Cambraia de Oliveira', 'guilhermec@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Maritza Brandão', 'maritzab@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Carmen Silvia Almeida Garcia', 'carmems@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Lucienne Borin Lima', 'lucienneb@defensoria.ms.def.br', true, false, NULL, NULL),
('5ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Mariane Vieira Rizzo', 'marianev@defensoria.ms.def.br', false, false, NULL, NULL),
('6ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Igor César de Manzano Linjardi', 'igorc@defensoria.ms.def.br', false, false, NULL, NULL),
('7ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Marcus Vinicius Carromeu Dias', 'carromeu@defensoria.ms.def.br', false, false, NULL, NULL),
('8ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Fábio Odacir Marinho de Rezende', 'fabioo@defensoria.ms.def.br', false, false, NULL, NULL),
('9ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), NULL, NULL, false, true, NULL, NULL),
('10ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Helton Campos da Costa', 'heltonc@defensoria.ms.def.br', false, false, NULL, NULL),
('11ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'José Gonçalves de Farias', 'josefarias@defensoria.ms.def.br', true, false, NULL, NULL),
('12ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Anderson Chadid Warpechowski', 'andersonc@defensoria.ms.def.br', true, false, NULL, NULL),
('13ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Esveraldo Torres Cano', 'esveraldot@defensoria.ms.def.br', false, false, NULL, NULL),
('14ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Carlos Renato Cotrim Leal', 'carlosr@defensoria.ms.def.br', false, false, NULL, NULL),
('15ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Gustavo Henrique Pinheiro Silva', 'gustavoh@defensoria.ms.def.br', false, false, NULL, NULL),
('16ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Rodrigo Antonio Stochiero Silva', 'rodrigoa@defensoria.ms.def.br', false, false, NULL, NULL),
('17ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Ronald Calixto Nunes', 'ronaldc@defensoria.ms.def.br', false, false, NULL, NULL),
('18ª Defensoria Pública Criminal de Campo Grande', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Nilson da Silva Geraldo', 'nilsons@defensoria.ms.def.br', false, false, NULL, NULL),
('1ª Defensoria Pública Estadual de Defesa do Homem', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Antonio César Bauermeister de Araújo', 'acesar@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Estadual de Defesa do Homem', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Rodrigo Oliveira Alvarez', 'rodrigoo@defensoria.ms.def.br', false, false, NULL, NULL),
('3ª Defensoria Pública Estadual de Defesa do Homem', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Francianny Cristine da Silva Santos', 'franciannyc@defensoria.ms.def.br', false, false, NULL, NULL),
('4ª Defensoria Pública Estadual de Defesa do Homem', (SELECT id FROM unidades WHERE nome = 'CAMPO GRANDE | FÓRUM/NUCRIM'), 'Helkis Clark Ghizzi', 'helkis@defensoria.ms.def.br', true, false, NULL, NULL);

-- CASSILÂNDIA | CENTRO (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Cassilândia', (SELECT id FROM unidades WHERE nome = 'CASSILÂNDIA | CENTRO'), NULL, NULL, false, true, 'Paulo Henrique Americo Lucindo', 'plucindo@defensoria.ms.def.br'),
('2ª Defensoria Pública de Cassilândia', (SELECT id FROM unidades WHERE nome = 'CASSILÂNDIA | CENTRO'), NULL, NULL, false, true, NULL, NULL);

-- CHAPADÃO DO SUL | FÓRUM (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Chapadão do Sul', (SELECT id FROM unidades WHERE nome = 'CHAPADÃO DO SUL | FÓRUM'), 'Ernany Andrade Machado', 'ernanya@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública de Chapadão do Sul', (SELECT id FROM unidades WHERE nome = 'CHAPADÃO DO SUL | FÓRUM'), 'Janaina Gabriela Pereira Schechter', 'janainap@defensoria.ms.def.br', false, false, NULL, NULL);

-- CORONEL SAPUCAIA | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Coronel Sapucaia', (SELECT id FROM unidades WHERE nome = 'CORONEL SAPUCAIA | FÓRUM'), NULL, NULL, false, true, 'Taís Soares Vieira Ferretti', 'tferretti@defensoria.ms.def.br');

-- CORUMBÁ | CENTRO (7 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de Corumbá', (SELECT id FROM unidades WHERE nome = 'CORUMBÁ | CENTRO'), NULL, NULL, false, true, 'Ariel Bianchi Rodrigues Alves', 'arielb@defensoria.ms.def.br'),
('2ª Defensoria Pública Cível de Corumbá', (SELECT id FROM unidades WHERE nome = 'CORUMBÁ | CENTRO'), NULL, NULL, false, true, 'Juliana Borher Valadares', 'jvaladares@defensoria.ms.def.br'),
('3ª Defensoria Pública Cível de Corumbá', (SELECT id FROM unidades WHERE nome = 'CORUMBÁ | CENTRO'), 'Jamile Gonçalves Serra Azul', 'jamileg@defensoria.ms.def.br', true, false, 'Rebecca Scalzilli Ramos Pantoja', 'rpantoja@defensoria.ms.def.br'),
('1ª Defensoria Pública Criminal de Corumbá', (SELECT id FROM unidades WHERE nome = 'CORUMBÁ | CENTRO'), 'Fernando Eduardo Silva de Andrade', 'fernandoe@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Criminal de Corumbá', (SELECT id FROM unidades WHERE nome = 'CORUMBÁ | CENTRO'), NULL, NULL, false, true, NULL, NULL),
('3ª Defensoria Pública Criminal de Corumbá', (SELECT id FROM unidades WHERE nome = 'CORUMBÁ | CENTRO'), NULL, NULL, false, true, 'Pedro Lenno Rovetta Nogueira', 'pnogueira@defensoria.ms.def.br'),
('Defensoria Pública de Atendimento À Mulher de Corumbá', (SELECT id FROM unidades WHERE nome = 'CORUMBÁ | CENTRO'), NULL, NULL, false, true, NULL, NULL);

-- COSTA RICA | FÓRUM (2 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública de Costa Rica', (SELECT id FROM unidades WHERE nome = 'COSTA RICA | FÓRUM'), NULL, NULL, false, true, 'Katherine Alzira Avellan Neves', 'katherinea@defensoria.ms.def.br'),
('2ª Defensoria Pública de Costa Rica', (SELECT id FROM unidades WHERE nome = 'COSTA RICA | FÓRUM'), 'Katherine Alzira Avellan Neves', 'katherinea@defensoria.ms.def.br', false, false, NULL, NULL);

-- COXIM | CENTRO (3 defensorias)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('1ª Defensoria Pública Cível de Coxim', (SELECT id FROM unidades WHERE nome = 'COXIM | CENTRO'), 'Rafael Duque de Freitas', 'rafaelf@defensoria.ms.def.br', false, false, NULL, NULL),
('2ª Defensoria Pública Cível de Coxim', (SELECT id FROM unidades WHERE nome = 'COXIM | CENTRO'), NULL, NULL, false, true, 'Rafael Duque de Freitas', 'rafaelf@defensoria.ms.def.br'),
('1ª Defensoria Pública Criminal de Coxim', (SELECT id FROM unidades WHERE nome = 'COXIM | CENTRO'), 'Stebbin Athaides Roberto da Silva', 'stebbinr@defensoria.ms.def.br', false, false, NULL, NULL);

-- DEODÁPOLIS | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Deodápolis', (SELECT id FROM unidades WHERE nome = 'DEODÁPOLIS | FÓRUM'), NULL, NULL, false, true, NULL, NULL);

-- DOIS IRMÃOS DO BURITI | FÓRUM (1 defensoria)
INSERT INTO orgaos (nome, unidade_id, titular_nome, titular_email, titular_afastado, vaga, substituto_nome, substituto_email) VALUES
('Defensoria Pública de Dois Irmãos do Buriti', (SELECT id FROM unidades WHERE nome = 'DOIS IRMÃOS DO BURITI | FÓRUM'), 'Carlúcio Germano da Silva', 'cgsilva@defensoria.ms.def.br', false, false, NULL, NULL);
