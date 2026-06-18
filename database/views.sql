USE petvida;

# 1) vw_consultas_completas

CREATE OR REPLACE VIEW vw_consultas_completas AS
SELECT 
    c.data_hora,
    c.status AS status_consulta,
    c.diagnostico,
    c.valor AS valor_consulta,
    a.nome AS animal,
    e.nome AS especie,
    t.nome AS tutor,
    t.telefone AS telefone_tutor,
    v.nome AS veterinario,
    v.especialidade,
    p.forma_pagamento,
    p.status AS status_pagamento
FROM consultas c
JOIN animais a ON c.animal_id = a.id
JOIN especies e ON a.especie_id = e.id
JOIN tutores t ON a.tutor_id = t.id
JOIN veterinarios v ON c.veterinario_id = v.id
LEFT JOIN pagamentos p ON p.consulta_id = c.id;

# 2) vw_agenda_hoje
CREATE OR REPLACE VIEW vw_agenda_hoje AS
SELECT 
    TIME(data_hora) AS hora,
    animal,
    especie,
    tutor,
    veterinario,
    status_consulta
FROM vw_consultas_completas
WHERE DATE(data_hora) = CURDATE()
ORDER BY data_hora ASC;

# 3) vw_faturamento_mensal
CREATE OR REPLACE VIEW vw_faturamento_mensal AS
SELECT 
    YEAR(c.data_hora) AS ano,
    MONTH(c.data_hora) AS mes,
    v.nome AS veterinario,
    v.especialidade,
    COUNT(c.id) AS qtd_consultas,
    SUM(c.valor) AS valor_total_procedimentos,
    SUM(CASE WHEN p.status = 'pago' THEN p.valor_pago ELSE 0 END) AS valor_efetivamente_pago
FROM consultas c
JOIN veterinarios v ON c.veterinario_id = v.id
LEFT JOIN pagamentos p ON p.consulta_id = c.id
GROUP BY YEAR(c.data_hora), MONTH(c.data_hora), v.id, v.nome, v.especialidade;

# 4) vw_animais_detalhados
CREATE OR REPLACE VIEW vw_animais_detalhados AS
SELECT 
    a.id AS animal_id,
    a.nome AS nome_animal,
    a.raca,
    e.nome AS especie,
    t.nome AS nome_tutor,
    t.telefone AS telefone_tutor,
    COUNT(c.id) AS total_consultas_realizadas
FROM animais a
JOIN especies e ON a.especie_id = e.id
JOIN tutores t ON a.tutor_id = t.id
LEFT JOIN consultas c ON c.animal_id = a.id
GROUP BY a.id, a.nome, a.raca, e.nome, t.nome, t.telefone;

# 5) vw_inadimplentes
CREATE OR REPLACE VIEW vw_inadimplentes AS
SELECT 
    c.id AS consulta_id,
    c.data_hora AS data_atendimento,
    c.valor AS valor_devido,
    a.nome AS animal,
    t.nome AS tutor,
    t.telefone AS telefone_tutor,
    CASE 
        WHEN p.id IS NULL THEN 'Não Gerado (Sem registro)'
        ELSE 'Pendente'
    END AS situacao_financeira
FROM consultas c
JOIN animais a ON c.animal_id = a.id
JOIN tutores t ON a.tutor_id = t.id
LEFT JOIN pagamentos p ON p.consulta_id = c.id
WHERE c.status = 'concluida' 
  AND (p.status = 'pendente' OR p.id IS NULL);