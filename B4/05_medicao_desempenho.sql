
-- OFICINADF - B4: OTIMIZACAO DE CONSULTAS
-- OBJETIVO: Comparar planos antigos e novos utilizando os mesmos dados e parametros.
--
-- FORCE INDEX permite comparar os caminhos de acesso.
-- Executar cada EXPLAIN ANALYZE varias vezes.
-- Registrar os tempos finais de actual time.

USE oficinadf;

SET @demanda_teste = 3;
SET @item_teste = 2;

-- =========================================================
-- CONSULTA 01: DEMANDAS
-- =========================================================

-- Plano anterior: indice simples
EXPLAIN ANALYZE
SELECT
    id_demanda,
    status,
    data_hora_abertura,
    placa
FROM demanda FORCE INDEX (idx_demanda_status)
WHERE status = 'Pendente'
  AND data_hora_abertura >= '2020-01-01'
  AND data_hora_abertura < '2030-01-01'
ORDER BY data_hora_abertura;

-- Plano otimizado: indice composto
EXPLAIN ANALYZE
SELECT
    id_demanda,
    status,
    data_hora_abertura,
    placa
FROM demanda FORCE INDEX (idx_b4_demanda_status_data)
WHERE status = 'Pendente'
  AND data_hora_abertura >= '2020-01-01'
  AND data_hora_abertura < '2030-01-01'
ORDER BY data_hora_abertura;


-- =========================================================
-- CONSULTA 02: PAGAMENTOS
-- =========================================================

-- Plano anterior: indice simples
EXPLAIN ANALYZE
SELECT
    id_pagamento,
    id_demanda,
    valor_pagamento,
    data_pagamento
FROM pagamento FORCE INDEX (idx_pagamento_demanda)
WHERE id_demanda = @demanda_teste
  AND data_pagamento >= '2020-01-01'
  AND data_pagamento < '2030-01-01'
ORDER BY data_pagamento;

-- Plano otimizado: indice composto
EXPLAIN ANALYZE
SELECT
    id_pagamento,
    id_demanda,
    valor_pagamento,
    data_pagamento
FROM pagamento FORCE INDEX (idx_b4_pagamento_demanda_data)
WHERE id_demanda = @demanda_teste
  AND data_pagamento >= '2020-01-01'
  AND data_pagamento < '2030-01-01'
ORDER BY data_pagamento;


-- =========================================================
-- CONSULTA 03: MOVIMENTACOES DE ESTOQUE
-- =========================================================

-- Plano anterior: chave primaria
EXPLAIN ANALYZE
SELECT
    id_item,
    id_mov,
    data_entrada,
    data_saida
FROM movimentacao_estoque FORCE INDEX (PRIMARY)
WHERE id_item = @item_teste
  AND data_entrada >= '2020-01-01'
  AND data_entrada < '2030-01-01'
ORDER BY data_entrada;

-- Plano otimizado: indice composto
EXPLAIN ANALYZE
SELECT
    id_item,
    id_mov,
    data_entrada,
    data_saida
FROM movimentacao_estoque FORCE INDEX (idx_b4_movimentacao_item_data)
WHERE id_item = @item_teste
  AND data_entrada >= '2020-01-01'
  AND data_entrada < '2030-01-01'
ORDER BY data_entrada;

