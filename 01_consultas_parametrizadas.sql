
USE oficinadf;
-- ========================================================
-- CONSULTA PARAMETRIZADA 01
-- Gastos por cliente e quantidade de ordens de serviço
-- ========================================================

PREPARE stmt_gastos_cliente FROM '
    SELECT
        c.nome AS Nome_Cliente,
        COUNT(DISTINCT d.id_demanda) AS Qtd_Ordens_Servico,
        COALESCE(SUM(p.valor_pagamento), 0.00) AS Total_Gasto
    FROM cliente c
    JOIN veiculo v
        ON v.id_cliente = c.id_cliente
    JOIN demanda d
        ON d.placa = v.placa
    LEFT JOIN pagamento p
        ON p.id_demanda = d.id_demanda
    WHERE c.nome LIKE ?
      AND d.data_hora_abertura BETWEEN ? AND ?
    GROUP BY c.id_cliente, c.nome
    ORDER BY Total_Gasto DESC
';

-- Parâmetros de teste
SET @nome_cliente = '%';
SET @data_inicio = '2024-01-01 00:00:00';
SET @data_fim = '2026-12-31 23:59:59';

-- Executar consulta
EXECUTE stmt_gastos_cliente
USING @nome_cliente, @data_inicio, @data_fim;

-- Liberar consulta preparada
DEALLOCATE PREPARE stmt_gastos_cliente;

-- ========================================================
-- CONSULTA PARAMETRIZADA 02
-- Movimentações de peças por categoria
-- ========================================================

PREPARE stmt_movimentacao_pecas FROM '
    SELECT
        i.id_item AS Codigo_Peca,
        i.id_categoria AS Codigo_Categoria,
        COUNT(m.id_mov) AS Qtd_Movimentacoes,
        MAX(
            COALESCE(m.data_saida, m.data_entrada)
        ) AS Ultima_Movimentacao
    FROM item_estoque i
    JOIN peca p
        ON p.id_item = i.id_item
    JOIN movimentacao_estoque m
        ON m.id_item = i.id_item
    WHERE i.id_categoria = ?
      AND (
          m.data_entrada BETWEEN ? AND ?
          OR m.data_saida BETWEEN ? AND ?
      )
    GROUP BY i.id_item, i.id_categoria
    HAVING COUNT(m.id_mov) >= ?
    ORDER BY Qtd_Movimentacoes DESC
';

-- Parâmetros para teste
SET @categoria = 1;
SET @data_inicio = '2024-01-01 00:00:00';
SET @data_fim = '2026-12-31 23:59:59';
SET @min_movimentacoes = 1;

-- Executar consulta
EXECUTE stmt_movimentacao_pecas
USING
    @categoria,
    @data_inicio,
    @data_fim,
    @data_inicio,
    @data_fim,
    @min_movimentacoes;

-- Liberar a consulta preparada
DEALLOCATE PREPARE stmt_movimentacao_pecas;
