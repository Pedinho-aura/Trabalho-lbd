
USE oficinadf;

CREATE OR REPLACE VIEW vw_relatorio_consolidado_cliente AS
SELECT
    c.id_cliente,
    c.nome AS cliente,

    COUNT(DISTINCT v.placa) AS qtd_veiculos,
    COUNT(d.id_demanda) AS qtd_demandas,

    COALESCE(
        SUM(d.status = 'Pendente'), 0
    ) AS qtd_pendentes,

    COALESCE(
        SUM(d.status = 'Finalizado'), 0
    ) AS qtd_finalizadas,

    COALESCE(
        SUM(pg.total_pago), 0
    ) AS valor_total_pago,

    COALESCE(
        SUM(pg.total_pago) /
        NULLIF(COUNT(pg.id_demanda), 0),
        0
    ) AS ticket_medio,

    MAX(d.data_hora_abertura) AS ultima_demanda

FROM cliente c

LEFT JOIN veiculo v
    ON v.id_cliente = c.id_cliente

LEFT JOIN demanda d
    ON d.placa = v.placa

LEFT JOIN (
    SELECT
        id_demanda,
        SUM(valor_pagamento) AS total_pago
    FROM pagamento
    GROUP BY id_demanda
) pg
    ON pg.id_demanda = d.id_demanda

GROUP BY
    c.id_cliente,
    c.nome;


