## PetVida DB 🐾

## 📁 Estrutura do Projeto

## O projeto está organizado da seguinte forma:


## petvida-db/
## ├── database/
## │   ├── schema.sql  # Criação do banco de dados e das tabelas
## │   └── seed.sql    # Inserção de dados fictícios para testes
## └── README.md       # Documentação do projeto

## Banco de dados petvida é composto por 6 tabelas interconectadas, todas utilizando AUTO_INCREMENT nas chaves primárias e NOT NULL nos campos obrigatórios.

## Tabelas:

## veterinarios: Registro dos profissionais da clínica.

## Campos: 
## id, 
## nome, 
## crmv (UNIQUE),
## especialidade, 
## telefone.

## tutores: Cadastro dos donos dos pets.

## Campos:  id,  nome,  cpf (UNIQUE), email, telefone.

## especies: Catálogo de espécies atendidas.

## Campos:  id,  nome (UNIQUE) — Pré-populado com Cachorro, Gato, Pássaro, Peixe, Réptil.

## animais: Dados dos pacientes da clínica.

## Campos: id, nome, especie_id (FK), raça, data_nascimento, tutor_id (FK).

## consultas: Histórico e agendamento de atendimentos.

## Campos:  id,  animal_id (FK), veterinario_id (FK), data_hora (INDEX), diagnostico, valor, status (ENUM: 'agendada', 'em_atendimento', 'concluida', 'cancelada').

## pagamentos: Fluxo financeiro das consultas.

## Campos: id, consulta_id (FK UNIQUE), valor_pago, forma_pagamento (ENUM: 'pix', 'cartao', 'dinheiro', 'convenio'), data_pagamento, status (ENUM: 'pago', 'pendente', 'cancelado').