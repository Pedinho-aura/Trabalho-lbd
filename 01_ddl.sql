CREATE DATABASE IF NOT EXISTS oficinadf
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE oficinadf;

DROP TABLE IF EXISTS movimentacao_estoque;
DROP TABLE IF EXISTS utiliza;
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS executa;
DROP TABLE IF EXISTS repositor;
DROP TABLE IF EXISTS administrador;
DROP TABLE IF EXISTS atendente;
DROP TABLE IF EXISTS mecanico;
DROP TABLE IF EXISTS equipamento;
DROP TABLE IF EXISTS peca;
DROP TABLE IF EXISTS item_estoque;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS forma_pagamento;
DROP TABLE IF EXISTS demanda;
DROP TABLE IF EXISTS veiculo;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS cliente;

-- 1. CLIENTE
CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
) ENGINE=InnoDB;

-- 2. FUNCIONARIO: superentidade e autorrelacionamento SUPERVISIONA
CREATE TABLE funcionario (
    id_funcionario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    data_admissao DATE NOT NULL,
    id_supervisor INT NULL,
    CONSTRAINT pk_funcionario PRIMARY KEY (id_funcionario),
    CONSTRAINT uq_funcionario_cpf UNIQUE (cpf),
    CONSTRAINT fk_funcionario_supervisor
        FOREIGN KEY (id_supervisor)
        REFERENCES funcionario (id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    INDEX idx_funcionario_supervisor (id_supervisor)
) ENGINE=InnoDB;

-- 3. VEICULO: cada veiculo pertence a um cliente
CREATE TABLE veiculo (
    placa VARCHAR(10) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    id_cliente INT NOT NULL,
    CONSTRAINT pk_veiculo PRIMARY KEY (placa),
    CONSTRAINT fk_veiculo_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente (id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    INDEX idx_veiculo_cliente (id_cliente)
) ENGINE=InnoDB;

-- 4. DEMANDA: cada demanda e gerada por um veiculo
CREATE TABLE demanda (
    id_demanda INT NOT NULL AUTO_INCREMENT,
    status VARCHAR(20) NOT NULL DEFAULT 'Pendente',
    data_hora_abertura DATETIME NOT NULL,
    placa VARCHAR(10) NOT NULL,
    CONSTRAINT pk_demanda PRIMARY KEY (id_demanda),
    CONSTRAINT fk_demanda_veiculo
        FOREIGN KEY (placa)
        REFERENCES veiculo (placa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT ck_demanda_status
        CHECK (status IN ('Pendente', 'Finalizado')),
    INDEX idx_demanda_placa (placa),
    INDEX idx_demanda_status (status),
    INDEX idx_demanda_data_abertura (data_hora_abertura)
) ENGINE=InnoDB;

-- 5. Especializacao de FUNCIONARIO
CREATE TABLE mecanico (
    id_funcionario INT NOT NULL,
    CONSTRAINT pk_mecanico PRIMARY KEY (id_funcionario),
    CONSTRAINT fk_mecanico_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE atendente (
    id_funcionario INT NOT NULL,
    CONSTRAINT pk_atendente PRIMARY KEY (id_funcionario),
    CONSTRAINT fk_atendente_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE administrador (
    id_funcionario INT NOT NULL,
    CONSTRAINT pk_administrador PRIMARY KEY (id_funcionario),
    CONSTRAINT fk_administrador_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE repositor (
    id_funcionario INT NOT NULL,
    CONSTRAINT pk_repositor PRIMARY KEY (id_funcionario),
    CONSTRAINT fk_repositor_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario (id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6. EXECUTA: relacionamento N:N DEMANDA x MECANICO
-- Datas sao atributos do relacionamento.
CREATE TABLE executa (
    id_demanda INT NOT NULL,
    id_mecanico INT NOT NULL,
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim DATETIME NULL,
    CONSTRAINT pk_executa PRIMARY KEY (id_demanda, id_mecanico),
    CONSTRAINT fk_executa_demanda
        FOREIGN KEY (id_demanda)
        REFERENCES demanda (id_demanda)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_executa_mecanico
        FOREIGN KEY (id_mecanico)
        REFERENCES mecanico (id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT ck_executa_datas
        CHECK (data_hora_fim IS NULL OR data_hora_fim >= data_hora_inicio),
    INDEX idx_executa_mecanico (id_mecanico)
) ENGINE=InnoDB;

-- 7. FORMA_PAGAMENTO
CREATE TABLE forma_pagamento (
    id_forma INT NOT NULL,
    CONSTRAINT pk_forma_pagamento PRIMARY KEY (id_forma)
) ENGINE=InnoDB;

-- 8. PAGAMENTO: cada pagamento pertence a uma demanda e usa uma forma
CREATE TABLE pagamento (
    id_pagamento INT NOT NULL AUTO_INCREMENT,
    valor_pagamento DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME NOT NULL,
    id_demanda INT NOT NULL,
    id_forma INT NOT NULL,
    CONSTRAINT pk_pagamento PRIMARY KEY (id_pagamento),
    CONSTRAINT fk_pagamento_demanda
        FOREIGN KEY (id_demanda)
        REFERENCES demanda (id_demanda)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_pagamento_forma
        FOREIGN KEY (id_forma)
        REFERENCES forma_pagamento (id_forma)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT ck_pagamento_valor
        CHECK (valor_pagamento > 0),
    INDEX idx_pagamento_demanda (id_demanda),
    INDEX idx_pagamento_forma (id_forma),
    INDEX idx_pagamento_data (data_pagamento)
) ENGINE=InnoDB;

-- 9. CATEGORIA
CREATE TABLE categoria (
    id_categoria INT NOT NULL AUTO_INCREMENT,
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
) ENGINE=InnoDB;

-- 10. ITEM_ESTOQUE
CREATE TABLE item_estoque (
    id_item INT NOT NULL,
    status VARCHAR(30) NOT NULL,
    id_categoria INT NOT NULL,
    CONSTRAINT pk_item_estoque PRIMARY KEY (id_item),
    CONSTRAINT fk_item_estoque_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria (id_categoria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    INDEX idx_item_estoque_status (status),
    INDEX idx_item_estoque_categoria (id_categoria)
) ENGINE=InnoDB;

-- 11. Especializacao de ITEM_ESTOQUE
CREATE TABLE peca (
    id_item INT NOT NULL,
    qtd_estoque INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_peca PRIMARY KEY (id_item),
    CONSTRAINT fk_peca_item_estoque
        FOREIGN KEY (id_item)
        REFERENCES item_estoque (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT ck_peca_qtd_estoque
        CHECK (qtd_estoque >= 0)
) ENGINE=InnoDB;

CREATE TABLE equipamento (
    id_item INT NOT NULL,
    patrimonio VARCHAR(100) NOT NULL,
    CONSTRAINT pk_equipamento PRIMARY KEY (id_item),
    CONSTRAINT uq_equipamento_patrimonio UNIQUE (patrimonio),
    CONSTRAINT fk_equipamento_item_estoque
        FOREIGN KEY (id_item)
        REFERENCES item_estoque (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 12. UTILIZA: relacionamento N:N DEMANDA x PECA, com quantidade
CREATE TABLE utiliza (
    id_demanda INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT pk_utiliza PRIMARY KEY (id_demanda, id_peca),
    CONSTRAINT fk_utiliza_demanda
        FOREIGN KEY (id_demanda)
        REFERENCES demanda (id_demanda)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_utiliza_peca
        FOREIGN KEY (id_peca)
        REFERENCES peca (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT ck_utiliza_quantidade
        CHECK (quantidade > 0),
    INDEX idx_utiliza_peca (id_peca)
) ENGINE=InnoDB;

-- 13. MOVIMENTACAO_ESTOQUE: entidade fraca identificada por
-- (id_item, id_mov). Datas mantidas como atributos do MER.
CREATE TABLE movimentacao_estoque (
    id_item INT NOT NULL,
    id_mov INT NOT NULL,
    data_entrada DATETIME NULL,
    data_saida DATETIME NULL,
    id_repositor INT NOT NULL,
    CONSTRAINT pk_movimentacao_estoque PRIMARY KEY (id_item, id_mov),
    CONSTRAINT fk_movimentacao_item
        FOREIGN KEY (id_item)
        REFERENCES item_estoque (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_movimentacao_repositor
        FOREIGN KEY (id_repositor)
        REFERENCES repositor (id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT ck_movimentacao_tem_data
        CHECK (data_entrada IS NOT NULL OR data_saida IS NOT NULL),
    CONSTRAINT ck_movimentacao_datas
        CHECK (
            data_entrada IS NULL
            OR data_saida IS NULL
            OR data_saida >= data_entrada
        ),
    INDEX idx_movimentacao_repositor (id_repositor),
    INDEX idx_movimentacao_data_entrada (data_entrada),
    INDEX idx_movimentacao_data_saida (data_saida)
) ENGINE=InnoDB;

CREATE TABLE auditoria_pagamento (
    id_auditoria INT NOT NULL AUTO_INCREMENT,
    acao VARCHAR(10) NOT NULL,
    usuario VARCHAR(100) NOT NULL,
    data_hora DATETIME NOT NULL,
    id_pagamento INT NOT NULL,
    id_demanda INT NOT NULL,
    valor_antigo DECIMAL(10,2) NULL,
    valor_novo DECIMAL(10,2) NULL,
    CONSTRAINT pk_auditoria_pagamento PRIMARY KEY (id_auditoria)
) ENGINE=InnoDB;

DELIMITER //
CREATE TRIGGER trg_pagamento_auditoria_update
AFTER UPDATE ON pagamento
FOR EACH ROW
BEGIN

    IF OLD.valor_pagamento <> NEW.valor_pagamento THEN
	INSERT INTO auditoria_pagamento
	   (acao, usuario, data_hora, id_pagamento, id_demanda, valor_antigo, valor_novo)
	VALUES
	   ('UPDATE', USER(), NOW(), OLD.id_pagamento, OLD.id_demanda,
	OLD.valor_pagamento, NEW.valor_pagamento);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_pagamento_auditoria_delete
AFTER DELETE ON pagamento
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_pagamento
	  (acao, usuario, data_hora, id_pagamento, id_demanda, valor_antigo, valor_novo)
    VALUES
	  ('DELETE', USER(), NOW(), OLD.id_pagamento, OLD.id_demanda,
	OLD.valor_pagamento, NULL);
END //
DELIMITER ;
-- FIM DO DDL
