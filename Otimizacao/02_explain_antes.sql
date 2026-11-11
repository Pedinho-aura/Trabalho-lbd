-- OFICINADF - B4: OTIMIZACAO DE CONSULTAS
-- OBJETIVO: Registrar os planos e tempos de execucao antes da criacao dos indices compostos.


USE oficinadf;

-- CONSULTA 01: Demandas por status e periodo

EXPLAIN
SELECT
    id_demanda,
    status,
    data_hora_abertura,
    placa
FROM demanda
WHERE status = 'Pendente'
  AND data_hora_abertura >= '2020-01-01'
  AND data_hora_abertura < '2030-01-01'
ORDER BY data_hora_abertura;

EXPLAIN ANALYZE
SELECT
    id_demanda,
    status,
    data_hora_abertura,
    placa
FROM demanda
WHERE status = 'Pendente'
  AND data_hora_abertura >= '2020-01-01'
  AND data_hora_abertura < '2030-01-01'
ORDER BY data_hora_abertura;


-- CONSULTA 02: Pagamentos por demanda e periodo

SET @demanda_teste = (
    SELECT id_demanda
    FROM pagamento
    GROUP BY id_demanda
    ORDER BY COUNT(*) DESC, id_demanda
    LIMIT 1
);

SELECT @demanda_teste AS demanda_utilizada;

EXPLAIN
SELECT
    id_pagamento,
    id_demanda,
    valor_pagamento,
    data_pagamento
FROM pagamento
WHERE id_demanda = @demanda_teste
  AND data_pagamento >= '2020-01-01'
  AND data_pagamento < '2030-01-01'
ORDER BY data_pagamento;

EXPLAIN ANALYZE
SELECT
    id_pagamento,
    id_demanda,
    valor_pagamento,
    data_pagamento
FROM pagamento
WHERE id_demanda = @demanda_teste
  AND data_pagamento >= '2020-01-01'
  AND data_pagamento < '2030-01-01'
ORDER BY data_pagamento;


-- CONSULTA 03: Movimentacoes por item e periodo

SET @item_teste = (
    SELECT id_item
    FROM movimentacao_estoque
    GROUP BY id_item
    ORDER BY COUNT(*) DESC, id_item
    LIMIT 1
);

SELECT @item_teste AS item_utilizado;

EXPLAIN
SELECT
    id_item,
    id_mov,
    data_entrada,
    data_saida
FROM movimentacao_estoque
WHERE id_item = @item_teste
  AND data_entrada >= '2020-01-01'
  AND data_entrada < '2030-01-01'
ORDER BY data_entrada;

EXPLAIN ANALYZE
SELECT
    id_item,
    id_mov,
    data_entrada,
    data_saida
FROM movimentacao_estoque
WHERE id_item = @item_teste
  AND data_entrada >= '2020-01-01'
  AND data_entrada < '2030-01-01'
ORDER BY data_entrada;
