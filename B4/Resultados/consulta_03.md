# B4 - Consulta 03: Movimentações de Estoque por Item e Período

## 1. Objetivo

Avaliar o desempenho da consulta responsável por localizar movimentações de estoque de um item específico dentro de determinado intervalo de datas.

O experimento compara o índice da chave primária existente com um novo índice composto, analisando o plano de execução, a ordenação dos resultados e os tempos medidos.

## 2. Ambiente e volume de dados

- SGBD: MySQL 8.0
- Banco de dados: `oficinadf`
- Tabela analisada: `movimentacao_estoque`
- Volume: 100 registros
- Item utilizado: `id_item = 2`
- Registros retornados no `EXPLAIN ANALYZE`: 2
- Ferramenta: MySQL Workbench

## 3. Consulta analisada

```
SELECT
    id_item,
    id_mov,
    data_entrada,
    data_saida
FROM movimentacao_estoque
WHERE id_item = 2
  AND data_entrada >= '2020-01-01'
  AND data_entrada < '2030-01-01'
ORDER BY data_entrada;
```

A consulta identifica as movimentações de um item, filtra pelo período de entrada e organiza os registros cronologicamente.

Essa operação é relevante para o acompanhamento das movimentações e para a consulta do histórico de estoque.

## 4. Plano de execução antes da otimização

Resultado do `EXPLAIN`:

| Campo | Valor |
|---|---|
| type | `ref` |
| key | `PRIMARY` |
| rows | 5 |
| filtered | 48.00 |
| Extra | `Using where; Using filesort` |

**Interpretação:**

O MySQL utilizou a chave primária composta `(id_item, id_mov)` para localizar as movimentações relacionadas ao item informado.

Entretanto, a chave primária não organiza os registros pela coluna `data_entrada`, exigindo a aplicação do filtro temporal e uma ordenação adicional.

O plano estimou cinco linhas examinadas, enquanto o `EXPLAIN ANALYZE` retornou dois registros após o filtro.

Tempo observado no primeiro `EXPLAIN ANALYZE`: **0,0547 ms**.

## 5. Índice criado

```
CREATE INDEX idx_b4_movimentacao_item_data
ON movimentacao_estoque (id_item, data_entrada);
```

**Justificativa:**

A coluna `id_item` foi posicionada primeiro porque recebe uma condição de igualdade.

A coluna `data_entrada` foi posicionada em seguida porque participa do filtro temporal e da cláusula `ORDER BY`.

O índice composto permite localizar as movimentações do item e percorrer suas datas em ordem, evitando uma operação adicional de classificação.

A escolha também considera que o índice da chave primária já possui `id_item` como primeira coluna, mas utiliza `id_mov` como segunda.

## 6. Plano de execução depois da otimização

Resultado do `EXPLAIN`:

| Campo | Valor |
|---|---|
| type | `ref` |
| key | `idx_b4_movimentacao_item_data` |
| rows | 5 |
| filtered | 48.00 |
| Extra | `Using index condition` |

**Interpretação:**

O MySQL passou a utilizar o índice composto criado na B4.

O tipo de acesso permaneceu `ref`, mas a condição sobre `data_entrada` passou a ser avaliada durante o acesso indexado.

A operação `Using filesort` deixou de aparecer no plano.

Tempo observado no primeiro `EXPLAIN ANALYZE` posterior: **0,1780 ms**.

Apesar da melhoria estrutural do plano, essa execução isolada apresentou tempo maior, comparado, ao observado inicialmente.

## 7. Comparação dos tempos

Foram realizadas cinco execuções adicionais para cada versão, utilizando `EXPLAIN ANALYZE` e `FORCE INDEX`.

| Execução | Índice antigo (ms) | Índice novo (ms) |
|---|---:|---:|
| 1 | 0,1270 | 0,0430 |
| 2 | 0,3070 | 0,0385 |
| 3 | 0,8210 | 0,0411 |
| 4 | 0,0600 | 0,0457 |
| 5 | 1,7600 | 0,5930 |
| **Média** | **0,6150** | **0,1523** |
| **Mediana** | **0,3070** | **0,0430** |

A média diminuiu aproximadamente **75,2%**, enquanto a mediana diminuiu aproximadamente **86,0%**.

Entretanto, os resultados apresentam variações consideráveis, especialmente nas execuções com valores elevados.

## 8. Análise dos resultados

A criação do índice `(id_item, data_entrada)` modificou o caminho de acesso escolhido pelo MySQL.

Antes da otimização, a consulta utilizava a chave primária e realizava uma ordenação adicional.

Depois, o MySQL passou a utilizar o índice composto, eliminando o `Using filesort`.

Nas medições repetidas, a média e a mediana do índice novo foram menores às do índice antigo.

Contudo, o primeiro teste posterior apresentou aumento do tempo, e as execuções adicionais mostraram diferenças relevantes entre si.

Além disso, a criação de índices envolve custos de armazenamento e manutenção em operações de escrita, que não foram medidos neste experimento.

## 9. Conclusão

O índice `idx_b4_movimentacao_item_data` apresentou melhoria no plano de execução, permitindo utilizar conjuntamente o identificador do item e a data de entrada.

A eliminação do `Using filesort` confirmou que a consulta passou a utilizar um caminho de acesso compatível com a ordenação solicitada.

As medições repetidas apresentaram resultados favoráveis ao novo índice, mas a dispersão dos tempos e o pequeno volume de dados impedem conclusões definitivas sobre o ganho de desempenho.

Portanto, a otimização foi bem-sucedida quanto à alteração do plano de execução, com resultados de tempo promissores, sujeitos às limitações do experimento.