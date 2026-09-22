USE oficina_mecanica;


-- CONSULTAS BÁSICAS


-- 01. Listar todos os clientes cadastrados
SELECT


    id_cliente,
    nome
FROM cliente
ORDER BY nome;


-- 02. Listar veículos de um determinado cliente
-- Consulta utilizando WHERE.


SELECT
    placa,
    modelo,
    id_cliente
FROM veiculo
WHERE id_cliente = 10
ORDER BY modelo;


-- 03. Buscar veículos cujo modelo contenha a palavra "Fiat"
-- Consulta utilizando LIKE.


SELECT
    placa,
    modelo
FROM veiculo
WHERE modelo LIKE '%Fiat%'
ORDER BY modelo;


-- 04. Consultar pagamentos dentro de uma faixa de valores
-- Consulta utilizando BETWEEN.


SELECT
    id_pagamento,
    valor_pagamento,
    data_pagamento
FROM pagamento
WHERE valor_pagamento BETWEEN 300.00 AND 700.00
ORDER BY valor_pagamento;


-- 05. Consultar demandas com determinados status
-- Consulta utilizando IN.


SELECT
    id_demanda,
    status,
    data_hora_abertura,
    placa
FROM demanda
WHERE status IN ('ABERTA', 'EM_EXECUCAO')
ORDER BY data_hora_abertura;


-- CONSULTAS COM JOIN E AGREGAÇÃO


-- 06. Listar veículos e seus respectivos clientes
-- Utiliza INNER JOIN.

SELECT
    v.placa,
    v.modelo,
    c.nome AS cliente
FROM veiculo v
INNER JOIN cliente c
    ON v.id_cliente = c.id_cliente
ORDER BY c.nome;


-- 07. Listar demandas, veículos e clientes
-- Consulta envolvendo três tabelas.

SELECT
    d.id_demanda,
    d.status,
    d.data_hora_abertura,
    v.placa,
    v.modelo,
    c.nome AS cliente
FROM demanda d
INNER JOIN veiculo v
    ON d.placa = v.placa
INNER JOIN cliente c
    ON v.id_cliente = c.id_cliente
ORDER BY d.data_hora_abertura;


-- 08. Listar todos os clientes e a quantidade de veículos
-- Utiliza LEFT JOIN e GROUP BY.

SELECT
    c.id_cliente,
    c.nome,
    COUNT(v.placa) AS quantidade_veiculos
FROM cliente c
LEFT JOIN veiculo v
    ON c.id_cliente = v.id_cliente
GROUP BY
    c.id_cliente,
    c.nome
ORDER BY quantidade_veiculos DESC;


-- 09. Total de pagamentos por forma de pagamento
-- Utiliza JOIN, GROUP BY e função de agregação.

SELECT
    fp.descricao AS forma_pagamento,
    COUNT(p.id_pagamento) AS quantidade_pagamentos,
    SUM(p.valor_pagamento) AS valor_total
FROM forma_pagamento fp
INNER JOIN pagamento p
    ON fp.id_forma = p.id_forma
GROUP BY
    fp.id_forma,
    fp.descricao
ORDER BY valor_total DESC;


-- 10. Formas de pagamento com total superior a R$ 1.000
-- Utiliza GROUP BY e HAVING.

SELECT
    fp.descricao AS forma_pagamento,
    SUM(p.valor_pagamento) AS valor_total
FROM forma_pagamento fp
INNER JOIN pagamento p
    ON fp.id_forma = p.id_forma
GROUP BY
    fp.id_forma,
    fp.descricao
HAVING SUM(p.valor_pagamento) > 1000
ORDER BY valor_total DESC;


-- CONSULTAS AVANÇADAS


-- 11. Clientes que possuem pelo menos uma demanda aberta
-- Utiliza EXISTS.

SELECT
    c.id_cliente,
    c.nome
FROM cliente c
WHERE EXISTS (
    SELECT 1
    FROM veiculo v
    INNER JOIN demanda d
        ON d.placa = v.placa
    WHERE v.id_cliente = c.id_cliente
      AND d.status = 'ABERTA'
)
ORDER BY c.nome;


-- 12. Pagamentos acima da média dos pagamentos
-- Utiliza subconsulta.

SELECT
    id_pagamento,
    valor_pagamento,
    data_pagamento,
    id_demanda
FROM pagamento
WHERE valor_pagamento > (
    SELECT AVG(valor_pagamento)
    FROM pagamento
)
ORDER BY valor_pagamento DESC;


-- 13. Clientes que possuem mais veículos que a média
-- Utiliza subconsulta correlacionada.

SELECT
    c.id_cliente,
    c.nome
FROM cliente c
WHERE (
    SELECT COUNT(*)
    FROM veiculo v
    WHERE v.id_cliente = c.id_cliente
) > (
    SELECT AVG(qtd_veiculos)
    FROM (
        SELECT
            id_cliente,
            COUNT(*) AS qtd_veiculos
        FROM veiculo
        GROUP BY id_cliente
    ) AS media_veiculos
)
ORDER BY c.nome;


-- 14. Gerentes responsáveis por mais de uma demanda
-- Utiliza JOIN, GROUP BY e HAVING para responder
-- a uma questão de negócio.

SELECT
    f.id_funcionario,
    f.nome AS gerente,
    COUNT(e.id_demanda) AS quantidade_demandas
FROM gerente g
INNER JOIN funcionario f
    ON g.id_funcionario = f.id_funcionario
INNER JOIN executa e
    ON g.id_funcionario = e.id_funcionario
GROUP BY
    f.id_funcionario,
    f.nome
HAVING COUNT(e.id_demanda) > 1
ORDER BY quantidade_demandas DESC;


-- 15. Cliente com o maior valor total em pagamentos
-- Consulta avançada envolvendo cliente, veículo,
-- demanda e pagamento.

SELECT
    c.id_cliente,
    c.nome,
    SUM(p.valor_pagamento) AS valor_total_pago
FROM cliente c
INNER JOIN veiculo v
    ON c.id_cliente = v.id_cliente
INNER JOIN demanda d
    ON v.placa = d.placa
INNER JOIN pagamento p
    ON d.id_demanda = p.id_demanda
GROUP BY
    c.id_cliente,
    c.nome
HAVING SUM(p.valor_pagamento) = (
    SELECT MAX(total_cliente)
    FROM (
        SELECT
            SUM(p2.valor_pagamento) AS total_cliente
        FROM cliente c2
        INNER JOIN veiculo v2
            ON c2.id_cliente = v2.id_cliente
        INNER JOIN demanda d2
            ON v2.placa = d2.placa
        INNER JOIN pagamento p2
            ON d2.id_demanda = p2.id_demanda
        GROUP BY c2.id_cliente
    ) AS totais
);