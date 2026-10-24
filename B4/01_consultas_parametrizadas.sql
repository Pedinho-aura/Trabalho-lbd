
USE oficinadf;

-- CONSULTA PARAMETRIZADA 01
-- Gastos por cliente e quantidade de ordens de serviço

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


