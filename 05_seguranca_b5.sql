
-- =====================================================
-- OFICINADF - B5: SEGURANCA E CONTROLE DE ACESSO

-- Executar como root, apos:
-- 1. Criacao do banco e das tabelas operacionais
-- 2. Execucao do 01_seguranca_b5.sql
--
-- Este script configura:
-- - Armazenamento das credenciais da aplicacao
-- - Permissoes especificas do administrador
-- - Usuarios MySQL para demonstracao dos perfis
-- - Usuario JDBC utilizado pela aplicacao Java
-- - Consultas de verificacao
-- =====================================================

USE oficinadf;


-- 1. CREDENCIAIS DOS USUARIOS DA APLICACAO

-- As senhas serao armazenadas como hash e salt.
-- A geracao desses valores e realizada pelo Java.

CREATE TABLE IF NOT EXISTS usuario_sistema (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    login VARCHAR(50) NOT NULL,
    senha_hash VARBINARY(32) NOT NULL,
    senha_salt VARBINARY(16) NOT NULL,
    iteracoes INT NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,

    perfil ENUM(
        'ADMINISTRADOR',
        'ATENDENTE',
        'CONSULTA'
    ) NOT NULL DEFAULT 'CONSULTA',

    CONSTRAINT pk_usuario_sistema
        PRIMARY KEY (id_usuario),

    CONSTRAINT uq_usuario_sistema_login
        UNIQUE (login),

    CONSTRAINT ck_usuario_sistema_iteracoes
        CHECK (iteracoes > 0)
) ENGINE=InnoDB;


-- 2. PERMISSOES DO PERFIL ADMINISTRADOR

-- Permissoes nas tabelas operacionais utilizadas
-- pela aplicacao.

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.cliente
TO 'perfil_administrador';

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.veiculo
TO 'perfil_administrador';

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.funcionario
TO 'perfil_administrador';

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.demanda
TO 'perfil_administrador';

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.pagamento
TO 'perfil_administrador';


-- 3. USUARIOS MYSQL PARA TESTE DOS PERFIS

-- Estas contas demonstram os privilegios definidos
-- com GRANT e REVOKE no banco de dados.
-- Sao diferentes dos usuarios da aplicacao Java.

-- 3.1 ADMINISTRADOR

CREATE USER IF NOT EXISTS 'teste_administrador'@'localhost'
IDENTIFIED BY 'Senha123';

GRANT 'perfil_administrador'
TO 'teste_administrador'@'localhost';

SET DEFAULT ROLE 'perfil_administrador'
TO 'teste_administrador'@'localhost';


-- 3.2 ATENDENTE

CREATE USER IF NOT EXISTS 'teste_atendente'@'localhost'
IDENTIFIED BY 'Senha123';

GRANT 'perfil_atendente'
TO 'teste_atendente'@'localhost';

SET DEFAULT ROLE 'perfil_atendente'
TO 'teste_atendente'@'localhost';


-- 3.3 CONSULTA

CREATE USER IF NOT EXISTS 'teste_consulta'@'localhost'
IDENTIFIED BY 'Senha123';

GRANT 'perfil_consulta'
TO 'teste_consulta'@'localhost';

SET DEFAULT ROLE 'perfil_consulta'
TO 'teste_consulta'@'localhost';


-- 4. USUARIO DE CONEXAO JDBC

-- Conta utilizada pelo Java para acessar o MySQL.
-- A senha deve corresponder ao config.properties.
-- Esta senha e exclusiva do ambiente demonstrativo.

CREATE USER IF NOT EXISTS 'oficinadf_app'@'localhost'
IDENTIFIED BY '12345654321';


-- 4.1 CLIENTES

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.cliente
TO 'oficinadf_app'@'localhost';


-- 4.2 VEICULOS

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.veiculo
TO 'oficinadf_app'@'localhost';


-- 4.3 FUNCIONARIOS

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.funcionario
TO 'oficinadf_app'@'localhost';


-- 4.4 DEMANDAS

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.demanda
TO 'oficinadf_app'@'localhost';


-- 4.5 PAGAMENTOS

GRANT SELECT, INSERT, UPDATE, DELETE
ON oficinadf.pagamento
TO 'oficinadf_app'@'localhost';

-- 4.6 ESTOQUES

GRANT SELECT ON oficinadf.item_estoque
TO 'oficinadf_app'@'localhost';

-- 4.7 PEÇAS

GRANT SELECT ON oficinadf.peca
TO 'oficinadf_app'@'localhost';

-- 4.8 MOVIMENTAÇÃO DO ESTOQUE

GRANT SELECT ON oficinadf.movimentacao_estoque
TO 'oficinadf_app'@'localhost';

-- 4.9 UTILIZA

GRANT SELECT, INSERT, UPDATE ON oficinadf.utiliza
TO 'oficinadf_app'@'localhost';

-- 4.9 USUARIOS DA APLICACAO

-- Permite cadastrar usuarios e consultar credenciais.
-- Nao concede acesso para excluir usuarios ou
-- modificar diretamente seus hashes e perfis.

GRANT SELECT, INSERT
ON oficinadf.usuario_sistema
TO 'oficinadf_app'@'localhost';


-- 4.7 VIEW RESTRITA DE DEMANDAS

-- Necessario para que a tela ConsultaDemandasVisao
-- consiga apresentar os registros.

GRANT SELECT
ON oficinadf.vw_consulta_demandas
TO 'oficinadf_app'@'localhost';

-- 4.8 Permissão para a tela de registrar utilização de peças

GRANT SELECT, UPDATE
ON oficinadf.peca
TO 'oficinadf_app'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON oficinadf.utiliza
TO 'oficinadf_app'@'localhost';

-- 5. VERIFICACAO DOS PERFIS E USUARIOS MYSQL

-- Verificar privilegios dos tres perfis.

SHOW GRANTS FOR 'perfil_administrador';
SHOW GRANTS FOR 'perfil_atendente';
SHOW GRANTS FOR 'perfil_consulta';


-- Verificar os perfis atribuidos aos usuarios de teste.

SHOW GRANTS FOR 'teste_administrador'@'localhost';
SHOW GRANTS FOR 'teste_atendente'@'localhost';
SHOW GRANTS FOR 'teste_consulta'@'localhost';


-- Verificar privilegios da conexao JDBC.

SHOW GRANTS FOR 'oficinadf_app'@'localhost';


-- 6. VERIFICACAO DAS CREDENCIAIS DA APLICACAO

-- 6.1 Primeiro Usuário para interação com o aplicativo:

INSERT INTO usuario_sistema (
    login,
    senha_hash,
    senha_salt,
    iteracoes,
    ativo,
    perfil
)
VALUES (
    'PrimeiroAdmin',
    UNHEX('AE040090987836A3362D467E5099FE9F8558B259104F6D121292657DFA8B2D45'),
    UNHEX('31F5DFB1D77D633907A81FDF7A4B41AD'),
    210000,
    TRUE,
    'ADMINISTRADOR'
)
ON DUPLICATE KEY UPDATE
    login = login;
    
    -- SENHA : Senha123

-- Verificar cadastro inicial

SELECT
    id_usuario,
    login,
    perfil,
    ativo,
    LENGTH(senha_hash) AS tamanho_hash,
    LENGTH(senha_salt) AS tamanho_salt,
    iteracoes
FROM usuario_sistema
WHERE login = 'PrimeiroAdmin';

-- Listar usuarios cadastrados pelo Java.
-- Em uma instalacao nova, pode retornar zero linhas.

SELECT
    id_usuario,
    login,
    perfil,
    ativo
FROM usuario_sistema
ORDER BY id_usuario;


-- Conferir os tamanhos dos hashes e salts.
-- O Java utiliza PBKDF2WithHmacSHA256.
-- Esperado: hash de 32 bytes e salt de 16 bytes.

SELECT
    id_usuario,
    login,
    LENGTH(senha_hash) AS tamanho_hash,
    LENGTH(senha_salt) AS tamanho_salt,
    iteracoes,
    ativo
FROM usuario_sistema;

-- FIM DO SCRIPT 02 - SEGURANCA B5
