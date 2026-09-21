
-- BANCO DE DADOS

CREATE DATABASE oficina_mecanica
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE oficina_mecanica;

-- 1. CLIENTE

CREATE TABLE cliente (
    id_cliente INT NOT NULL,
    nome VARCHAR(100) NOT NULL,

    CONSTRAINT pk_cliente
        PRIMARY KEY (id_cliente)
);

-- 2. VEICULO

CREATE TABLE veiculo (
    placa VARCHAR(10) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    id_cliente INT NOT NULL,

    CONSTRAINT pk_veiculo
        PRIMARY KEY (placa),

    CONSTRAINT fk_veiculo_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 3. FUNCIONARIO
-- Superentidade para as especializações

CREATE TABLE funcionario (
    id_funcionario INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    data_admissao DATE NOT NULL,

    CONSTRAINT pk_funcionario
        PRIMARY KEY (id_funcionario),

    CONSTRAINT uq_funcionario_cpf
        UNIQUE (cpf)
);

-- 4. GERENTE
-- Especialização de FUNCIONARIO

CREATE TABLE gerente (
    id_funcionario INT NOT NULL,

    CONSTRAINT pk_gerente
        PRIMARY KEY (id_funcionario),

    CONSTRAINT fk_gerente_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 5. MECANICO
-- Especialização de FUNCIONARIO

CREATE TABLE mecanico (
    id_funcionario INT NOT NULL,

    CONSTRAINT pk_mecanico
        PRIMARY KEY (id_funcionario),

    CONSTRAINT fk_mecanico_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 6. ATENDENTE
-- Especialização de FUNCIONARIO

CREATE TABLE atendente (
    id_funcionario INT NOT NULL,

    CONSTRAINT pk_atendente
        PRIMARY KEY (id_funcionario),

    CONSTRAINT fk_atendente_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 7. ADMINISTRADOR
-- Especialização de FUNCIONARIO

CREATE TABLE administrador (
    id_funcionario INT NOT NULL,

    CONSTRAINT pk_administrador
        PRIMARY KEY (id_funcionario),

    CONSTRAINT fk_administrador_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 8. REPOSITOR
-- Especialização de FUNCIONARIO

CREATE TABLE repositor (
    id_funcionario INT NOT NULL,

    CONSTRAINT pk_repositor
        PRIMARY KEY (id_funcionario),

    CONSTRAINT fk_repositor_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 9. CATEGORIA

CREATE TABLE categoria (
    id_categoria INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),

    CONSTRAINT pk_categoria
        PRIMARY KEY (id_categoria),

    CONSTRAINT uq_categoria_nome
        UNIQUE (nome)
);

-- 10. ITEM_ESTOQUE
-- Superentidade de PECA e EQUIPAMENTO

CREATE TABLE item_estoque (
    id_item INT NOT NULL,
    status VARCHAR(30) NOT NULL,
    id_categoria INT NOT NULL,

    CONSTRAINT pk_item_estoque
        PRIMARY KEY (id_item),

    CONSTRAINT fk_item_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 11. PECA
-- Especialização de ITEM_ESTOQUE

CREATE TABLE peca (
    id_item INT NOT NULL,
    qtd_estoque INT NOT NULL,

    CONSTRAINT pk_peca
        PRIMARY KEY (id_item),

    CONSTRAINT fk_peca_item
        FOREIGN KEY (id_item)
        REFERENCES item_estoque(id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT ck_peca_qtd_estoque
        CHECK (qtd_estoque >= 0)
);

-- 12. EQUIPAMENTO
-- Especialização de ITEM_ESTOQUE

CREATE TABLE equipamento (
    id_item INT NOT NULL,
    patrimonio VARCHAR(100) NOT NULL,

    CONSTRAINT pk_equipamento
        PRIMARY KEY (id_item),

    CONSTRAINT uq_equipamento_patrimonio
        UNIQUE (patrimonio),

    CONSTRAINT fk_equipamento_item
        FOREIGN KEY (id_item)
        REFERENCES item_estoque(id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 13. MOVIMENTACAO_ESTOQUE

CREATE TABLE movimentacao_estoque (
    id_mov INT NOT NULL,
    tipo_movimentacao VARCHAR(20) NOT NULL,
    data_movimentacao DATETIME NOT NULL,
    id_item INT NOT NULL,

    CONSTRAINT pk_movimentacao_estoque
        PRIMARY KEY (id_mov),

    CONSTRAINT fk_movimentacao_item
        FOREIGN KEY (id_item)
        REFERENCES item_estoque(id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT ck_movimentacao_tipo
        CHECK (tipo_movimentacao IN ('ENTRADA', 'SAIDA'))
);

-- 14. DEMANDA

CREATE TABLE demanda (
    id_demanda INT NOT NULL,
    status VARCHAR(30) NOT NULL,
    data_hora_abertura DATETIME NOT NULL,
    placa VARCHAR(10) NOT NULL,
    id_item INT NOT NULL,

    CONSTRAINT pk_demanda
        PRIMARY KEY (id_demanda),

    CONSTRAINT fk_demanda_veiculo
        FOREIGN KEY (placa)
        REFERENCES veiculo(placa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_demanda_item
        FOREIGN KEY (id_item)
        REFERENCES item_estoque(id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 15. FORMA_PAGAMENTO

CREATE TABLE forma_pagamento (
    id_forma INT NOT NULL,
    descricao VARCHAR(50) NOT NULL,

    CONSTRAINT pk_forma_pagamento
        PRIMARY KEY (id_forma),

    CONSTRAINT uq_forma_pagamento_descricao
        UNIQUE (descricao)
);

-- 16. PAGAMENTO

CREATE TABLE pagamento (
    id_pagamento INT NOT NULL,
    valor_pagamento DECIMAL(10,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    id_demanda INT NOT NULL,
    id_forma INT NOT NULL,

    CONSTRAINT pk_pagamento
        PRIMARY KEY (id_pagamento),

    CONSTRAINT fk_pagamento_demanda
        FOREIGN KEY (id_demanda)
        REFERENCES demanda(id_demanda)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_pagamento_forma
        FOREIGN KEY (id_forma)
        REFERENCES forma_pagamento(id_forma)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT ck_pagamento_valor
        CHECK (valor_pagamento > 0)
);

-- 17. EXECUTA
-- DEMANDA N:N GERENTE

CREATE TABLE executa (
    id_demanda INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_execucao DATETIME NOT NULL,

    CONSTRAINT pk_executa
        PRIMARY KEY (id_demanda, id_funcionario),

    CONSTRAINT fk_executa_demanda
        FOREIGN KEY (id_demanda)
        REFERENCES demanda(id_demanda)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_executa_gerente
        FOREIGN KEY (id_funcionario)
        REFERENCES gerente(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 18. SUPERVISIONA
-- GERENTE N:N FUNCIONARIO

CREATE TABLE supervisiona (
    id_gerente INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_inicio DATE NOT NULL,

    CONSTRAINT pk_supervisiona
        PRIMARY KEY (id_gerente, id_funcionario),

    CONSTRAINT fk_supervisiona_gerente
        FOREIGN KEY (id_gerente)
        REFERENCES gerente(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_supervisiona_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- 19. REGISTRA
-- MOVIMENTACAO N:N ITEM_ESTOQUE


CREATE TABLE registra (
    id_mov INT NOT NULL,
    id_item INT NOT NULL,
    quantidade INT NOT NULL,

    CONSTRAINT pk_registra
        PRIMARY KEY (id_mov, id_item),

    CONSTRAINT fk_registra_mov
        FOREIGN KEY (id_mov)
        REFERENCES movimentacao_estoque(id_mov)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_registra_item
        FOREIGN KEY (id_item)
        REFERENCES item_estoque(id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT ck_registra_quantidade
        CHECK (quantidade > 0)
);