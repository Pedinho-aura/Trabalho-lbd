-- OFICINADF - B4: OTIMIZACAO DE CONSULTAS
-- OBJETIVO: Verificar o ambiente, volume de dados e indices existentes antes da otimizacao.

USE oficinadf;

-- 01. Identificacao do ambiente
SELECT
    DATABASE() AS banco_atual,
    VERSION() AS versao_mysql;

-- 02. Quantidade de registros nas tabelas candidatas
SELECT 'demanda' AS tabela, COUNT(*) AS registros
FROM demanda

UNION ALL

SELECT 'pagamento', COUNT(*)
FROM pagamento

UNION ALL

SELECT 'movimentacao_estoque', COUNT(*)
FROM movimentacao_estoque

UNION ALL

SELECT 'executa', COUNT(*)
FROM executa

UNION ALL

SELECT 'veiculo', COUNT(*)
FROM veiculo

UNION ALL

SELECT 'cliente', COUNT(*)
FROM cliente;

-- 03. Distribuicao dos status das demandas
SELECT
    status,
    COUNT(*) AS quantidade
FROM demanda
GROUP BY status
ORDER BY quantidade DESC;

-- 04. Indices existentes na tabela demanda
SHOW INDEX FROM demanda;

-- 05. Indices existentes na tabela pagamento
SHOW INDEX FROM pagamento;

-- 06. Indices existentes na tabela movimentacao_estoque
SHOW INDEX FROM movimentacao_estoque;

-- 07. Indices existentes na tabela executa
SHOW INDEX FROM executa;

-- 08. Indices existentes na tabela veiculo
SHOW INDEX FROM veiculo;

