
-- 02_carga.sql
-- CARGA INICIAL - OFICINA MECÂNICA

USE oficina_mecanica;

-- 1. CLIENTE

INSERT INTO cliente (id_cliente, nome) VALUES
(1, 'Carlos Almeida'),
(2, 'Mariana Souza'),
(3, 'Joao Pereira'),
(4, 'Fernanda Oliveira'),
(5, 'Rafael Santos'),
(6, 'Camila Rodrigues'),
(7, 'Lucas Martins'),
(8, 'Juliana Costa'),
(9, 'Bruno Ferreira'),
(10, 'Ana Carvalho'),
(11, 'Gabriel Mendes'),
(12, 'Larissa Gomes'),
(13, 'Mateus Ribeiro'),
(14, 'Beatriz Lima'),
(15, 'Pedro Nascimento'),
(16, 'Isabela Rocha'),
(17, 'Diego Barbosa'),
(18, 'Amanda Teixeira'),
(19, 'Thiago Cardoso'),
(20, 'Natalia Moreira'),
(21, 'Eduardo Castro'),
(22, 'Leticia Alves'),
(23, 'Vinicius Correia'),
(24, 'Patricia Moura'),
(25, 'Gustavo Freitas'),
(26, 'Julia Monteiro'),
(27, 'Henrique Araujo'),
(28, 'Marina Dias'),
(29, 'Felipe Batista'),
(30, 'Carolina Ramos'),
(31, 'Leonardo Vieira'),
(32, 'Bianca Duarte'),
(33, 'Rodrigo Campos'),
(34, 'Clara Teixeira'),
(35, 'Andre Mendes'),
(36, 'Sofia Martins'),
(37, 'Marcelo Lopes'),
(38, 'Alice Fernandes'),
(39, 'Caio Nunes'),
(40, 'Luana Borges');

-- 2. VEICULO

INSERT INTO veiculo (placa, modelo, id_cliente) VALUES
('ABC1A01', 'Fiat Argo', 1),
('ABC1A02', 'Chevrolet Onix', 2),
('ABC1A03', 'Volkswagen Polo', 3),
('ABC1A04', 'Hyundai HB20', 4),
('ABC1A05', 'Toyota Corolla', 5),
('ABC1A06', 'Honda Civic', 6),
('ABC1A07', 'Fiat Cronos', 7),
('ABC1A08', 'Renault Kwid', 8),
('ABC1A09', 'Nissan Kicks', 9),
('ABC1A10', 'Jeep Renegade', 10),
('ABC1A11', 'Volkswagen T-Cross', 11),
('ABC1A12', 'Fiat Mobi', 12),
('ABC1A13', 'Chevrolet Tracker', 13),
('ABC1A14', 'Hyundai Creta', 14),
('ABC1A15', 'Toyota Yaris', 15),
('ABC1A16', 'Honda Fit', 16),
('ABC1A17', 'Fiat Pulse', 17),
('ABC1A18', 'Renault Duster', 18),
('ABC1A19', 'Nissan Versa', 19),
('ABC1A20', 'Volkswagen Virtus', 20),
('ABC1A21', 'Chevrolet Prisma', 21),
('ABC1A22', 'Fiat Siena', 22),
('ABC1A23', 'Ford Ka', 23),
('ABC1A24', 'Hyundai i30', 24),
('ABC1A25', 'Toyota Etios', 25),
('ABC1A26', 'Honda HR-V', 26),
('ABC1A27', 'Jeep Compass', 27),
('ABC1A28', 'Volkswagen Taos', 28),
('ABC1A29', 'Fiat Strada', 29),
('ABC1A30', 'Chevrolet Montana', 30),
('ABC1A31', 'Ford Ranger', 31),
('ABC1A32', 'Toyota Hilux', 32),
('ABC1A33', 'Nissan Frontier', 33),
('ABC1A34', 'Mitsubishi L200', 34),
('ABC1A35', 'Renault Oroch', 35),
('ABC1A36', 'Fiat Toro', 36),
('ABC1A37', 'Volkswagen Saveiro', 37),
('ABC1A38', 'Chevrolet S10', 38),
('ABC1A39', 'Ford EcoSport', 39),
('ABC1A40', 'Kia Sportage', 40);

-- 3. FUNCIONARIO

INSERT INTO funcionario
(id_funcionario, nome, cpf, data_admissao) VALUES
(1, 'Roberto Almeida', '00000000101', '2021-02-10'),
(2, 'Marcos Souza', '00000000202', '2021-05-18'),
(3, 'Daniel Pereira', '00000000303', '2022-01-12'),
(4, 'Paulo Santos', '00000000404', '2022-07-25'),
(5, 'Renato Oliveira', '00000000505', '2023-03-10'),
(6, 'Felipe Costa', '00000000606', '2023-06-15'),
(7, 'Bruno Martins', '00000000707', '2023-08-21'),
(8, 'Diego Ferreira', '00000000808', '2024-01-08'),
(9, 'Lucas Carvalho', '00000000909', '2024-04-12'),
(10, 'Andre Ribeiro', '00000001010', '2024-07-01'),
(11, 'Gustavo Lima', '00000001111', '2024-09-17'),
(12, 'Caio Mendes', '00000001212', '2025-01-20'),
(13, 'Eduardo Rocha', '00000001313', '2025-03-11'),
(14, 'Victor Barbosa', '00000001414', '2025-05-05'),
(15, 'Henrique Gomes', '00000001515', '2025-07-14'),
(16, 'Rafael Teixeira', '00000001616', '2025-09-02'),
(17, 'Mateus Castro', '00000001717', '2025-11-10'),
(18, 'Joao Moreira', '00000001818', '2026-01-15'),
(19, 'Arthur Alves', '00000001919', '2026-03-01'),
(20, 'Murilo Correia', '00000002020', '2026-04-18');

-- 4. GERENTE

INSERT INTO gerente (id_funcionario) VALUES
(1),
(2),
(3),
(4);

-- 5. MECANICO

INSERT INTO mecanico (id_funcionario) VALUES
(5),
(6),
(7),
(8),
(9),
(10);

-- 6. ATENDENTE

INSERT INTO atendente (id_funcionario) VALUES
(11),
(12),
(13),
(14);

-- 7. ADMINISTRADOR

INSERT INTO administrador (id_funcionario) VALUES
(15),
(16);

-- 8. REPOSITOR

INSERT INTO repositor (id_funcionario) VALUES
(17),
(18),
(19),
(20);

-- 9. CATEGORIA

INSERT INTO categoria
(id_categoria, nome, descricao) VALUES
(1, 'Motor', 'Componentes relacionados ao motor'),
(2, 'Freios', 'Componentes do sistema de freios'),
(3, 'Suspensao', 'Componentes da suspensao'),
(4, 'Eletrica', 'Componentes eletricos'),
(5, 'Filtros', 'Filtros utilizados nos veiculos'),
(6, 'Lubrificantes', 'Oleo e produtos lubrificantes'),
(7, 'Ferramentas', 'Ferramentas utilizadas na oficina'),
(8, 'Diagnostico', 'Equipamentos de diagnostico'),
(9, 'Pneus', 'Pneus e componentes relacionados'),
(10, 'Transmissao', 'Componentes da transmissao');

-- 10. ITEM_ESTOQUE
-- 100 ITENS

INSERT INTO item_estoque
(id_item, status, id_categoria) VALUES
(1, 'DISPONIVEL', 1),
(2, 'DISPONIVEL', 1),
(3, 'DISPONIVEL', 1),
(4, 'DISPONIVEL', 1),
(5, 'DISPONIVEL', 1),
(6, 'DISPONIVEL', 2),
(7, 'DISPONIVEL', 2),
(8, 'DISPONIVEL', 2),
(9, 'DISPONIVEL', 2),
(10, 'DISPONIVEL', 2),
(11, 'DISPONIVEL', 3),
(12, 'DISPONIVEL', 3),
(13, 'DISPONIVEL', 3),
(14, 'DISPONIVEL', 3),
(15, 'DISPONIVEL', 3),
(16, 'DISPONIVEL', 4),
(17, 'DISPONIVEL', 4),
(18, 'DISPONIVEL', 4),
(19, 'DISPONIVEL', 4),
(20, 'DISPONIVEL', 4),
(21, 'DISPONIVEL', 5),
(22, 'DISPONIVEL', 5),
(23, 'DISPONIVEL', 5),
(24, 'DISPONIVEL', 5),
(25, 'DISPONIVEL', 5),
(26, 'DISPONIVEL', 6),
(27, 'DISPONIVEL', 6),
(28, 'DISPONIVEL', 6),
(29, 'DISPONIVEL', 6),
(30, 'DISPONIVEL', 6),
(31, 'DISPONIVEL', 7),
(32, 'DISPONIVEL', 7),
(33, 'DISPONIVEL', 7),
(34, 'DISPONIVEL', 7),
(35, 'DISPONIVEL', 7),
(36, 'DISPONIVEL', 8),
(37, 'DISPONIVEL', 8),
(38, 'DISPONIVEL', 8),
(39, 'DISPONIVEL', 8),
(40, 'DISPONIVEL', 8),
(41, 'DISPONIVEL', 9),
(42, 'DISPONIVEL', 9),
(43, 'DISPONIVEL', 9),
(44, 'DISPONIVEL', 9),
(45, 'DISPONIVEL', 9),
(46, 'DISPONIVEL', 10),
(47, 'DISPONIVEL', 10),
(48, 'DISPONIVEL', 10),
(49, 'DISPONIVEL', 10),
(50, 'DISPONIVEL', 10),
(51, 'DISPONIVEL', 1),
(52, 'DISPONIVEL', 2),
(53, 'DISPONIVEL', 3),
(54, 'DISPONIVEL', 4),
(55, 'DISPONIVEL', 5),
(56, 'DISPONIVEL', 6),
(57, 'DISPONIVEL', 7),
(58, 'DISPONIVEL', 8),
(59, 'DISPONIVEL', 9),
(60, 'DISPONIVEL', 10),
(61, 'DISPONIVEL', 1),
(62, 'DISPONIVEL', 2),
(63, 'DISPONIVEL', 3),
(64, 'DISPONIVEL', 4),
(65, 'DISPONIVEL', 5),
(66, 'DISPONIVEL', 6),
(67, 'DISPONIVEL', 7),
(68, 'DISPONIVEL', 8),
(69, 'DISPONIVEL', 9),
(70, 'DISPONIVEL', 10),
(71, 'DISPONIVEL', 1),
(72, 'DISPONIVEL', 2),
(73, 'DISPONIVEL', 3),
(74, 'DISPONIVEL', 4),
(75, 'DISPONIVEL', 5),
(76, 'DISPONIVEL', 6),
(77, 'DISPONIVEL', 7),
(78, 'DISPONIVEL', 8),
(79, 'DISPONIVEL', 9),
(80, 'DISPONIVEL', 10),
(81, 'DISPONIVEL', 1),
(82, 'DISPONIVEL', 2),
(83, 'DISPONIVEL', 3),
(84, 'DISPONIVEL', 4),
(85, 'DISPONIVEL', 5),
(86, 'DISPONIVEL', 6),
(87, 'DISPONIVEL', 7),
(88, 'DISPONIVEL', 8),
(89, 'DISPONIVEL', 9),
(90, 'DISPONIVEL', 10),
(91, 'DISPONIVEL', 1),
(92, 'DISPONIVEL', 2),
(93, 'DISPONIVEL', 3),
(94, 'DISPONIVEL', 4),
(95, 'DISPONIVEL', 5),
(96, 'DISPONIVEL', 6),
(97, 'DISPONIVEL', 7),
(98, 'DISPONIVEL', 8),
(99, 'DISPONIVEL', 9),
(100, 'DISPONIVEL', 10);

-- 11. PECA
-- ITENS 1 A 60
INSERT INTO peca (id_item, qtd_estoque) VALUES
(1, 20), (2, 15), (3, 30), (4, 12), (5, 25),
(6, 18), (7, 20), (8, 16), (9, 22), (10, 14),
(11, 10), (12, 25), (13, 18), (14, 20), (15, 15),
(16, 30), (17, 12), (18, 20), (19, 25), (20, 18),
(21, 40), (22, 35), (23, 30), (24, 25), (25, 20),
(26, 50), (27, 45), (28, 40), (29, 35), (30, 30),
(46, 10), (47, 15), (48, 12), (49, 20), (50, 18),
(51, 15), (52, 20), (53, 25), (54, 18), (55, 30),
(56, 25), (57, 10), (58, 15), (59, 20), (60, 12),
(61, 18), (62, 20), (63, 15), (64, 25), (65, 30),
(66, 20), (67, 15), (68, 18), (69, 12), (70, 20);


-- =====================================================
-- 12. EQUIPAMENTO
-- ITENS 31 A 45 E 71 A 100
-- =====================================================

INSERT INTO equipamento (id_item, patrimonio) VALUES
(31, 'PAT-00031'),
(32, 'PAT-00032'),
(33, 'PAT-00033'),
(34, 'PAT-00034'),
(35, 'PAT-00035'),
(36, 'PAT-00036'),
(37, 'PAT-00037'),
(38, 'PAT-00038'),
(39, 'PAT-00039'),
(40, 'PAT-00040'),
(41, 'PAT-00041'),
(42, 'PAT-00042'),
(43, 'PAT-00043'),
(44, 'PAT-00044'),
(45, 'PAT-00045'),
(71, 'PAT-00071'),
(72, 'PAT-00072'),
(73, 'PAT-00073'),
(74, 'PAT-00074'),
(75, 'PAT-00075'),
(76, 'PAT-00076'),
(77, 'PAT-00077'),
(78, 'PAT-00078'),
(79, 'PAT-00079'),
(80, 'PAT-00080'),
(81, 'PAT-00081'),
(82, 'PAT-00082'),
(83, 'PAT-00083'),
(84, 'PAT-00084'),
(85, 'PAT-00085'),
(86, 'PAT-00086'),
(87, 'PAT-00087'),
(88, 'PAT-00088'),
(89, 'PAT-00089'),
(90, 'PAT-00090'),
(91, 'PAT-00091'),
(92, 'PAT-00092'),
(93, 'PAT-00093'),
(94, 'PAT-00094'),
(95, 'PAT-00095'),
(96, 'PAT-00096'),
(97, 'PAT-00097'),
(98, 'PAT-00098'),
(99, 'PAT-00099'),
(100, 'PAT-00100');

-- 13. MOVIMENTACAO_ESTOQUE

INSERT INTO movimentacao_estoque
(id_mov, tipo_movimentacao, data_movimentacao, id_item) VALUES
(1, 'ENTRADA', '2026-01-05 08:00:00', 1),
(2, 'ENTRADA', '2026-01-06 08:15:00', 2),
(3, 'ENTRADA', '2026-01-07 08:30:00', 3),
(4, 'SAIDA', '2026-01-08 09:00:00', 4),
(5, 'ENTRADA', '2026-01-10 09:15:00', 5),
(6, 'SAIDA', '2026-01-12 09:30:00', 6),
(7, 'ENTRADA', '2026-01-14 10:00:00', 7),
(8, 'SAIDA', '2026-01-15 10:30:00', 8),
(9, 'ENTRADA', '2026-01-17 11:00:00', 9),
(10, 'SAIDA', '2026-01-18 11:30:00', 10),
(11, 'ENTRADA', '2026-01-20 08:00:00', 11),
(12, 'SAIDA', '2026-01-21 08:30:00', 12),
(13, 'ENTRADA', '2026-01-23 09:00:00', 13),
(14, 'SAIDA', '2026-01-24 09:30:00', 14),
(15, 'ENTRADA', '2026-01-26 10:00:00', 15),
(16, 'SAIDA', '2026-01-27 10:30:00', 16),
(17, 'ENTRADA', '2026-01-29 11:00:00', 17),
(18, 'SAIDA', '2026-01-30 11:30:00', 18),
(19, 'ENTRADA', '2026-02-02 08:00:00', 19),
(20, 'SAIDA', '2026-02-03 08:30:00', 20),
(21, 'ENTRADA', '2026-02-05 09:00:00', 21),
(22, 'SAIDA', '2026-02-06 09:30:00', 22),
(23, 'ENTRADA', '2026-02-08 10:00:00', 23),
(24, 'SAIDA', '2026-02-09 10:30:00', 24),
(25, 'ENTRADA', '2026-02-11 11:00:00', 25),
(26, 'SAIDA', '2026-02-12 11:30:00', 26),
(27, 'ENTRADA', '2026-02-14 08:00:00', 27),
(28, 'SAIDA', '2026-02-15 08:30:00', 28),
(29, 'ENTRADA', '2026-02-17 09:00:00', 29),
(30, 'SAIDA', '2026-02-18 09:30:00', 30),
(31, 'ENTRADA', '2026-02-20 10:00:00', 31),
(32, 'SAIDA', '2026-02-21 10:30:00', 32),
(33, 'ENTRADA', '2026-02-23 11:00:00', 33),
(34, 'SAIDA', '2026-02-24 11:30:00', 34),
(35, 'ENTRADA', '2026-02-26 08:00:00', 35),
(36, 'SAIDA', '2026-02-27 08:30:00', 36),
(37, 'ENTRADA', '2026-03-01 09:00:00', 37),
(38, 'SAIDA', '2026-03-02 09:30:00', 38),
(39, 'ENTRADA', '2026-03-04 10:00:00', 39),
(40, 'SAIDA', '2026-03-05 10:30:00', 40);

-- 14. DEMANDA

INSERT INTO demanda
(id_demanda, status, data_hora_abertura, placa, id_item) VALUES
(1, 'ABERTA', '2026-03-01 08:00:00', 'ABC1A01', 1),
(2, 'CONCLUIDA', '2026-03-01 09:00:00', 'ABC1A02', 2),
(3, 'EM_EXECUCAO', '2026-03-02 08:30:00', 'ABC1A03', 3),
(4, 'CONCLUIDA', '2026-03-02 10:00:00', 'ABC1A04', 4),
(5, 'ABERTA', '2026-03-03 08:15:00', 'ABC1A05', 5),
(6, 'CONCLUIDA', '2026-03-03 09:30:00', 'ABC1A06', 6),
(7, 'EM_EXECUCAO', '2026-03-04 08:00:00', 'ABC1A07', 7),
(8, 'CONCLUIDA', '2026-03-04 10:30:00', 'ABC1A08', 8),
(9, 'ABERTA', '2026-03-05 08:45:00', 'ABC1A09', 9),
(10, 'CONCLUIDA', '2026-03-05 09:15:00', 'ABC1A10', 10),
(11, 'EM_EXECUCAO', '2026-03-06 08:00:00', 'ABC1A11', 11),
(12, 'CONCLUIDA', '2026-03-06 09:00:00', 'ABC1A12', 12),
(13, 'ABERTA', '2026-03-07 08:30:00', 'ABC1A13', 13),
(14, 'CONCLUIDA', '2026-03-07 10:00:00', 'ABC1A14', 14),
(15, 'EM_EXECUCAO', '2026-03-08 08:15:00', 'ABC1A15', 15),
(16, 'CONCLUIDA', '2026-03-08 09:45:00', 'ABC1A16', 16),
(17, 'ABERTA', '2026-03-09 08:00:00', 'ABC1A17', 17),
(18, 'CONCLUIDA', '2026-03-09 10:30:00', 'ABC1A18', 18),
(19, 'EM_EXECUCAO', '2026-03-10 08:45:00', 'ABC1A19', 19),
(20, 'CONCLUIDA', '2026-03-10 09:15:00', 'ABC1A20', 20),
(21, 'ABERTA', '2026-03-11 08:00:00', 'ABC1A21', 21),
(22, 'CONCLUIDA', '2026-03-11 09:30:00', 'ABC1A22', 22),
(23, 'EM_EXECUCAO', '2026-03-12 08:30:00', 'ABC1A23', 23),
(24, 'CONCLUIDA', '2026-03-12 10:00:00', 'ABC1A24', 24),
(25, 'ABERTA', '2026-03-13 08:15:00', 'ABC1A25', 25),
(26, 'CONCLUIDA', '2026-03-13 09:45:00', 'ABC1A26', 26),
(27, 'EM_EXECUCAO', '2026-03-14 08:00:00', 'ABC1A27', 27),
(28, 'CONCLUIDA', '2026-03-14 10:30:00', 'ABC1A28', 28),
(29, 'ABERTA', '2026-03-15 08:45:00', 'ABC1A29', 29),
(30, 'CONCLUIDA', '2026-03-15 09:15:00', 'ABC1A30', 30),
(31, 'EM_EXECUCAO', '2026-03-16 08:00:00', 'ABC1A31', 31),
(32, 'CONCLUIDA', '2026-03-16 09:30:00', 'ABC1A32', 32),
(33, 'ABERTA', '2026-03-17 08:30:00', 'ABC1A33', 33),
(34, 'CONCLUIDA', '2026-03-17 10:00:00', 'ABC1A34', 34),
(35, 'EM_EXECUCAO', '2026-03-18 08:15:00', 'ABC1A35', 35),
(36, 'CONCLUIDA', '2026-03-18 09:45:00', 'ABC1A36', 36),
(37, 'ABERTA', '2026-03-19 08:00:00', 'ABC1A37', 37),
(38, 'CONCLUIDA', '2026-03-19 10:30:00', 'ABC1A38', 38),
(39, 'EM_EXECUCAO', '2026-03-20 08:45:00', 'ABC1A39', 39),
(40, 'CONCLUIDA', '2026-03-20 09:15:00', 'ABC1A40', 40);

-- 15. FORMA DE PAGAMENTO

INSERT INTO forma_pagamento
(id_forma, descricao) VALUES
(1, 'Dinheiro'),
(2, 'Cartao de Credito'),
(3, 'Cartao de Debito'),
(4, 'PIX'),
(5, 'Transferencia Bancaria');

-- 16. PAGAMENTO

INSERT INTO pagamento
(id_pagamento, valor_pagamento, data_pagamento, id_demanda, id_forma) VALUES
(1, 250.00, '2026-03-01', 1, 4),
(2, 480.00, '2026-03-02', 2, 2),
(3, 320.00, '2026-03-03', 3, 1),
(4, 750.00, '2026-03-04', 4, 4),
(5, 180.00, '2026-03-05', 5, 3),
(6, 620.00, '2026-03-06', 6, 2),
(7, 410.00, '2026-03-07', 7, 4),
(8, 890.00, '2026-03-08', 8, 5),
(9, 275.00, '2026-03-09', 9, 1),
(10, 540.00, '2026-03-10', 10, 4),
(11, 360.00, '2026-03-11', 11, 2),
(12, 680.00, '2026-03-12', 12, 3),
(13, 225.00, '2026-03-13', 13, 4),
(14, 470.00, '2026-03-14', 14, 2),
(15, 920.00, '2026-03-15', 15, 5),
(16, 330.00, '2026-03-16', 16, 1),
(17, 580.00, '2026-03-17', 17, 4),
(18, 760.00, '2026-03-18', 18, 2),
(19, 295.00, '2026-03-19', 19, 3),
(20, 650.00, '2026-03-20', 20, 4);

-- 17. EXECUTA

INSERT INTO executa
(id_demanda, id_funcionario, data_execucao) VALUES
(1, 1, '2026-03-01 08:30:00'),
(2, 2, '2026-03-02 09:30:00'),
(3, 3, '2026-03-03 09:00:00'),
(4, 4, '2026-03-04 10:30:00'),
(5, 1, '2026-03-05 08:45:00'),
(6, 2, '2026-03-06 10:00:00'),
(7, 3, '2026-03-07 08:30:00'),
(8, 4, '2026-03-08 11:00:00'),
(9, 1, '2026-03-09 09:00:00'),
(10, 2, '2026-03-10 10:00:00'),
(11, 3, '2026-03-11 08:30:00'),
(12, 4, '2026-03-12 09:30:00'),
(13, 1, '2026-03-13 09:00:00'),
(14, 2, '2026-03-14 10:30:00'),
(15, 3, '2026-03-15 08:45:00'),
(16, 4, '2026-03-16 10:00:00'),
(17, 1, '2026-03-17 08:30:00'),
(18, 2, '2026-03-18 09:30:00'),
(19, 3, '2026-03-19 09:00:00'),
(20, 4, '2026-03-20 10:30:00');


-- =====================================================
-- 18. SUPERVISIONA
-- =====================================================

INSERT INTO supervisiona
(id_gerente, id_funcionario, data_inicio) VALUES
(1, 5, '2024-01-10'),
(1, 6, '2024-01-10'),
(1, 11, '2024-01-10'),
(1, 17, '2024-01-10'),
(2, 7, '2024-02-15'),
(2, 8, '2024-02-15'),
(2, 12, '2024-02-15'),
(2, 18, '2024-02-15'),
(3, 9, '2025-01-10'),
(3, 10, '2025-01-10'),
(3, 13, '2025-01-10'),
(3, 19, '2025-01-10'),
(4, 14, '2025-02-20'),
(4, 15, '2025-02-20'),
(4, 16, '2025-02-20'),
(4, 20, '2025-02-20');

-- 19. REGISTRA

INSERT INTO registra
(id_mov, id_item, quantidade) VALUES
(1, 1, 10),
(2, 2, 5),
(3, 3, 8),
(4, 4, 2),
(5, 5, 10),
(6, 6, 3),
(7, 7, 5),
(8, 8, 2),
(9, 9, 8),
(10, 10, 4),
(11, 11, 3),
(12, 12, 2),
(13, 13, 5),
(14, 14, 3),
(15, 15, 6),
(16, 16, 2),
(17, 17, 4),
(18, 18, 2),
(19, 19, 5),
(20, 20, 3),
(21, 21, 10),
(22, 22, 4),
(23, 23, 8),
(24, 24, 3),
(25, 25, 6),
(26, 26, 5),
(27, 27, 4),
(28, 28, 2),
(29, 29, 7),
(30, 30, 3),
(31, 31, 1),
(32, 32, 1),
(33, 33, 2),
(34, 34, 1),
(35, 35, 1),
(36, 36, 1),
(37, 37, 2),
(38, 38, 1),
(39, 39, 1),
(40, 40, 1);