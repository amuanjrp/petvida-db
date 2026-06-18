# 🐾 PetVida - Sistema de Banco de Dados para Clínica Veterinária

Um modelo de banco de dados relacional (SQL) desenvolvido para gerenciar as operações diárias de uma clínica veterinária. Este projeto abrange desde o cadastro estruturado de pacientes e profissionais até o agendamento de consultas e controle de faturamento.

## 📌 Visão Geral

O banco de dados **PetVida** foi projetado para centralizar as informações da clínica, garantindo integridade referencial e facilitando a extração de relatórios gerenciais e operacionais por meio de `Views` pré-configuradas.

## 🗄️ Estrutura do Banco de Dados (Tabelas)

O sistema é composto por 6 tabelas principais conectadas por chaves estrangeiras (Foreign Keys):

* **`especies`**: Tabela de domínio para categorizar os tipos de animais atendidos.
* **`veterinarios`**: Cadastro dos profissionais da clínica, incluindo número do CRMV e especialidade.
* **`tutores`**: Dados dos clientes (donos dos pets), incluindo contato e CPF.
* **`animais`**: Ficha dos pacientes. Cada animal está vinculado a uma espécie e a um tutor responsável.
* **`consultas`**: Registro dos atendimentos, relacionando o animal, o veterinário, diagnóstico, valor e o status da consulta.
* **`pagamentos`**: Controle financeiro individual de cada consulta. Registra a forma de pagamento e o status do acerto.

## 📊 Relatórios e Visões (Views)

O script possui 5 `Views` prontas para a extração de relatórios:

1.  **`vw_consultas_completas`**: Cruza todas as tabelas para entregar uma visão unificada de cada consulta (dados do tutor, do pet, do veterinário, valores e status de pagamento).
2.  **`vw_agenda_hoje`**: Filtra e exibe automaticamente apenas as consultas marcadas para a data atual, ordenadas pelo horário de atendimento.
3.  **`vw_faturamento_mensal`**: Agrupa os valores arrecadados por mês, ano e por veterinário, mostrando o montante projetado e o valor efetivamente pago.
4.  **`vw_animais_detalhados`**: Lista todos os animais cadastrados junto aos contatos de seus tutores e apresenta a contagem do total de consultas já realizadas.
5.  **`vw_inadimplentes`**: Lista todas as consultas marcadas como `concluida`, mas cujo pagamento consta como `pendente` ou com registro inexistente.

## 🛠️ Tecnologias Utilizadas
* **Linguagem:** SQL (Compatível com MySQL e MariaDB)