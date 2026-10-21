-- OFICINADF : B5 - SEGURANCA E CONTROLE DE ACESSO
-- Executar como root (ou conta com privilegios de administracao).
-- Pre-requisito: banco oficinadf e tabelas operacionais ja criados.
-- Os testes de acesso negado devem ser executados em outro arquivo,
-- conectando-se com as contas restritas.

USE oficinadf;
-- 0. Verificação de carga

-- Verificar o banco selecionado
SELECT DATABASE() AS banco_atual;

-- Verificar a quantidade de registros
SELECT
    (SELECT COUNT(*) FROM cliente) AS clientes,
    (SELECT COUNT(*) FROM veiculo) AS veiculos,
    (SELECT COUNT(*) FROM funcionario) AS funcionarios,
    (SELECT COUNT(*) FROM demanda) AS demandas,
    (SELECT COUNT(*) FROM pagamento) AS pagamentos;

-- Verificar os status das demandas
SELECT status, COUNT(*) AS quantidade
FROM demanda
GROUP BY status;

-- 1. PERFIS MYSQL
CREATE ROLE IF NOT EXISTS 'perfil_administrador';
CREATE ROLE IF NOT EXISTS 'perfil_atendente';
CREATE ROLE IF NOT EXISTS 'perfil_consulta';

-- 2. ADMINISTRADOR: operacoes nas tabelas necessarias ao sistema.
-- Nao conceder privilegios gerais em oficinadf.*.
GRANT SELECT, INSERT, UPDATE, DELETE ON oficinadf.cliente TO 'perfil_administrador';
GRANT SELECT, INSERT, UPDATE, DELETE ON oficinadf.veiculo TO 'perfil_administrador';
GRANT SELECT, INSERT, UPDATE, DELETE ON oficinadf.funcionario TO 'perfil_administrador';
GRANT SELECT, INSERT, UPDATE, DELETE ON oficinadf.demanda TO 'perfil_administrador';
GRANT SELECT, INSERT, UPDATE, DELETE ON oficinadf.pagamento TO 'perfil_administrador';

-- Historico de auditoria: somente leitura, se as tabelas B6 ja existirem.

-- Execute as duas linhas seguintes APOS criar as tabelas de auditoria:

-- GRANT SELECT ON oficinadf.auditoria_cliente TO 'perfil_administrador';

-- GRANT SELECT ON oficinadf.auditoria_pagamento TO 'perfil_administrador';

-- 3. ATENDENTE: cliente e veiculo (consultar, cadastrar e editar);
-- demanda (consultar e cadastrar). Sem exclusao.

GRANT SELECT, INSERT, UPDATE
ON oficinadf.cliente
TO 'perfil_atendente';

GRANT SELECT, INSERT, UPDATE
ON oficinadf.veiculo
TO 'perfil_atendente';

-- Concessao inicial
GRANT SELECT, INSERT, UPDATE
ON oficinadf.demanda
TO 'perfil_atendente';

-- Revogacao da permissao de alteracao
REVOKE UPDATE
ON oficinadf.demanda
FROM 'perfil_atendente';

-- 4. VIEW RESTRITA: somente as colunas necessarias a consulta.
CREATE OR REPLACE VIEW oficinadf.vw_consulta_demandas AS
SELECT id_demanda, status, data_hora_abertura
FROM oficinadf.demanda;

GRANT SELECT ON oficinadf.vw_consulta_demandas TO 'perfil_consulta';

-- 5. VERIFICACAO ADMINISTRATIVA
SHOW GRANTS FOR 'perfil_administrador';
SHOW GRANTS FOR 'perfil_atendente';
SHOW GRANTS FOR 'perfil_consulta';
SELECT id_demanda, status, data_hora_abertura
FROM oficinadf.vw_consulta_demandas
LIMIT 5;

