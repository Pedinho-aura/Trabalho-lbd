# B4 - Consulta 01: Demandas por Status e Período

## 1. Objetivo

Avaliar o desempenho da consulta responsável por localizar demandas de determinado status dentro de um intervalo de datas de abertura no sistema OficinaDF.

O experimento compara o índice simples existente com um novo índice composto, verificando o plano de execução e os tempos medidos.

## 2. Ambiente e volume de dados

- SGBD: MySQL 8.0
- Banco de dados: `oficinadf`
- Tabela analisada: `demanda`
- Volume: 40 registros
- Registros retornados no `EXPLAIN ANALYZE`: 5
- Ferramenta: MySQL Workbench

## 3. Consulta analisada

```
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
```

A consulta filtra as demandas pelo status `Pendente`, aplica um intervalo de datas e ordena os resultados cronologicamente.

## 4. Plano de execução antes da otimização

Resultado do `EXPLAIN`:

| Campo | Valor |
|---|---|
| type | `ref` |
| key | `idx_demanda_status` |
| rows | 5 |
| filtered | 100.00 |
| Extra | `Using where; Using filesort` |

**Interpretação:**

O MySQL utilizou o índice `idx_demanda_status` para localizar as demandas pendentes. Entretanto, precisou aplicar o filtro temporal e realizar uma ordenação adicional (`Using filesort`).

O plano inicial apresentou uma estimativa de cinco linhas examinadas, com cinco registros efetivamente retornados.

Tempo observado no primeiro `EXPLAIN ANALYZE`: **0,756 ms**.

## 5. Índice criado

```
CREATE INDEX idx_b4_demanda_status_data
ON demanda (status, data_hora_abertura);
```

**Justificativa:**

A coluna `status` foi posicionada primeiro porque recebe uma condição de igualdade (`=`).

A coluna `data_hora_abertura` foi posicionada em seguida porque participa de um filtro por intervalo e da cláusula `ORDER BY`.

Essa organização permite ao MySQL percorrer os registros filtrados em uma ordem compatível com a consulta, reduzindo a necessidade de ordenação adicional.

## 6. Plano de execução depois da otimização

Resultado do `EXPLAIN`:

| Campo | Valor |
|---|---|
| type | `range` |
| key | `idx_b4_demanda_status_data` |
| rows | 5 |
| filtered | 100.00 |
| Extra | `Using index condition` |

**Interpretação:**

O MySQL passou a utilizar o índice composto criado na B4.

O acesso mudou de `ref` para `range`, permitindo percorrer o intervalo definido pelas condições de status e data.

A operação `Using filesort` deixou de aparecer no plano, indicando que não foi necessária uma ordenação adicional.

Tempo observado no primeiro `EXPLAIN ANALYZE` posterior: **1,150 ms**.

## 7. Comparação dos tempos

Foram realizadas cinco execuções adicionais para cada versão, utilizando `EXPLAIN ANALYZE` e `FORCE INDEX` para comparar os caminhos de acesso.

| Execução | Índice antigo (ms) | Índice novo (ms) |
|---|---:|---:|
| 1 | 1,1400 | 0,3740 |
| 2 | 0,0593 | 0,3980 |
| 3 | 0,0584 | 0,0458 |
| 4 | 0,0606 | 0,0463 |
| 5 | 1,1400 | 0,0476 |
| **Média** | **0,4917** | **0,1823** |
| **Mediana** | **0,0606** | **0,0476** |

A média diminuiu aproximadamente **62,9%**, enquanto a mediana diminuiu aproximadamente **21,5%**.

As execuções apresentaram variações consideráveis, especialmente em valores isolados maiores do que os outros.

## 8. Análise dos resultados

A criação do índice composto modificou o plano de execução, permitindo utilizar as colunas `status` e `data_hora_abertura` em conjunto.

O principal resultado técnico foi a eliminação da ordenação adicional identificada no plano inicial.

Nas cinco medições comparativas, o índice novo apresentou média e mediana menores às do índice antigo. Entretanto, o primeiro teste após a criação do índice havia apresentado tempo superior ao inicial.

Essa diferença demonstra a influência das condições de execução sobre medições muito curtas.

## 9. Conclusão

O índice `idx_b4_demanda_status_data` apresentou um resultado favorável na estrutura do plano de execução, eliminando o `Using filesort` e permitindo o acesso pelo intervalo de status e data.

As medições repetidas também indicaram tempos menores, mas com variações relevantes.

Portanto, a otimização demonstrou benefício no plano de execução e resultados de tempo promissores.