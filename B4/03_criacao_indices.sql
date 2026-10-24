
-- OFICINADF - B4: OTIMIZACAO DE CONSULTAS
-- OBJETIVO: Criar indices compostos para avaliar melhorias nos planos de execucao.

USE oficinadf;

-- INDICE 01: Demandas por status e data de abertura

-- status: filtro de igualdade.
-- data_hora_abertura: filtro de intervalo e ordenacao.
-- Hipotese: reduzir a necessidade de ordenacao adicional.

CREATE INDEX idx_b4_demanda_status_data
ON demanda (status, data_hora_abertura);



-- INDICE 02: Pagamentos por demanda e data

-- id_demanda: filtro de igualdade.
-- data_pagamento: filtro de intervalo e ordenacao.
-- Hipotese: melhorar a busca e eliminar filesort.

CREATE INDEX idx_b4_pagamento_demanda_data
ON pagamento (id_demanda, data_pagamento);



-- INDICE 03: Movimentacoes por item e data de entrada

-- id_item: filtro de igualdade.
-- data_entrada: filtro de intervalo e ordenacao.
-- Hipotese: melhorar a filtragem e a ordenacao.

CREATE INDEX idx_b4_movimentacao_item_data
ON movimentacao_estoque (id_item, data_entrada);

