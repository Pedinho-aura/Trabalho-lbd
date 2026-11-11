# B4 - Consulta 02: Pagamentos por Demanda e Período

## 1. Objetivo

Avaliar o desempenho da consulta responsável por localizar pagamentos associados a uma demanda específica, considerando um intervalo de datas.

O experimento compara o índice simples existente com um novo índice composto, analisando as alterações no plano de execução e nos tempos medidos.

## 2. Ambiente e volume de dados

- SGBD: MySQL 8.0
- Banco de dados: `oficinadf`
- Tabela analisada: `pagamento`
- Volume: 35 registros
- Demanda utilizada no teste: `id_demanda = 3`
- Registros retornados no `EXPLAIN ANALYZE`: 2
- Ferramenta: MySQL Workbench

## 3. Consulta analisada

```
SELECT
    id_pagamento,
    id_demanda,
    valor_pagamento,
    data_pagamento
FROM pagamento
WHERE id_demanda = 3
  AND data_pagamento >= '2020-01-01'
  AND data_pagamento < '2030-01-01'
ORDER BY data_pagamento;
```

A consulta recupera os pagamentos de uma demanda específica, aplica um filtro temporal e ordena os resultados pela data de pagamento.

## 4. Plano de execução antes da otimização

Resultado do `EXPLAIN`:

| Campo | Valor |
|---|---|
| type | `ref` |
| key | `idx_pagamento_demanda` |
| rows | 2 |
| filtered | 100.00 |
| Extra | `Using where; Using filesort` |

**Interpretação:**

O MySQL utilizou o índice `idx_pagamento_demanda` para localizar os pagamentos vinculados à demanda informada.

Em seguida, aplicou o filtro de data e realizou uma ordenação adicional, identificada por `Using filesort`.

O plano estimou duas linhas examinadas, correspondendo aos dois registros retornados na execução analisada.

Tempo observado no primeiro `EXPLAIN ANALYZE`: **0,0736 ms**.

## 5. Índice criado

```
CREATE INDEX idx_b4_pagamento_demanda_data
ON pagamento (id_demanda, data_pagamento);
```

**Justificativa:**

A coluna `id_demanda` foi posicionada primeiro porque é utilizada em uma condição de igualdade (`=`).

A coluna `data_pagamento` foi posicionada em seguida porque participa do filtro por intervalo e da ordenação dos resultados.

Essa combinação permite utilizar um único índice para localizar os pagamentos da demanda e percorrer suas datas em ordem, evitando uma ordenação adicional.

## 6. Plano de execução depois da otimização

Resultado do `EXPLAIN`:

| Campo | Valor |
|---|---|
| type | `ref` |
| key | `idx_b4_pagamento_demanda_data` |
| rows | 2 |
| filtered | 100.00 |
| Extra | `Using index condition` |

**Interpretação:**

O MySQL passou a utilizar o índice composto `idx_b4_pagamento_demanda_data`.

O tipo de acesso permaneceu `ref`, mas o novo índice permitiu avaliar a condição temporal durante o acesso indexado.

A operação `Using filesort` deixou de aparecer no plano, demonstrando que a ordenação adicional não foi necessária.

Tempo observado no primeiro `EXPLAIN ANALYZE` posterior: **0,0385 ms**.

## 7. Comparação dos tempos

Foram realizadas cinco execuções adicionais de cada versão, utilizando `EXPLAIN ANALYZE` e `FORCE INDEX` para comparar os caminhos de acesso.

| Execução | Índice antigo (ms) | Índice novo (ms) |
|---|---:|---:|
| 1 | 0,0899 | 0,0482 |
| 2 | 0,0549 | 0,6450 |
| 3 | 0,4860 | 0,4300 |
| 4 | 0,3130 | 0,0439 |
| 5 | 0,0479 | 0,0457 |
| **Média** | **0,1983** | **0,2426** |
| **Mediana** | **0,0899** | **0,0482** |

A média aumentou aproximadamente **22,3%**, enquanto a mediana diminuiu aproximadamente **46,4%**.

Os resultados mostram uma diferença importante entre as duas medidas estatísticas.

## 8. Análise dos resultados

O novo índice modificou o plano de execução, permitindo utilizar as colunas `id_demanda` e `data_pagamento`.

A principal melhoria observada foi a eliminação do `Using filesort`, presente no plano original.

Entretanto, as medições apresentaram grande variação.

A média do índice novo foi superior à do índice antigo, principalmente devido às execuções de 0,6450 ms e 0,4300 ms.

Por outro lado, a mediana foi menor com o índice composto, indicando que o valor central das medições foi menor.

Esses resultados não permitem confirmar que o novo índice apresentou ganho consistente de velocidade.

Além disso, a tabela contém apenas 35 pagamentos, e a consulta analisada retorna dois registros. Nesse cenário, o custo da ordenação original já era pequeno, e diferenças de frações de milissegundo podem ser influenciadas por variações do ambiente onde é executado.

## 9. Conclusão

O índice `idx_b4_pagamento_demanda_data` apresentou melhoria no plano de execução, eliminando a ordenação adicional.

Entretanto, as medições repetidas não demonstraram ganho estável de tempo: a média aumentou, enquanto a mediana diminuiu.

Portanto, a otimização foi efetiva na organização do acesso aos dados, mas seu benefício de desempenho não pôde ser comprovado de forma consistente com a massa de 35 registros.

O resultado reforça que a utilização de um índice composto não garante, isoladamente, uma redução mensurável do tempo de execução.