USE oficina_mecanica;

-- 1. CLIENTE — 40 (ids 36–40 sem veículo = caso de contorno)
INSERT INTO cliente (id_cliente, nome) VALUES
(1,'Ana Paula Ribeiro'),(2,'Bruno Carvalho Mendes'),(3,'Carla Souza Lima'),
(4,'Daniel Oliveira Castro'),(5,'Eduarda Nunes Ferreira'),(6,'Fábio Almeida Pinto'),
(7,'Gabriela Moreira Tavares'),(8,'Henrique Barbosa Rocha'),(9,'Isabela Cardoso Dias'),
(10,'João Pedro Martins'),(11,'Karina Lopes Andrade'),(12,'Leonardo Vieira Santos'),
(13,'Mariana Costa Pereira'),(14,'Nelson Ramos Correia'),(15,'Otávio Freitas Melo'),
(16,'Patrícia Gomes Azevedo'),(17,'Quintino Bezerra Neto'),(18,'Renata Farias Coelho'),
(19,'Sérgio Tavares Braga'),(20,'Tatiana Ribeiro Machado'),(21,'Ubirajara Nogueira Pires'),
(22,'Vanessa Duarte Camargo'),(23,'Wagner Simões Batista'),(24,'Xênia Portela Vasques'),
(25,'Yuri Mendonça Cordeiro'),(26,'Zilda Amaral Peixoto'),(27,'Alexandre Bulhões Sá'),
(28,'Beatriz Quintanilha Leal'),(29,'Caio Estevão Rangel'),(30,'Débora Cristina Vasconcelos'),
(31,'Elias Monteiro Fagundes'),(32,'Fernanda Lacerda Bittencourt'),(33,'Gustavo Henrique Sales'),
(34,'Helena Martins Cabral'),(35,'Igor Sampaio Bandeira'),(36,'Juliana Prates Estrela'),
(37,'Kleber Antunes Mourão'),(38,'Larissa Fontes Aguiar'),(39,'Marcelo Trindade Vasques'),
(40,'Natália Rezende Paiva');

-- 2. VEICULO — 30
INSERT INTO veiculo (placa, modelo, id_cliente) VALUES
('RTA1A23','Volkswagen Gol 1.0',1),('RTA2B34','Fiat Argo Drive 1.3',1),
('QWE4C56','Chevrolet Onix LT 1.0',2),('QWE5D67','Hyundai HB20S Vision',3),
('ASD7E89','Toyota Corolla XEi 2.0',4),('ASD8F90','Honda Civic EXL 2.0',4),
('ZXC1G23','Renault Kwid Zen',5),('ZXC2H34','Jeep Renegade Sport',6),
('POI3I45','Ford Ka SE 1.0',7),('POI4J56','Fiat Mobi Like',8),
('LKJ5K67','Chevrolet Tracker LT',9),('LKJ6L78','Nissan Kicks SV',10),
('MNB7M89','Volkswagen T-Cross Comfortline',11),('MNB8N90','Toyota Yaris XL',12),
('VBN9O01','Honda Fit LX',13),('VBN0P12','Hyundai Creta Comfort',14),
('TGB1Q23','Renault Sandero Stepway',14),('TGB2R34','Fiat Cronos Precision',15),
('YHN3S45','Chevrolet Prisma LTZ',16),('YHN4T56','Ford EcoSport Titanium',17),
('UJM5U67','Volkswagen Polo Highline',18),('UJM6V78','Toyota Etios XLS',19),
('IKL7W89','Honda City EX',20),('IKL8X90','Renault Logan Iconic',21),
('OLP9Y01','Fiat Strada Freedom',22),('OLP0Z12','Chevrolet S10 LTZ',23),
('EDC1A23','Toyota Hilux SRX',24),('EDC2B34','Ford Ranger XLT',25),
('RFV3C45','Volkswagen Saveiro Cross',26),('RFV4D56','Fiat Toro Volcano',27);

-- 3. FUNCIONARIO — 35
INSERT INTO funcionario (id_funcionario, nome, cpf, data_admissao) VALUES
(1,'Roberto Salles Miranda','111.111.111-01','2018-03-12'),
(2,'Cláudia Fontes Ribeiro','111.111.111-02','2019-07-01'),
(3,'Maurício Andrade Prado','111.111.111-03','2020-01-15'),
(4,'Beatriz Nogueira Aragão','111.111.111-04','2021-05-20'),
(5,'Fernando Coutinho Bastos','111.111.111-05','2017-11-08'),
(6,'Anderson Luís Pereira','222.222.222-01','2019-02-10'),
(7,'Bruno Tavares Menezes','222.222.222-02','2019-06-22'),
(8,'Carlos Eduardo Nunes','222.222.222-03','2020-09-05'),
(9,'Diego Ramos Figueiredo','222.222.222-04','2020-12-01'),
(10,'Eduardo Sales Barreto','222.222.222-05','2021-03-18'),
(11,'Felipe Augusto Camargo','222.222.222-06','2021-07-09'),
(12,'Gustavo Henrique Lopes','222.222.222-07','2021-10-27'),
(13,'Hélio Barbosa Teles','222.222.222-08','2022-01-14'),
(14,'Ivan Cardoso Bittencourt','222.222.222-09','2022-04-03'),
(15,'Jonas Vieira Estrela','222.222.222-10','2022-08-19'),
(16,'Kleber Moreira Sampaio','222.222.222-11','2022-11-06'),
(17,'Lucas Peixoto Arruda','222.222.222-12','2023-02-12'),
(18,'Marcelo Duarte Quintela','222.222.222-13','2023-05-25'),
(19,'Nelson Fagundes Coelho','222.222.222-14','2023-09-11'),
(20,'Otávio Cordeiro Pacheco','222.222.222-15','2023-12-04'),
(21,'Paulo Ricardo Simões','222.222.222-16','2024-02-19'),
(22,'Quintino Vasques Bandeira','222.222.222-17','2024-06-08'),
(23,'Rodrigo Amaral Cabral','222.222.222-18','2024-09-23'),
(24,'Sérgio Luís Aguiar','222.222.222-19','2025-01-15'),
(25,'Tiago Ferreira Bulhões','222.222.222-20','2025-04-02'),
(26,'Aline Cristina Machado','333.333.333-01','2020-04-14'),
(27,'Bianca Lacerda Prates','333.333.333-02','2020-08-30'),
(28,'Camila Andrade Rezende','333.333.333-03','2021-02-07'),
(29,'Daniela Farias Paiva','333.333.333-04','2021-06-21'),
(30,'Elaine Portela Mourão','333.333.333-05','2022-03-05'),
(31,'Kátia Regina Monteiro','444.444.444-01','2018-05-22'),
(32,'Lúcia Helena Salles','444.444.444-02','2019-11-19'),
(33,'Marina Estevão Coutinho','444.444.444-03','2021-08-02'),
(34,'Pedro Henrique Correia','555.555.555-01','2020-07-08'),
(35,'Quirino Lopes Barbosa','555.555.555-02','2021-01-25');

-- 4. GERENTE — 5
INSERT INTO gerente (id_funcionario) VALUES (1),(2),(3),(4),(5);

-- 5. MECANICO — 20
INSERT INTO mecanico (id_funcionario) VALUES
(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),
(16),(17),(18),(19),(20),(21),(22),(23),(24),(25);

-- 6. ATENDENTE — 5
INSERT INTO atendente (id_funcionario) VALUES (26),(27),(28),(29),(30);

-- 7. ADMINISTRADOR — 3
INSERT INTO administrador (id_funcionario) VALUES (31),(32),(33);

-- 8. REPOSITOR — 2
INSERT INTO repositor (id_funcionario) VALUES (34),(35);

-- 9. CATEGORIA — 6
INSERT INTO categoria (id_categoria, nome, descricao) VALUES
(1,'Freios','Pastilhas, discos, lonas e fluido de freio'),
(2,'Suspensão','Amortecedores, molas, bandejas e pivôs'),
(3,'Motor','Filtros, correias, velas, bobinas'),
(4,'Elétrica','Baterias, alternadores, sensores e módulos'),
(5,'Pneus e Rodas','Pneus, rodas e válvulas'),
(6,'Lubrificantes','Óleos de motor, câmbio e direção');

-- 10. ITEM_ESTOQUE — 50 (1–40 peças; 41–50 equipamentos)
INSERT INTO item_estoque (id_item, status, id_categoria) VALUES
(1,'ATIVO',1),(2,'ATIVO',1),(3,'ATIVO',1),(4,'ATIVO',1),(5,'INATIVO',1),
(6,'ATIVO',1),(7,'ATIVO',1),(8,'ATIVO',2),(9,'ATIVO',2),(10,'ATIVO',2),
(11,'ATIVO',2),(12,'INATIVO',2),(13,'ATIVO',2),(14,'ATIVO',2),(15,'ATIVO',3),
(16,'ATIVO',3),(17,'ATIVO',3),(18,'ATIVO',3),(19,'ATIVO',3),(20,'ATIVO',3),
(21,'ATIVO',3),(22,'INATIVO',3),(23,'ATIVO',4),(24,'ATIVO',4),(25,'ATIVO',4),
(26,'ATIVO',4),(27,'ATIVO',4),(28,'ATIVO',4),(29,'INATIVO',4),(30,'ATIVO',5),
(31,'ATIVO',5),(32,'ATIVO',5),(33,'ATIVO',5),(34,'INATIVO',5),(35,'ATIVO',5),
(36,'ATIVO',6),(37,'ATIVO',6),(38,'ATIVO',6),(39,'ATIVO',6),(40,'ATIVO',6),
(41,'ATIVO',4),(42,'ATIVO',4),(43,'ATIVO',4),(44,'ATIVO',3),(45,'ATIVO',3),
(46,'ATIVO',1),(47,'ATIVO',5),(48,'ATIVO',5),(49,'ATIVO',2),(50,'INATIVO',2);

-- 11. PECA — 40 (itens 1–40; qtd=0 nos itens 5,12,22,29,34 = caso de contorno)
INSERT INTO peca (id_item, qtd_estoque) VALUES
(1,40),(2,35),(3,20),(4,15),(5,0),(6,12),(7,8),(8,22),(9,18),(10,30),
(11,14),(12,0),(13,6),(14,10),(15,50),(16,45),(17,33),(18,27),(19,21),
(20,19),(21,11),(22,0),(23,25),(24,15),(25,8),(26,12),(27,6),(28,4),
(29,0),(30,60),(31,55),(32,48),(33,32),(34,0),(35,20),(36,80),(37,75),
(38,70),(39,60),(40,55);

-- 12. EQUIPAMENTO — 8 (itens 41–48; 49–50 ficam sem equipamento p/ contorno)
INSERT INTO equipamento (id_item, patrimonio) VALUES
(41,'EQP-2023-0001'),(42,'EQP-2023-0002'),(43,'EQP-2024-0003'),
(44,'EQP-2024-0004'),(45,'EQP-2024-0005'),(46,'EQP-2025-0006'),
(47,'EQP-2025-0007'),(48,'EQP-2025-0008');

-- 13. MOVIMENTACAO_ESTOQUE — 100 (mínimo do projeto)
-- Caso de contorno: itens 22, 29, 34 não aparecem (sem histórico)
INSERT INTO movimentacao_estoque (id_mov, tipo_movimentacao, data_movimentacao, id_item) VALUES
(1,'ENTRADA','2024-01-05 08:30:00',1),(2,'SAIDA','2024-01-07 14:20:00',1),
(3,'SAIDA','2024-01-12 10:00:00',1),(4,'ENTRADA','2024-01-15 09:45:00',1),
(5,'ENTRADA','2024-01-06 08:15:00',2),(6,'SAIDA','2024-01-10 16:30:00',2),
(7,'SAIDA','2024-01-20 11:10:00',2),(8,'ENTRADA','2024-02-01 09:00:00',3),
(9,'SAIDA','2024-02-04 15:45:00',3),(10,'ENTRADA','2024-02-10 08:00:00',4),
(11,'SAIDA','2024-02-15 13:20:00',4),(12,'ENTRADA','2024-02-20 09:30:00',6),
(13,'SAIDA','2024-02-25 17:00:00',6),(14,'ENTRADA','2024-03-01 08:45:00',7),
(15,'SAIDA','2024-03-05 14:10:00',7),(16,'ENTRADA','2024-03-10 09:00:00',8),
(17,'SAIDA','2024-03-14 15:30:00',8),(18,'SAIDA','2024-03-20 11:50:00',8),
(19,'ENTRADA','2024-03-25 08:20:00',9),(20,'SAIDA','2024-03-28 16:00:00',9),
(21,'ENTRADA','2024-04-01 09:15:00',10),(22,'SAIDA','2024-04-05 13:40:00',10),
(23,'ENTRADA','2024-04-10 08:30:00',11),(24,'SAIDA','2024-04-14 14:55:00',11),
(25,'ENTRADA','2024-04-20 09:00:00',13),(26,'SAIDA','2024-04-25 16:20:00',13),
(27,'ENTRADA','2024-05-02 08:40:00',14),(28,'SAIDA','2024-05-06 15:00:00',14),
(29,'ENTRADA','2024-05-10 09:20:00',15),(30,'SAIDA','2024-05-14 13:30:00',15),
(31,'SAIDA','2024-05-18 16:45:00',15),(32,'ENTRADA','2024-05-22 08:10:00',16),
(33,'SAIDA','2024-05-26 14:00:00',16),(34,'ENTRADA','2024-06-01 09:00:00',17),
(35,'SAIDA','2024-06-05 15:15:00',17),(36,'ENTRADA','2024-06-10 08:25:00',18),
(37,'SAIDA','2024-06-14 13:50:00',18),(38,'ENTRADA','2024-06-20 09:10:00',19),
(39,'SAIDA','2024-06-24 16:30:00',19),(40,'ENTRADA','2024-07-01 08:35:00',20),
(41,'SAIDA','2024-07-05 14:20:00',20),(42,'ENTRADA','2024-07-10 09:05:00',21),
(43,'SAIDA','2024-07-14 15:40:00',21),(44,'ENTRADA','2024-07-20 08:15:00',23),
(45,'SAIDA','2024-07-24 13:25:00',23),(46,'ENTRADA','2024-08-01 09:30:00',24),
(47,'SAIDA','2024-08-05 16:10:00',24),(48,'ENTRADA','2024-08-10 08:45:00',25),
(49,'SAIDA','2024-08-14 14:35:00',25),(50,'ENTRADA','2024-08-20 09:00:00',26),
(51,'SAIDA','2024-08-24 15:20:00',26),(52,'ENTRADA','2024-09-01 08:50:00',27),
(53,'SAIDA','2024-09-05 13:15:00',27),(54,'ENTRADA','2024-09-10 09:25:00',28),
(55,'SAIDA','2024-09-14 16:40:00',28),(56,'ENTRADA','2024-09-20 08:05:00',30),
(57,'SAIDA','2024-09-24 14:45:00',30),(58,'SAIDA','2024-09-28 11:00:00',30),
(59,'ENTRADA','2024-10-01 09:15:00',31),(60,'SAIDA','2024-10-05 15:30:00',31),
(61,'ENTRADA','2024-10-10 08:20:00',32),(62,'SAIDA','2024-10-14 13:40:00',32),
(63,'ENTRADA','2024-10-20 09:00:00',33),(64,'SAIDA','2024-10-24 16:15:00',33),
(65,'ENTRADA','2024-11-01 08:30:00',35),(66,'SAIDA','2024-11-05 14:05:00',35),
(67,'ENTRADA','2024-11-10 09:20:00',36),(68,'SAIDA','2024-11-14 15:50:00',36),
(69,'SAIDA','2024-11-18 11:25:00',36),(70,'ENTRADA','2024-11-22 08:40:00',37),
(71,'SAIDA','2024-11-26 13:55:00',37),(72,'ENTRADA','2024-12-01 09:10:00',38),
(73,'SAIDA','2024-12-05 16:20:00',38),(74,'ENTRADA','2024-12-10 08:15:00',39),
(75,'SAIDA','2024-12-14 14:30:00',39),(76,'ENTRADA','2025-01-05 09:00:00',40),
(77,'SAIDA','2025-01-09 15:45:00',40),(78,'ENTRADA','2025-01-12 08:25:00',41),
(79,'SAIDA','2025-01-16 13:10:00',41),(80,'ENTRADA','2025-01-20 09:35:00',42),
(81,'SAIDA','2025-01-24 16:05:00',42),(82,'ENTRADA','2025-02-01 08:50:00',43),
(83,'SAIDA','2025-02-05 14:25:00',43),(84,'ENTRADA','2025-02-10 09:15:00',44),
(85,'SAIDA','2025-02-14 15:55:00',44),(86,'ENTRADA','2025-02-20 08:40:00',45),
(87,'SAIDA','2025-02-24 13:30:00',45),(88,'ENTRADA','2025-03-01 09:20:00',46),
(89,'SAIDA','2025-03-05 16:10:00',46),(90,'ENTRADA','2025-03-10 08:05:00',47),
(91,'SAIDA','2025-03-14 14:40:00',47),(92,'ENTRADA','2025-03-20 09:25:00',48),
(93,'SAIDA','2025-03-24 15:15:00',48),(94,'ENTRADA','2025-04-01 08:30:00',2),
(95,'SAIDA','2025-04-05 13:45:00',2),(96,'ENTRADA','2025-04-10 09:10:00',7),
(97,'SAIDA','2025-04-14 15:35:00',7),(98,'ENTRADA','2025-05-01 08:55:00',10),
(99,'SAIDA','2025-05-05 14:20:00',10),(100,'ENTRADA','2025-05-10 09:05:00',15);

-- 14. DEMANDA — 40
INSERT INTO demanda (id_demanda, status, data_hora_abertura, placa, id_item) VALUES
(1, 'CONCLUIDA',   '2024-01-08 09:15:00', 'RTA1A23', 1),
(2, 'CONCLUIDA',   '2024-01-15 10:30:00', 'QWE4C56', 2),
(3, 'CONCLUIDA',   '2024-01-22 14:00:00', 'ASD7E89', 3),
(4, 'CONCLUIDA',   '2024-02-03 08:45:00', 'ZXC1G23', 4),
(5, 'CONCLUIDA',   '2024-02-12 11:20:00', 'POI3I45', 6),
(6, 'CONCLUIDA',   '2024-02-20 15:30:00', 'LKJ5K67', 7),
(7, 'CONCLUIDA',   '2024-03-04 09:00:00', 'MNB7M89', 8),
(8, 'CONCLUIDA',   '2024-03-12 13:15:00', 'VBN9O01', 9),
(9, 'CONCLUIDA',   '2024-03-20 10:45:00', 'TGB2R34', 10),
(10,'CONCLUIDA',   '2024-04-02 08:30:00', 'YHN3S45', 11),
(11,'CONCLUIDA',   '2024-04-10 14:20:00', 'UJM5U67', 13),
(12,'CONCLUIDA',   '2024-04-18 09:50:00', 'IKL7W89', 14),
(13,'CONCLUIDA',   '2024-05-03 11:00:00', 'OLP9Y01', 15),
(14,'CONCLUIDA',   '2024-05-11 15:45:00', 'EDC1A23', 16),
(15,'CONCLUIDA',   '2024-05-20 08:20:00', 'RFV3C45', 17),
(16,'CONCLUIDA',   '2024-06-03 10:10:00', 'RTA2B34', 18),
(17,'CONCLUIDA',   '2024-06-12 14:30:00', 'QWE5D67', 19),
(18,'CONCLUIDA',   '2024-06-20 09:15:00', 'ASD8F90', 20),
(19,'CONCLUIDA',   '2024-07-02 11:45:00', 'ZXC2H34', 21),
(20,'CONCLUIDA',   '2024-07-10 13:20:00', 'POI4J56', 23),
(21,'CONCLUIDA',   '2024-07-18 08:55:00', 'LKJ6L78', 24),
(22,'CONCLUIDA',   '2024-08-02 10:25:00', 'MNB8N90', 25),
(23,'CONCLUIDA',   '2024-08-10 14:40:00', 'VBN0P12', 26),
(24,'CONCLUIDA',   '2024-08-18 09:30:00', 'TGB1Q23', 27),
(25,'CONCLUIDA',   '2024-09-03 11:15:00', 'YHN4T56', 28),
(26,'CONCLUIDA',   '2024-09-11 15:00:00', 'UJM6V78', 30),
(27,'CONCLUIDA',   '2024-09-20 08:40:00', 'IKL8X90', 31),
(28,'CONCLUIDA',   '2024-10-02 10:50:00', 'OLP0Z12', 32),
(29,'CONCLUIDA',   '2024-10-10 13:35:00', 'EDC2B34', 33),
(30,'CONCLUIDA',   '2024-10-18 09:05:00', 'RFV4D56', 35),
(31,'CONCLUIDA',   '2024-11-01 11:30:00', 'RTA1A23', 36),
(32,'CONCLUIDA',   '2024-11-10 14:15:00', 'QWE4C56', 37),
(33,'CONCLUIDA',   '2024-11-18 08:50:00', 'ASD7E89', 38),
(34,'CONCLUIDA',   '2024-12-02 10:00:00', 'ZXC1G23', 39),
(35,'CONCLUIDA',   '2024-12-10 13:45:00', 'POI3I45', 40),
(36,'EM_ANDAMENTO','2025-05-13 11:30:00', 'LKJ5K67', 41),
(37,'ABERTA',      '2025-08-01 08:25:00', 'MNB7M89', 2),
(38,'ABERTA',      '2025-09-03 10:35:00', 'TGB2R34', 7),
(39,'CANCELADA',   '2025-09-05 13:20:00', 'VBN9O01', 1),
(40,'ABERTA',      '2025-09-10 14:05:00', 'UJM5U67', 15);

-- 15. FORMA_PAGAMENTO — 6
INSERT INTO forma_pagamento (id_forma, descricao) VALUES
(1,'Dinheiro'),(2,'PIX'),(3,'Cartão de Crédito'),
(4,'Cartão de Débito'),(5,'Boleto Bancário'),(6,'Transferência Bancária');

-- 16. PAGAMENTO — 35
-- Casos de contorno: demandas 36–40 SEM pagamento; demandas 3 e 12 com 2 parcelas
INSERT INTO pagamento (id_pagamento, valor_pagamento, data_pagamento, id_demanda, id_forma) VALUES
(1,380.50,'2024-01-09',1,2),(2,620.00,'2024-01-16',2,3),
(3,250.00,'2024-01-24',3,1),(4,180.00,'2024-01-30',3,2),
(5,445.90,'2024-02-05',4,2),(6,890.00,'2024-02-14',5,3),
(7,320.00,'2024-02-22',6,1),(8,750.40,'2024-03-06',7,4),
(9,1580.00,'2024-03-14',8,3),(10,275.50,'2024-03-22',9,2),
(11,540.00,'2024-04-04',10,5),(12,195.00,'2024-04-12',11,1),
(13,410.80,'2024-04-20',12,2),(14,220.00,'2024-04-27',12,2),
(15,670.00,'2024-05-05',13,3),(16,290.50,'2024-05-13',14,4),
(17,1150.00,'2024-05-22',15,2),(18,385.00,'2024-06-05',16,1),
(19,520.00,'2024-06-14',17,3),(20,1980.00,'2024-06-22',18,2),
(21,340.00,'2024-07-04',19,5),(22,460.50,'2024-07-12',20,2),
(23,225.00,'2024-07-20',21,1),(24,780.00,'2024-08-04',22,3),
(25,315.90,'2024-08-12',23,4),(26,605.00,'2024-08-20',24,2),
(27,890.50,'2024-09-05',25,3),(28,130.00,'2024-09-13',26,1),
(29,425.00,'2024-09-22',27,2),(30,265.00,'2024-10-04',28,4),
(31,545.00,'2024-10-12',29,3),(32,320.50,'2024-10-20',30,2),
(33,690.00,'2024-11-03',31,5),(34,245.00,'2024-11-12',32,1),
(35,410.00,'2024-11-20',33,2);

-- 17. EXECUTA — 50 (N:N demanda × gerente)
INSERT INTO executa (id_demanda, id_funcionario, data_execucao) VALUES
(1,1,'2024-01-08 09:30:00'),(1,2,'2024-01-08 10:00:00'),
(2,2,'2024-01-15 11:00:00'),(2,3,'2024-01-15 11:30:00'),
(3,3,'2024-01-22 14:30:00'),(4,1,'2024-02-03 09:00:00'),
(4,4,'2024-02-03 09:45:00'),(5,4,'2024-02-12 12:00:00'),
(6,5,'2024-02-20 16:00:00'),(6,1,'2024-02-20 16:30:00'),
(7,2,'2024-03-04 09:30:00'),(8,3,'2024-03-12 13:45:00'),
(8,5,'2024-03-12 14:15:00'),(9,1,'2024-03-20 11:15:00'),
(10,4,'2024-04-02 09:00:00'),(11,2,'2024-04-10 14:50:00'),
(11,5,'2024-04-10 15:20:00'),(12,3,'2024-04-18 10:20:00'),
(13,1,'2024-05-03 11:30:00'),(14,4,'2024-05-11 16:15:00'),
(15,5,'2024-05-20 08:50:00'),(15,2,'2024-05-20 09:20:00'),
(16,1,'2024-06-03 10:40:00'),(17,3,'2024-06-12 15:00:00'),
(18,2,'2024-06-20 09:45:00'),(19,4,'2024-07-02 12:15:00'),
(20,5,'2024-07-10 13:50:00'),(21,1,'2024-07-18 09:25:00'),
(22,3,'2024-08-02 10:55:00'),(23,2,'2024-08-10 15:10:00'),
(24,4,'2024-08-18 10:00:00'),(25,5,'2024-09-03 11:45:00'),
(26,1,'2024-09-11 15:30:00'),(27,3,'2024-09-20 09:10:00'),
(28,2,'2024-10-02 11:20:00'),(29,4,'2024-10-10 14:05:00'),
(30,5,'2024-10-18 09:35:00'),(31,1,'2024-11-01 12:00:00'),
(32,3,'2024-11-10 14:45:00'),(33,2,'2024-11-18 09:20:00'),
(34,4,'2024-12-02 10:30:00'),(35,5,'2024-12-10 14:15:00'),
(36,1,'2025-05-13 12:00:00'),(37,2,'2025-08-01 08:55:00'),
(38,3,'2025-09-03 11:05:00'),(39,4,'2025-09-05 13:50:00'),
(40,5,'2025-09-10 14:35:00'),(1,3,'2024-01-08 11:00:00'),
(2,4,'2024-01-15 12:00:00'),(3,5,'2024-01-22 15:00:00'),
(5,1,'2024-02-12 12:30:00'),(10,2,'2024-04-02 09:30:00');

-- 18. SUPERVISIONA — 40 (N:N gerente × funcionário)
DELETE FROM supervisiona;

INSERT INTO supervisiona (id_gerente, id_funcionario, data_inicio) VALUES
(1,6,'2019-03-01'),(1,7,'2019-07-01'),(1,8,'2020-10-01'),
(1,9,'2021-01-01'),(1,10,'2021-04-01'),
(2,11,'2021-08-01'),(2,12,'2021-11-01'),(2,13,'2022-02-01'),
(2,14,'2022-05-01'),(2,15,'2022-09-01'),
(3,16,'2022-12-01'),(3,17,'2023-03-01'),(3,18,'2023-06-01'),
(3,19,'2023-10-01'),(3,20,'2024-01-01'),
(4,21,'2024-03-01'),(4,22,'2024-07-01'),(4,23,'2024-10-01'),
(4,24,'2025-02-01'),(4,25,'2025-05-01'),
(1,26,'2020-05-01'),(1,27,'2020-09-01'),
(2,28,'2021-03-01'),(2,29,'2021-07-01'),
(3,30,'2022-04-01'),
(1,31,'2018-06-01'),(2,32,'2019-12-01'),(3,33,'2021-09-01'),
(1,34,'2020-08-01'),(2,35,'2021-02-01'),
(1,2,'2020-01-01'),(1,3,'2020-01-01'),
(2,4,'2021-06-01'),(2,5,'2021-06-01'),
(3,1,'2019-08-01'),(4,2,'2022-09-01'),
(5,3,'2023-02-01'),(1,4,'2024-01-01'),
(4,5,'2024-06-01'),(3,2,'2024-11-01');

-- 19. REGISTRA — 100 (N:N movimentacao × item)
INSERT INTO registra (id_mov, id_item, quantidade) VALUES
(1,1,20),(2,1,3),(3,1,2),(4,1,15),(5,2,25),(6,2,4),(7,2,3),
(8,3,10),(9,3,2),(10,4,8),(11,4,2),(12,6,6),(13,6,1),(14,7,5),
(15,7,1),(16,8,12),(17,8,3),(18,8,2),(19,9,8),(20,9,2),(21,10,15),
(22,10,3),(23,11,6),(24,11,2),(25,13,4),(26,13,1),(27,14,5),
(28,14,1),(29,15,25),(30,15,4),(31,15,3),(32,16,20),(33,16,3),
(34,17,15),(35,17,2),(36,18,10),(37,18,2),(38,19,8),(39,19,1),
(40,20,12),(41,20,2),(42,21,5),(43,21,1),(44,23,10),(45,23,2),
(46,24,8),(47,24,1),(48,25,5),(49,25,1),(50,26,6),(51,26,1),
(52,27,4),(53,27,1),(54,28,3),(55,28,1),(56,30,30),(57,30,5),
(58,30,3),(59,31,25),(60,31,4),(61,32,20),(62,32,3),(63,33,15),
(64,33,2),(65,35,12),(66,35,2),(67,36,40),(68,36,6),(69,36,4),
(70,37,35),(71,37,5),(72,38,30),(73,38,4),(74,39,25),(75,39,3),
(76,40,20),(77,40,3),(78,41,1),(79,41,1),(80,42,1),(81,42,1),
(82,43,1),(83,43,1),(84,44,1),(85,44,1),(86,45,1),(87,45,1),
(88,46,1),(89,46,1),(90,47,1),(91,47,1),(92,48,1),(93,48,1),
(94,2,10),(95,2,2),(96,7,4),(97,7,1),(98,10,8),(99,10,2),(100,15,15);

-- =============================================================================
-- CONFERÊNCIA
-- =============================================================================
SELECT 'cliente' AS tabela, COUNT(*) AS registros FROM cliente
UNION ALL SELECT 'veiculo',              COUNT(*) FROM veiculo
UNION ALL SELECT 'funcionario',          COUNT(*) FROM funcionario
UNION ALL SELECT 'gerente',              COUNT(*) FROM gerente
UNION ALL SELECT 'mecanico',             COUNT(*) FROM mecanico
UNION ALL SELECT 'atendente',            COUNT(*) FROM atendente
UNION ALL SELECT 'administrador',        COUNT(*) FROM administrador
UNION ALL SELECT 'repositor',            COUNT(*) FROM repositor
UNION ALL SELECT 'categoria',            COUNT(*) FROM categoria
UNION ALL SELECT 'item_estoque',         COUNT(*) FROM item_estoque
UNION ALL SELECT 'peca',                 COUNT(*) FROM peca
UNION ALL SELECT 'equipamento',          COUNT(*) FROM equipamento
UNION ALL SELECT 'movimentacao_estoque', COUNT(*) FROM movimentacao_estoque
UNION ALL SELECT 'demanda',              COUNT(*) FROM demanda
UNION ALL SELECT 'forma_pagamento',      COUNT(*) FROM forma_pagamento
UNION ALL SELECT 'pagamento',            COUNT(*) FROM pagamento
UNION ALL SELECT 'executa',              COUNT(*) FROM executa
UNION ALL SELECT 'supervisiona',         COUNT(*) FROM supervisiona
UNION ALL SELECT 'registra',             COUNT(*) FROM registra;