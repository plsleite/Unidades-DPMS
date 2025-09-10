-- ==============================================
-- SCRIPT PARA ATUALIZAR VACÂNCIAS DAS DEFENSORIAS
-- ==============================================
-- 
-- Este script atualiza as defensorias com informações de vacância
-- incluindo data de vacância e portaria que ensejou a vacância
--
-- INSTRUÇÕES:
-- 1. Execute este script no pgAdmin4
-- 2. As defensorias serão marcadas como vagas (vaga = true)
-- 3. Data de vacância e portaria serão preenchidas conforme lista
--
-- ==============================================

-- Atualizar defensorias com informações de vacância
-- Formato: UPDATE orgaos SET vaga = true, data_vacancia = 'YYYY-MM-DD', portaria_vacancia = 'Portaria' WHERE nome = 'Nome da Defensoria';

-- 1. 19ª Defensoria Pública Cível de Segunda Instância – 04.10.2022 –
UPDATE orgaos SET vaga = true, data_vacancia = '2022-10-04', portaria_vacancia = NULL WHERE nome = '19ª Defensoria Pública Cível de Segunda Instância';

-- 2. 9ª Defensoria Pública Cível de Segunda Instância – 04.12.2024 – Portaria "D" 016/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-12-04', portaria_vacancia = 'Portaria "D" 016/2024' WHERE nome = '9ª Defensoria Pública Cível de Segunda Instância';

-- 3. 6ª Defensoria Pública de Família e Sucessões de Campo Grande – 05.10.2021 – Portaria "D" 042/2021
UPDATE orgaos SET vaga = true, data_vacancia = '2021-10-05', portaria_vacancia = 'Portaria "D" 042/2021' WHERE nome = '6ª Defensoria Pública de Família e Sucessões de Campo Grande';

-- 4. 9ª Defensoria Pública Criminal de Campo Grande – 03.04.2023 – Portaria "D" 007/2023
UPDATE orgaos SET vaga = true, data_vacancia = '2023-04-03', portaria_vacancia = 'Portaria "D" 007/2023' WHERE nome = '9ª Defensoria Pública Criminal de Campo Grande';

-- 5. 5ª Defensoria Pública de Família e Sucessões de Campo Grande – 03.04.2023 – Portaria "D" 008/2023
UPDATE orgaos SET vaga = true, data_vacancia = '2023-04-03', portaria_vacancia = 'Portaria "D" 008/2023' WHERE nome = '5ª Defensoria Pública de Família e Sucessões de Campo Grande';

-- 6. 1ª Defensoria Pública Cível de Corumbá – 03.04.2023 – Portaria "D" 010/2023
UPDATE orgaos SET vaga = true, data_vacancia = '2023-04-03', portaria_vacancia = 'Portaria "D" 010/2023' WHERE nome = '1ª Defensoria Pública Cível de Corumbá';

-- 7. 2ª Defensoria Pública Cível de Corumbá – 03.03.2017 –
UPDATE orgaos SET vaga = true, data_vacancia = '2017-03-03', portaria_vacancia = NULL WHERE nome = '2ª Defensoria Pública Cível de Corumbá';

-- 8. 2ª Defensoria Pública de Família e Sucessões de Dourados – 05.03.2024 – Portaria "D" 004/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-03-05', portaria_vacancia = 'Portaria "D" 004/2024' WHERE nome = '2ª Defensoria Pública de Família e Sucessões de Dourados';

-- 9. 2ª Defensoria Pública Criminal de Corumbá – 19.06.2024 – Portaria "D" 007/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-06-19', portaria_vacancia = 'Portaria "D" 007/2024' WHERE nome = '2ª Defensoria Pública Criminal de Corumbá';

-- 10. 1ª Defensoria Pública de Fazenda Pública, Moradia e Direitos Sociais de Campo Grande – 11.09.2024 – Portaria "D" 013/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-09-11', portaria_vacancia = 'Portaria "D" 013/2024' WHERE nome = '1ª Defensoria Pública de Fazenda Pública, Moradia e Direitos Sociais de Campo Grande';

-- 11. 3ª Defensoria Pública Criminal de Corumbá – 04.12.2024 – Portaria "D" 019/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-12-04', portaria_vacancia = 'Portaria "D" 019/2024' WHERE nome = '3ª Defensoria Pública Criminal de Corumbá';

-- 12. 8ª Defensoria Pública de Execução Penal de Campo Grande – 06.01.2025 –
UPDATE orgaos SET vaga = true, data_vacancia = '2025-01-06', portaria_vacancia = NULL WHERE nome = '8ª Defensoria Pública de Execução Penal de Campo Grande';

-- 13. Defensoria Pública de Atendimento à Mulher de Corumbá – 07.04.2025 – Portaria "D" 006/2025
UPDATE orgaos SET vaga = true, data_vacancia = '2025-04-07', portaria_vacancia = 'Portaria "D" 006/2025' WHERE nome = 'Defensoria Pública de Atendimento à Mulher de Corumbá';

-- 14. 17ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais de Campo Grande – 23.06.2025 – Portaria "D" 014/2025
UPDATE orgaos SET vaga = true, data_vacancia = '2025-06-23', portaria_vacancia = 'Portaria "D" 014/2025' WHERE nome = '17ª Defensoria Pública de Promoção e Defesa do Consumidor e Demais Matérias Cíveis Residuais de Campo Grande';

-- 15. 1ª Defensoria Pública Cível de Paranaíba – 03.08.2021 – Portaria "D" 030/2021
UPDATE orgaos SET vaga = true, data_vacancia = '2021-08-03', portaria_vacancia = 'Portaria "D" 030/2021' WHERE nome = '1ª Defensoria Pública Cível de Paranaíba';

-- 16. 2ª Defensoria Pública Cível de Amambai – 03.08.2021 – Portaria "D" 036/2021
UPDATE orgaos SET vaga = true, data_vacancia = '2021-08-03', portaria_vacancia = 'Portaria "D" 036/2021' WHERE nome = '2ª Defensoria Pública Cível de Amambai';

-- 17. 1ª Defensoria Pública de São Gabriel do Oeste – 05.10.2021 – Portaria "D" 040/2021
UPDATE orgaos SET vaga = true, data_vacancia = '2021-10-05', portaria_vacancia = 'Portaria "D" 040/2021' WHERE nome = '1ª Defensoria Pública de São Gabriel do Oeste';

-- 18. 2ª Defensoria Pública de São Gabriel do Oeste – 05.10.2021 – Portaria "D" 041/2021
UPDATE orgaos SET vaga = true, data_vacancia = '2021-10-05', portaria_vacancia = 'Portaria "D" 041/2021' WHERE nome = '2ª Defensoria Pública de São Gabriel do Oeste';

-- 19. Defensoria Pública Cível de Rio Brilhante – 30.03.2023 –
UPDATE orgaos SET vaga = true, data_vacancia = '2023-03-30', portaria_vacancia = NULL WHERE nome = 'Defensoria Pública Cível de Rio Brilhante';

-- 20. 3ª Defensoria Pública Cível de Ponta Porã – 03.04.2023 – Portaria "D" 009/2023
UPDATE orgaos SET vaga = true, data_vacancia = '2023-04-03', portaria_vacancia = 'Portaria "D" 009/2023' WHERE nome = '3ª Defensoria Pública Cível de Ponta Porã';

-- 21. 2ª Defensoria Pública de Maracaju – 10.05.2023 – Portaria "D" 011/2023
UPDATE orgaos SET vaga = true, data_vacancia = '2023-05-10', portaria_vacancia = 'Portaria "D" 011/2023' WHERE nome = '2ª Defensoria Pública de Maracaju';

-- 22. 1ª Defensoria Pública de Costa Rica – 02.10.2023 – Portaria "D" 015/2023
UPDATE orgaos SET vaga = true, data_vacancia = '2023-10-02', portaria_vacancia = 'Portaria "D" 015/2023' WHERE nome = '1ª Defensoria Pública de Costa Rica';

-- 23. 2ª Defensoria Pública de Ribas do Rio Pardo – 09.10.2023 –
UPDATE orgaos SET vaga = true, data_vacancia = '2023-10-09', portaria_vacancia = NULL WHERE nome = '2ª Defensoria Pública de Ribas do Rio Pardo';

-- 24. Defensoria Pública de Itaporã – 05.03.2024 – Portaria "D" 003/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-03-05', portaria_vacancia = 'Portaria "D" 003/2024' WHERE nome = 'Defensoria Pública de Itaporã';

-- 25. 2ª Defensoria Pública de Aparecida do Taboado – 19.06.2024 – Portaria "D" 005/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-06-19', portaria_vacancia = 'Portaria "D" 005/2024' WHERE nome = '2ª Defensoria Pública de Aparecida do Taboado';

-- 26. 2ª Defensoria Pública de Miranda – 19.06.2024 – Portaria "D" 006/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-06-19', portaria_vacancia = 'Portaria "D" 006/2024' WHERE nome = '2ª Defensoria Pública de Miranda';

-- 27. 1ª Defensoria Pública de Jardim – 19.06.2024 – Portaria "D" 010/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-06-19', portaria_vacancia = 'Portaria "D" 010/2024' WHERE nome = '1ª Defensoria Pública de Jardim';

-- 28. 2ª Defensoria Pública Cível de Ponta Porã – 11.09.2024 – Portaria "D" 011/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-09-11', portaria_vacancia = 'Portaria "D" 011/2024' WHERE nome = '2ª Defensoria Pública Cível de Ponta Porã';

-- 29. 2ª Defensoria Pública de Coxim – 11.09.2024 – Portaria "D" 012/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-09-11', portaria_vacancia = 'Portaria "D" 012/2024' WHERE nome = '2ª Defensoria Pública de Coxim';

-- 30. 1ª Defensoria Pública de Bonito – 23.10.2024 – Portaria "D" n. 1.133/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-10-23', portaria_vacancia = 'Portaria "D" n. 1.133/2024' WHERE nome = '1ª Defensoria Pública de Bonito';

-- 31. Defensoria Pública de Iguatemi – 22.06.2020 – Portaria "D" 013/2020
UPDATE orgaos SET vaga = true, data_vacancia = '2020-06-22', portaria_vacancia = 'Portaria "D" 013/2020' WHERE nome = 'Defensoria Pública de Iguatemi';

-- 32. 2ª Defensoria Pública de Cassilândia – 01.10.2020 – Portaria "D" 026/2020
UPDATE orgaos SET vaga = true, data_vacancia = '2020-10-01', portaria_vacancia = 'Portaria "D" 026/2020' WHERE nome = '2ª Defensoria Pública de Cassilândia';

-- 33. 1ª Defensoria Pública Criminal de Coxim – 04.12.2024 – Portaria "D" 017/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-12-04', portaria_vacancia = 'Portaria "D" 017/2024' WHERE nome = '1ª Defensoria Pública Criminal de Coxim';

-- 34. 1ª Defensoria Pública Cível de Sidrolândia – 04.12.2024 – Portaria "D" 018/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-12-04', portaria_vacancia = 'Portaria "D" 018/2024' WHERE nome = '1ª Defensoria Pública Cível de Sidrolândia';

-- 35. 2ª Defensoria Pública de Caarapó – 04.12.2024 – Portaria "D" 020/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-12-04', portaria_vacancia = 'Portaria "D" 020/2024' WHERE nome = '2ª Defensoria Pública de Caarapó';

-- 36. 1ª Defensoria Pública de Caarapó – 12.12.2024 –
UPDATE orgaos SET vaga = true, data_vacancia = '2024-12-12', portaria_vacancia = NULL WHERE nome = '1ª Defensoria Pública de Caarapó';

-- 37. 1ª Defensoria Pública de Cassilândia – 07.04.2025 – Portaria "D" 004/2025
UPDATE orgaos SET vaga = true, data_vacancia = '2025-04-07', portaria_vacancia = 'Portaria "D" 004/2025' WHERE nome = '1ª Defensoria Pública de Cassilândia';

-- 38. Defensoria Pública Criminal de Sidrolândia – 07.04.2025 – Portaria "D" 005/2025
UPDATE orgaos SET vaga = true, data_vacancia = '2025-04-07', portaria_vacancia = 'Portaria "D" 005/2025' WHERE nome = 'Defensoria Pública Criminal de Sidrolândia';

-- 39. 1ª Defensoria Pública Criminal de Amambai – 12.05.2024 – Portaria "D" 009/2025
UPDATE orgaos SET vaga = true, data_vacancia = '2024-05-12', portaria_vacancia = 'Portaria "D" 009/2025' WHERE nome = '1ª Defensoria Pública Criminal de Amambai';

-- 40. Defensoria Pública de Porto Murtinho – 02.10.2023 – Portaria "D" 012/2023
UPDATE orgaos SET vaga = true, data_vacancia = '2023-10-02', portaria_vacancia = 'Portaria "D" 012/2023' WHERE nome = 'Defensoria Pública de Porto Murtinho';

-- 41. Defensoria Pública de Eldorado – 02.10.2023 – Portaria "D" 014/2023
UPDATE orgaos SET vaga = true, data_vacancia = '2023-10-02', portaria_vacancia = 'Portaria "D" 014/2023' WHERE nome = 'Defensoria Pública de Eldorado';

-- 42. Defensoria Pública de Deodápolis – 19.06.2024 – Portaria "D" 008/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-06-19', portaria_vacancia = 'Portaria "D" 008/2024' WHERE nome = 'Defensoria Pública de Deodápolis';

-- 43. Defensoria Pública de Inocência – 19.06.2024 – Portaria "D" 009/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-06-19', portaria_vacancia = 'Portaria "D" 009/2024' WHERE nome = 'Defensoria Pública de Inocência';

-- 44. Defensoria Pública de Sete Quedas – 11.09.2024 – Portaria "D" 014/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-09-11', portaria_vacancia = 'Portaria "D" 014/2024' WHERE nome = 'Defensoria Pública de Sete Quedas';

-- 45. Defensoria Pública de Nioaque – 11.09.2024 – Portaria "D" 015/2024
UPDATE orgaos SET vaga = true, data_vacancia = '2024-09-11', portaria_vacancia = 'Portaria "D" 015/2024' WHERE nome = 'Defensoria Pública de Nioaque';

-- 46. Defensoria Pública de Pedro Gomes – 12.05.2025 – Portaria "D" 007/2025
UPDATE orgaos SET vaga = true, data_vacancia = '2025-05-12', portaria_vacancia = 'Portaria "D" 007/2025' WHERE nome = 'Defensoria Pública de Pedro Gomes';

-- 47. Defensoria Pública de Anaurilândia – 12.05.2025 – Portaria "D" 008/2025
UPDATE orgaos SET vaga = true, data_vacancia = '2025-05-12', portaria_vacancia = 'Portaria "D" 008/2025' WHERE nome = 'Defensoria Pública de Anaurilândia';

-- Verificar quantas defensorias foram atualizadas
SELECT 
    COUNT(*) as total_atualizadas,
    COUNT(CASE WHEN portaria_vacancia IS NOT NULL THEN 1 END) as com_portaria,
    COUNT(CASE WHEN portaria_vacancia IS NULL THEN 1 END) as sem_portaria
FROM orgaos 
WHERE vaga = true AND data_vacancia IS NOT NULL;

-- Mostrar algumas defensorias atualizadas para verificação
SELECT 
    nome,
    data_vacancia,
    portaria_vacancia,
    CASE WHEN portaria_vacancia IS NULL THEN 'Sem portaria' ELSE 'Com portaria' END as status_portaria
FROM orgaos 
WHERE vaga = true AND data_vacancia IS NOT NULL
ORDER BY data_vacancia DESC
LIMIT 10;
