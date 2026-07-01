USE petvida;

DELIMITER $$

CREATE PROCEDURE sp_agendar_consulta(
    IN p_animal_id INT,
    IN p_veterinario_id INT,
    IN p_data_hora DATETIME,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro interno: Transação de agendamento cancelada.';
    END;

    
    IF NOT EXISTS (SELECT 1 FROM animais WHERE id = p_animal_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Animal não encontrado.';
    END IF;

    
    IF NOT EXISTS (SELECT 1 FROM veterinarios WHERE id = p_veterinario_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Veterinário não encontrado.';
    END IF;

    
    IF EXISTS (SELECT 1 FROM consultas WHERE veterinario_id = p_veterinario_id AND data_hora = p_data_hora AND status != 'cancelada') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: O veterinário já possui um agendamento neste horário.';
    END IF;

    
    START TRANSACTION;
        
       
        INSERT INTO consultas (animal_id, veterinario_id, data_hora, valor, status)
        VALUES (p_animal_id, p_veterinario_id, p_data_hora, p_valor, 'agendada');
        
        
        SET @v_consulta_id = LAST_INSERT_ID();
        
        INSERT INTO pagamentos (consulta_id, valor_pago, forma_pagamento, data_pagamento, status)
        VALUES (@v_consulta_id, 0.00, 'pix', NULL, 'pendente');
        
    COMMIT;
END$$

CREATE PROCEDURE sp_concluir_consulta(
    IN p_consulta_id INT,
    IN p_diagnostico TEXT
)
BEGIN
    
    IF NOT EXISTS (SELECT 1 FROM consultas WHERE id = p_consulta_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Consulta não encontrada.';
    END IF;

    
    UPDATE consultas 
    SET status = 'concluida', 
        diagnostico = p_diagnostico 
    WHERE id = p_consulta_id;
END$$

CREATE PROCEDURE sp_registrar_pagamento(
    IN p_consulta_id INT,
    IN p_forma_pagamento ENUM('pix', 'cartao', 'dinheiro', 'convenio')
)
BEGIN
    DECLARE v_status_atual ENUM('pago', 'pendente', 'cancelado');
    DECLARE v_valor_devido DECIMAL(10,2);

    
    SELECT p.status, c.valor INTO v_status_atual, v_valor_devido 
    FROM consultas c
    LEFT JOIN pagamentos p ON p.consulta_id = c.id
    WHERE c.id = p_consulta_id;
    
    
    IF v_status_atual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Registro de pagamento não encontrado.';
    END IF;

    IF v_status_atual = 'pago' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Esta consulta já foi paga.';
    END IF;
    
    IF v_status_atual = 'cancelado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Não é possível registrar pagamento para uma consulta cancelada.';
    END IF;

    
    UPDATE pagamentos 
    SET status = 'pago', 
        forma_pagamento = p_forma_pagamento,
        valor_pago = v_valor_devido,
        data_pagamento = NOW()
    WHERE consulta_id = p_consulta_id;
END$$

CREATE PROCEDURE sp_cancelar_consulta(
    IN p_consulta_id INT
)
BEGIN
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro interno: Falha ao cancelar consulta.';
    END;

    
    IF NOT EXISTS (SELECT 1 FROM consultas WHERE id = p_consulta_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Consulta não encontrada.';
    END IF;

   
    START TRANSACTION;
        
        
        UPDATE consultas 
        SET status = 'cancelada' 
        WHERE id = p_consulta_id;
        
        
        UPDATE pagamentos 
        SET status = 'cancelado' 
        WHERE consulta_id = p_consulta_id;
        
    COMMIT;
END$$

CREATE PROCEDURE sp_cadastrar_animal(
    IN p_nome VARCHAR(100),
    IN p_especie_id INT,
    IN p_raca VARCHAR(50),
    IN p_data_nascimento DATE,
    IN p_tutor_id INT,
    OUT p_novo_id INT
)
BEGIN
    
    IF NOT EXISTS (SELECT 1 FROM tutores WHERE id = p_tutor_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Tutor não encontrado.';
    END IF;

    
    IF NOT EXISTS (SELECT 1 FROM especies WHERE id = p_especie_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Espécie não encontrada.';
    END IF;

    
    INSERT INTO animais (nome, especie_id, raca, data_nascimento, tutor_id)
    VALUES (p_nome, p_especie_id, p_raca, p_data_nascimento, p_tutor_id);

    SET p_novo_id = LAST_INSERT_ID();
END$$

DELIMITER ;