CREATE DATABASE IF NOT EXISTS petvida;

USE petvida;

DELIMITER $$

DROP FUNCTION IF EXISTS fn_idade_animal$$

CREATE FUNCTION fn_idade_animal(p_data_nascimento DATE)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_anos INT;
    DECLARE v_meses INT;

    SET v_anos = TIMESTAMPDIFF(YEAR, p_data_nascimento, CURDATE());
    SET v_meses = TIMESTAMPDIFF(MONTH, p_data_nascimento, CURDATE()) - v_anos * 12;

    RETURN CONCAT(v_anos, ' anos e ', v_meses, ' meses');
END$$

DROP FUNCTION IF EXISTS fn_total_gasto_tutor$$

CREATE FUNCTION fn_total_gasto_tutor(p_tutor_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN IFNULL(
        (
            SELECT SUM(c.valor)
            FROM consultas c
            JOIN animais a ON c.animal_id = a.id
            WHERE a.tutor_id = p_tutor_id
              AND c.status <> 'cancelada'
        ), 0.00
    );
END$$

DROP FUNCTION IF EXISTS fn_qtd_consultas_animal$$

CREATE FUNCTION fn_qtd_consultas_animal(p_animal_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM consultas
        WHERE animal_id = p_animal_id
    );
END$$
DROP FUNCTION IF EXISTS fn_classificar_valor$$

CREATE FUNCTION fn_classificar_valor(p_valor DECIMAL(10,2))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN p_valor < 100 THEN 'Consulta Simples'
        WHEN p_valor <= 300 THEN 'Consulta Padrão'
        ELSE 'Procedimento Especial'
    END;
END$$

DELIMITER;

