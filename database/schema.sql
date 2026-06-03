-- Criação e uso do banco de dados
CREATE DATABASE IF NOT EXISTS petvida;
USE petvida;

-- 1. Tabela de Espécies
CREATE TABLE especies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Tabela de Veterinários
CREATE TABLE veterinarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crmv VARCHAR(20) NOT NULL UNIQUE,
    especialidade VARCHAR(100),
    telefone VARCHAR(20) NOT NULL
);

-- 3. Tabela de Tutores
CREATE TABLE tutores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

-- 4. Tabela de Animais
CREATE TABLE animais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especie_id INT NOT NULL,
    raca VARCHAR(50),
    data_nascimento DATE,
    tutor_id INT NOT NULL,
    FOREIGN KEY (especie_id) REFERENCES especies(id),
    FOREIGN KEY (tutor_id) REFERENCES tutores(id)
);

-- 5. Tabela de Consultas
CREATE TABLE consultas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    animal_id INT NOT NULL,
    veterinario_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    diagnostico TEXT,
    valor DECIMAL(10,2) NOT NULL,
    status ENUM('agendada', 'em_atendimento', 'concluida', 'cancelada') NOT NULL,
    INDEX idx_data_hora (data_hora),
    FOREIGN KEY (animal_id) REFERENCES animais(id),
    FOREIGN KEY (veterinario_id) REFERENCES veterinarios(id)
);

-- 6. Tabela de Pagamentos
CREATE TABLE pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    consulta_id INT NOT NULL UNIQUE,
    valor_pago DECIMAL(10,2) NOT NULL,
    forma_pagamento ENUM('pix', 'cartao', 'dinheiro', 'convenio') NOT NULL,
    data_pagamento DATETIME,
    status ENUM('pago', 'pendente', 'cancelado') NOT NULL,
    FOREIGN KEY (consulta_id) REFERENCES consultas(id)
);