USE petvida;

-- Inserindo 5 espécies
INSERT INTO especies (nome) VALUES 
('Cachorro'), ('Gato'), ('Pássaro'), ('Peixe'), ('Réptil');

-- Inserindo 3 veterinários
INSERT INTO veterinarios (nome, crmv, especialidade, telefone) VALUES 
('Dr. Carlos Silva', 'CRMV-12345', 'Clínica Geral', '11999991111'),
('Dra. Ana Costa', 'CRMV-67890', 'Cirurgia', '11999992222'),
('Dr. Marcos Rocha', 'CRMV-11223', 'Animais Silvestres', '11999993333');

-- Inserindo 8 tutores
INSERT INTO tutores (nome, cpf, email, telefone) VALUES 
('João Pereira', '111.111.111-11', 'joao@email.com', '11988881111'),
('Maria Santos', '222.222.222-22', 'maria@email.com', '11988882222'),
('Fernanda Lima', '333.333.333-33', 'fernanda@email.com', '11988883333'),
('Pedro Alves', '444.444.444-44', 'pedro@email.com', '11988884444'),
('Lucas Mendes', '555.555.555-55', 'lucas@email.com', '11988885555'),
('Juliana Dias', '666.666.666-66', 'juliana@email.com', '11988886666'),
('Roberto Nunes', '777.777.777-77', 'roberto@email.com', '11988887777'),
('Camila Souza', '888.888.888-88', 'camila@email.com', '11988888888');

-- Inserindo 15 animais
INSERT INTO animais (nome, especie_id, raca, data_nascimento, tutor_id) VALUES 
('Rex', 1, 'Labrador', '2020-05-10', 1),
('Mia', 2, 'Siamês', '2021-08-15', 2),
('Piu', 3, 'Calopsita', '2022-01-20', 3),
('Nemo', 4, 'Peixe-Palhaço', '2023-03-05', 4),
('Igu', 5, 'Iguana', '2019-11-30', 5),
('Thor', 1, 'Bulldog', '2018-07-12', 6),
('Luna', 2, 'Persa', '2020-09-25', 7),
('Bolinha', 1, 'Poodle', '2015-04-18', 8),
('Simba', 2, 'SRD', '2021-12-01', 1),
('Fred', 3, 'Papagaio', '2010-06-14', 2),
('Mel', 1, 'Golden Retriever', '2022-02-28', 3),
('Dory', 4, 'Blue Tang', '2023-05-10', 4),
('Spike', 5, 'Dragão Barbudo', '2021-10-10', 5),
('Max', 1, 'Pastor Alemão', '2017-03-22', 6),
('Nina', 2, 'Angorá', '2019-08-08', 7);

-- Inserindo 20 consultas
INSERT INTO consultas (animal_id, veterinario_id, data_hora, diagnostico, valor, status) VALUES 
(1, 1, '2024-05-01 09:00:00', 'Checkup de rotina', 150.00, 'concluida'),
(2, 2, '2024-05-02 10:30:00', 'Vacinação', 120.00, 'concluida'),
(3, 3, '2024-05-03 14:00:00', 'Corte de asas', 80.00, 'concluida'),
(4, 3, '2024-05-04 11:00:00', 'Análise de água', 90.00, 'concluida'),
(5, 3, '2024-05-05 16:00:00', 'Troca de pele', 130.00, 'concluida'),
(6, 1, '2024-05-06 09:30:00', 'Dermatite', 200.00, 'concluida'),
(7, 2, '2024-05-07 13:00:00', 'Castração', 500.00, 'concluida'),
(8, 1, '2024-05-08 15:30:00', 'Limpeza de tártaro', 350.00, 'concluida'),
(9, 2, '2024-05-09 10:00:00', 'Suspeita de fratura', 400.00, 'cancelada'),
(10, 3, '2024-05-10 14:30:00', 'Ajuste de bico', 100.00, 'concluida'),
(11, 1, '2024-05-11 08:00:00', 'Exame de sangue', 180.00, 'concluida'),
(12, 3, '2024-05-12 11:30:00', 'Fungo nas barbatanas', 110.00, 'concluida'),
(13, 3, '2024-05-13 16:30:00', 'Falta de apetite', 140.00, 'concluida'),
(14, 1, '2024-05-14 09:00:00', 'Dor articular', 220.00, 'concluida'),
(15, 2, '2024-05-15 13:30:00', 'Otite', 160.00, 'concluida'),
(1, 1, '2024-06-01 10:00:00', 'Retorno checkup', 0.00, 'agendada'),
(2, 2, '2024-06-02 14:00:00', 'Reforço vacina', 120.00, 'agendada'),
(6, 1, '2024-06-03 15:00:00', NULL, 200.00, 'em_atendimento'),
(7, 2, '2024-06-04 09:30:00', 'Retorno castração', 0.00, 'agendada'),
(11, 1, '2024-06-05 11:00:00', NULL, 150.00, 'agendada');

-- Inserindo 20 pagamentos (vinculados ao ID das 20 consultas geradas acima)
INSERT INTO pagamentos (consulta_id, valor_pago, forma_pagamento, data_pagamento, status) VALUES
(1, 150.00, 'pix', '2024-05-01 09:45:00', 'pago'),
(2, 120.00, 'cartao', '2024-05-02 11:00:00', 'pago'),
(3, 80.00, 'dinheiro', '2024-05-03 14:30:00', 'pago'),
(4, 90.00, 'pix', '2024-05-04 11:45:00', 'pago'),
(5, 130.00, 'convenio', '2024-05-05 16:45:00', 'pago'),
(6, 200.00, 'cartao', '2024-05-06 10:00:00', 'pago'),
(7, 500.00, 'pix', '2024-05-07 15:00:00', 'pago'),
(8, 350.00, 'cartao', '2024-05-08 16:30:00', 'pago'),
(9, 400.00, 'pix', NULL, 'cancelado'),
(10, 100.00, 'dinheiro', '2024-05-10 15:00:00', 'pago'),
(11, 180.00, 'convenio', '2024-05-11 08:30:00', 'pago'),
(12, 110.00, 'pix', '2024-05-12 12:00:00', 'pago'),
(13, 140.00, 'cartao', '2024-05-13 17:00:00', 'pago'),
(14, 220.00, 'pix', '2024-05-14 09:45:00', 'pago'),
(15, 160.00, 'cartao', '2024-05-15 14:00:00', 'pago'),
(16, 0.00, 'convenio', '2024-06-01 10:30:00', 'pago'),
(17, 120.00, 'pix', NULL, 'pendente'),
(18, 200.00, 'cartao', NULL, 'pendente'),
(19, 0.00, 'convenio', '2024-06-04 10:00:00', 'pago'),
(20, 150.00, 'dinheiro', NULL, 'pendente');