# B4 : Otimização de Consultas - OficinaDF

## 1. Apresentação

Esta etapa do projeto OficinaDF tem como objetivo analisar e otimizar o desempenho de três consultas SQL para o funcionamento do sistema.

O estudo foi desenvolvido com base nos conteúdos da Aula 09, utilizando os recursos `EXPLAIN`, `EXPLAIN ANALYZE` e índices compostos no SGBD MySQL 8.0.

Foram comparados os planos de execução antes e depois da criação dos índices, levando em conta os tempos medidos e o volume de registros das tabelas.

O experimento também há resultados sem ganho consistente de desempenho, conforme os pedido da atividade.

## 2. Ambiente utilizado

| Componente | Descrição |
|---|---|
| Projeto | OficinaDF |
| SGBD | MySQL 8.0 |
| Banco de dados | `oficinadf` |
| Ferramenta | MySQL Workbench |
| Técnica de análise | `EXPLAIN` e `EXPLAIN ANALYZE` |
| Intervenção | Criação de índices compostos |
| Comparação adicional | `FORCE INDEX` |

O experimento foi realizado sobre a base de dados existente, sem necessidade de modificar os registros para criar os índices.

## 3. Organização dos arquivos

```text
B4/
├── 00_diagnostico.sql
├── 01_consultas_originais.sql
├── 02_explain_antes.sql
├── 03_criacao_indices.sql
├── 04_explain_depois.sql
├── 05_medicao_desempenho.sql
├── README.md
└── resultados/
    ├── consulta_01.md
    ├── consulta_02.md
    └── consulta_03.md
```

### Responsabilidade dos arquivos

| Arquivo | Finalidade |
|---|---|
| `00_diagnostico.sql` | Identificar o ambiente, os volumes de dados e os índices existentes |
| `01_consultas_originais.sql` | Definir e validar as três consultas analisadas |
| `02_explain_antes.sql` | Registrar os planos e tempos iniciais |
| `03_criacao_indices.sql` | Criar os índices compostos propostos |
| `04_explain_depois.sql` | Verificar os planos após a intervenção |
| `05_medicao_desempenho.sql` | Comparar os caminhos de acesso com índices antigos e novos |
| `resultados/` | Documentar individualmente cada consulta, seus resultados e suas limitações |

## 4. Consultas analisadas

### Consulta 01 - Demandas por status e período

**Objetivo:** localizar demandas pendentes em determinado intervalo de datas de abertura.

- Tabela: `demanda`
- Volume: 40 registros
- Índice anterior: `idx_demanda_status`
- Índice criado: `idx_b4_demanda_status_data`
- Colunas: `(status, data_hora_abertura)`

O índice foi feito para combinar o filtro por status com a busca e ordenação pela data de abertura.

### Consulta 02 - Pagamentos por demanda e período

**Objetivo:** localizar pagamentos vinculados a uma demanda em determinado intervalo de datas.

- Tabela: `pagamento`
- Volume: 35 registros
- Demanda de teste: `3`
- Índice anterior: `idx_pagamento_demanda`
- Índice criado: `idx_b4_pagamento_demanda_data`
- Colunas: `(id_demanda, data_pagamento)`

O índice foi proposto para combinar a identificação da demanda com o filtro e a ordenação por data de pagamento.

### Consulta 03 - Movimentações de estoque por item e período

**Objetivo:** localizar movimentações de um item em determinado intervalo de datas de entrada.

- Tabela: `movimentacao_estoque`
- Volume: 100 registros
- Item de teste: `2`
- Índice anterior: `PRIMARY`
- Índice criado: `idx_b4_movimentacao_item_data`
- Colunas: `(id_item, data_entrada)`

O índice foi proposto para combinar o identificador do item com o filtro temporal, evitando uma ordenação adicional.

## 5. Metodologia

O estudo foi realizado em cinco fases.

### 5.1. Diagnóstico

Inicialmente, foram identificados os volumes de dados e os índices existentes nas tabelas.

Essa verificação permitiu evitar a criação de índices idênticos aos já disponíveis.

### 5.2. Análise inicial

As três consultas foram executadas e validadas.

Em seguida, foram utilizados `EXPLAIN` e `EXPLAIN ANALYZE` para identificar:

- Tipo de acesso (`type`).
- Índice utilizado (`key`).
- Estimativa de linhas examinadas (`rows`).
- Operações adicionais (`Extra`).
- Tempo efetivamente observado no plano de execução.

Os resultados foram registrados antes da criação dos índices compostos.

### 5.3. Criação dos índices

Foram criados três índices compostos, considerando a ordem das colunas utilizadas nas condições de igualdade, intervalo e ordenação.

A escolha dos índices foi fundamentada nas consultas e nos planos iniciais.

### 5.4. Análise posterior

Após a criação dos índices, as mesmas consultas foram novamente analisadas.

Os planos posteriores demonstraram que o MySQL passou a utilizar os três índices propostos.

Em todos os casos, a operação `Using filesort` deixou de aparecer.

### 5.5. Medições comparativas

Foram realizadas cinco execuções adicionais de cada versão das três consultas, totalizando 30 execuções medidas.

O arquivo `05_medicao_desempenho.sql` utiliza `FORCE INDEX` para comparar o caminho de acesso antigo com o novo sobre a mesma base de dados.

Essa técnica permite repetir a comparação sem remover os índices criados.

Os tempos foram obtidos a partir do valor final de `actual time` do `EXPLAIN ANALYZE`, em milissegundos.

Foram calculadas médias e medianas para auxiliar na interpretação dos resultados.

**Limitação metodológica:** o uso de `FORCE INDEX` reproduz caminhos de acesso específicos, mas não representa necessariamente a escolha automática do otimizador em todas as situações.

## 6. Resultados obtidos

### 6.1. Comparação dos planos

| Consulta | Índice anterior | Índice posterior | Filesort antes | Filesort depois |
|---|---|---|---|---|
| Demandas | `idx_demanda_status` | `idx_b4_demanda_status_data` | Sim | Não |
| Pagamentos | `idx_pagamento_demanda` | `idx_b4_pagamento_demanda_data` | Sim | Não |
| Estoque | `PRIMARY` | `idx_b4_movimentacao_item_data` | Sim | Não |

Os três índices compostos foram selecionados pelo otimizador nas consultas posteriores.

### 6.2. Comparação dos tempos médios

| Consulta | Antes (ms) | Depois (ms) | Variação |
|---|---:|---:|---:|
| Demandas | 0,4917 | 0,1823 | −62,9% |
| Pagamentos | 0,1983 | 0,2426 | +22,3% |
| Estoque | 0,6150 | 0,1523 | −75,2% |

### 6.3. Comparação das medianas

| Consulta | Antes (ms) | Depois (ms) |
|---|---:|---:|
| Demandas | 0,0606 | 0,0476 |
| Pagamentos | 0,0899 | 0,0482 |
| Estoque | 0,3070 | 0,0430 |

As diferenças entre médias e medianas mostram a influência de medições isoladas com tempos grandes.

Os percentuais apresentados descrevem os resultados observados e não representam ganhos garantidos de desempenho.

## 7. Discussão dos resultados

### Demandas

O índice composto eliminou a ordenação adicional e apresentou média e mediana inferiores às do índice antigo nas medições repetidas.

Entretanto, o primeiro teste posterior registrou aumento do tempo, demonstrando que os resultados não foram uniformes.

### Pagamentos

O novo índice eliminou o `Using filesort`, mas não apresentou ganho consistente de tempo.

A média aumentou aproximadamente 22,3%, enquanto a mediana diminuiu.

Esse comportamento indica que a melhoria do plano não foi acompanhada de uma redução estável do tempo medido.

### Movimentações de estoque

O novo índice substituiu o acesso pela chave primária e eliminou a ordenação adicional.

As medições repetidas apresentaram média e mediana menores, embora tenham ocorrido variações relevantes entre as execuções.

## 8. Limitações do experimento

O estudo apresenta algumas limitações:

- As tabelas possuem volumes reduzidos, entre 35 e 100 registros.
- As consultas retornam poucos registros.
- Os tempos medidos são muito pequenos e passivos a variações do ambiente.
- Foram realizadas cinco medições comparativas por versão.
- Não foram realizados testes com massas de dados maiores.

Portanto, os resultados demonstram alterações nos planos de execução e diferenças nos tempos observados.

## 9. Como reproduzir o experimento

**Pré-requisito:** possuir o banco `oficinadf` criado e populado com a estrutura e os dados do projeto.

A sequência recomendada para reproduzir o experimento desde o início é:

1. Executar `00_diagnostico.sql` para verificar os dados e os índices existentes.
2. Executar `01_consultas_originais.sql` para validar as consultas.
3. Executar `02_explain_antes.sql` e registrar os planos iniciais.
4. Executar `03_criacao_indices.sql` para criar os índices compostos.
5. Executar `04_explain_depois.sql` e registrar os novos planos.
6. Executar `05_medicao_desempenho.sql` para comparar os caminhos de acesso.

**Atenção:** os comandos `CREATE INDEX` do terceiro arquivo devem ser executados somente quando os índices ainda não existirem.

Se os índices da B4 já estiverem criados, a reprodução completa do cenário inicial exige uma cópia do banco sem esses índices. Não é necessário remover índices do banco principal apenas para consultar os resultados.

Para comparar os caminhos de acesso com os índices já existentes, pode-se executar diretamente `05_medicao_desempenho.sql`.

Os parâmetros utilizados nas medições comparativas foram:

- Demanda: `id_demanda = 3`.
- Item: `id_item = 2`.
- Intervalo temporal: de `2020-01-01` até antes de `2030-01-01`.

## 10. Conclusão geral

A B4 demonstrou a aplicação prática de técnicas de análise e otimização de consultas no banco de dados do OficinaDF.

Os três índices compostos foram utilizados pelo MySQL e eliminaram operações adicionais de ordenação identificadas nos planos originais.

As medições apresentaram resultados favoráveis em demandas e movimentações de estoque, enquanto pagamentos apresentou comportamento inconsistente.

Conclui-se que a criação de índices compostos pode melhorar o caminho de acesso aos dados, mas não garante, isoladamente, uma redução estável do tempo de execução.

O estudo reforça a importância de avaliar os planos de execução, medir o desempenho e interpretar os resultados de acordo com o volume de dados e as limitações do ambiente.

## 11. Resultados detalhados

As consultas, justificativas dos índices, planos e medições estão documentados individualmente:

- [Consulta 01 — Demandas](resultados/consulta_01.md)
- [Consulta 02 — Pagamentos](resultados/consulta_02.md)
- [Consulta 03 — Movimentações de estoque](resultados/consulta_03.md)