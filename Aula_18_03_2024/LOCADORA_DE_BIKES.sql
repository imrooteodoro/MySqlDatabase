
-- Adelson Teodoro Nunes
--  18/03/2024
CREATE DATABASE LocacaoBicicletas;

USE LocacaoBicicletas;

-- Tabela de Clientes
CREATE TABLE Clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(11) UNIQUE,
    email VARCHAR(100),
    telefone VARCHAR(20)    
);

-- Tabela de Cidades
CREATE TABLE Cidades (
    idCidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    estado VARCHAR(50)   
);

-- Tabela de Tipos de Bicicleta
CREATE TABLE TiposBicicleta (
    idTipo INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255)    
);

-- Tabela de Bicicletas
CREATE TABLE Bicicletas (
    idBicicleta INT AUTO_INCREMENT PRIMARY KEY,
    idTipo INT,
    idCidade INT,
    status VARCHAR(50),
    FOREIGN KEY (idTipo) REFERENCES TiposBicicleta(idTipo),
    FOREIGN KEY (idCidade) REFERENCES Cidades(idCidade)   
);

-- Tabela de Valores
CREATE TABLE Valores (
    idValor INT AUTO_INCREMENT PRIMARY KEY,
    idTipo INT,
    valorHora DECIMAL(10, 2),
    FOREIGN KEY (idTipo) REFERENCES TiposBicicleta(idTipo)    
);

-- Tabela de Locações
CREATE TABLE Locacoes (
    idLocacao INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    idBicicleta INT,
    dataInicio DATETIME,
    dataFim DATETIME,
    valorTotal DECIMAL(10, 2),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idBicicleta) REFERENCES Bicicletas(idBicicleta)   
);

-- Tabela de Bônus
CREATE TABLE Bonus (
    idBonus INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    pontos INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)   
);

-- Tabela de Lucros
CREATE TABLE Lucros (
    idLucro INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    valor DECIMAL(10, 2)
   );

-- Inserção na tabela Clientes
INSERT INTO Clientes (nome, cpf, email, telefone) VALUES
('Ana Beatriz', '23456789012', 'ana.beatriz@email.com', '31987654321'),
('Carlos Eduardo', '34567890123', 'carlos.eduardo@email.com', '41987654321'),
('Daniela Rocha', '45678901234', 'daniela.rocha@email.com', '51987654321'),
('Eduardo Lima', '56789012345', 'eduardo.lima@email.com', '61987654321'),
('Fernanda Costa', '67890123456', 'fernanda.costa@email.com', '71987654321'),
('Gustavo Henrique', '78901234567', 'gustavo.henrique@email.com', '81987654321'),
('Helena Souza', '89012345678', 'helena.souza@email.com', '91987654321'),
('Ícaro Santos', '90123456789', 'icaro.santos@email.com', '101987654321');

INSERT INTO Cidades (nome, estado) VALUES
('Belo Horizonte', 'MG'),
('Porto Alegre', 'RS'),
('Salvador', 'BA'),
('Fortaleza', 'CE'),
('Brasília', 'DF'),
('Curitiba', 'PR'),
('Manaus', 'AM'),
('Recife', 'PE');
-- Inserção na tabela TiposBicicleta
INSERT INTO TiposBicicleta (descricao) VALUES
('Urbana'),
('Speed'),
('Mountain'),
('Elétrica'),
('Dobrável'),
('BMX'),
('Fixa'),
('Híbrida');

-- Inserção na tabela Bicicletas
INSERT INTO Bicicletas (idTipo, idCidade, status) VALUES
(1, 1, 'Disponível'),
(2, 2, 'Disponível'),
(3, 3, 'Disponível'),
(4, 4, 'Disponível'),
(5, 5, 'Disponível'),
(6, 6, 'Disponível'),
(7, 7, 'Disponível'),
(8, 8, 'Disponível');

-- Inserção na tabela Valores
INSERT INTO Valores (idTipo, valorHora) VALUES
(1, 5.00),
(2, 7.50),
(3, 8.00),
(4, 10.00),
(5, 6.50),
(6, 5.50),
(7, 4.50),
(8, 9.00);

INSERT INTO Locacoes (idCliente, idBicicleta, dataInicio, dataFim, valorTotal) VALUES
(3, 3, '2023-03-03 08:00:00', '2023-03-03 10:00:00', 16.00),
(4, 4, '2023-03-04 14:00:00', '2023-03-04 15:00:00', 10.00),
(5, 5, '2023-03-05 09:00:00', '2023-03-05 09:30:00', 3.25),
(6, 6, '2023-03-06 12:00:00', '2023-03-06 14:00:00', 11.00),
(7, 7, '2023-03-07 16:00:00', '2023-03-07 17:30:00', 6.75),
(8, 8, '2023-03-08 18:00:00', '2023-03-08 19:00:00', 9.00),
(2, 1, '2023-03-09 20:00:00', '2023-03-09 22:00:00', 10.00),
(1, 2, '2023-03-10 13:00:00', '2023-03-10 14:00:00', 7.50);

INSERT INTO Bonus (idCliente, pontos) VALUES
(3, 150),
(4, 250),
(5, 350),
(6, 50),
(7, 75),
(8, 125),
(2, 175),
(1, 225);

INSERT INTO Lucros (data, valor) VALUES
('2023-03-03', 600.00),
('2023-03-04', 850.00),
('2023-03-05', 900.00),
('2023-03-06', 950.00),
('2023-03-07', 1000.00),
('2023-03-08', 1050.00),
('2023-03-09', 1100.00),
('2023-03-10', 1150.00);


select *from Clientes;
select *from Cidades;
select *from TiposBicicleta;
select *from Bicicletas;
select *from Valores;
select *from Locacoes;
select *from Bonus;
select *from Lucros;

select *from Lucros;

--				 Questões para Prática de Criação de Views

-- 1.  Crie uma view que liste todos os clientes que realizaram pelo menos uma locação.

CREATE VIEW ClientesComLocacoes as 
SeLECT c.idCliente, c.nome, c.cpf, c.email, c.telefone
FROM Clientes  c
Join Locacoes l on c.idCliente = l.idCliente 
GROUP BY c.idCLiente;

SELECT *from ClientesComLocacoes;

-- 2.  Desenvolva uma view que mostre a quantidade de bicicletas disponíveis em cada cidade.
create view BicicletasPorCidade as
select ci.idCidade, ci.nome as cidade, count(b.idBicicleta) as qtd_bicicletas_disponiveis 
from Cidades  ci
left join Bicicletas b on ci.idCidade = b.idCidade and b.status = 'Disponível'
GROUP BY ci.idCidade;

select *from BicicletasPorCidade;
-- 3.  Elabore uma view que calcule a média de duração (em horas) das locações para cada tipo de bicicleta.
CREATE VIEW MediaDuracaoLocacoes AS
SELECT tb.idTipo, tb.descricao AS tipo_bicicleta, AVG(TIMESTAMPDIFF(HOUR, l.dataInicio, l.dataFim)) AS media_duracao_horas
FROM TiposBicicleta tb
JOIN Bicicletas b ON tb.idTipo = b.idTipo
JOIN Locacoes l ON b.idBicicleta = l.idBicicleta
GROUP BY tb.idTipo;
SELECT *FROM MediaDuracaoLocacoes;
-- 4.  Crie uma view que mostre o número total de locações realizadas em cada mês do ano.
CREATE VIEW LocacoesPorMes AS
SELECT MONTH(dataInicio) AS mes, COUNT(*) AS total_locacoes
FROM Locacoes
GROUP BY mes;
SELECT *FROM  MediaDuracaoLocacoes;

-- 5.  Desenvolva uma view que liste os cinco clientes que mais realizaram locações, baseando-se no valor total gasto.

CREATE VIEW TopClientesLocacoes AS
SELECT c.idCliente, c.nome, SUM(l.valorTotal) AS total_gasto
FROM Clientes c
JOIN Locacoes l ON c.idCliente = l.idCliente
GROUP BY c.idCliente
ORDER BY total_gasto DESC
LIMIT 5;
SELECT *FROM TopClientesLocacoes;
-- 6.  Elabore uma view que apresente o valor médio das locações por cidade.
CREATE VIEW ValorMedioLocacoesPorCidade AS
SELECT ci.idCidade, ci.nome AS cidade, AVG(l.valorTotal) AS valor_medio
FROM Cidades ci
JOIN Bicicletas b ON ci.idCidade = b.idCidade
JOIN Locacoes l ON b.idBicicleta = l.idBicicleta
GROUP BY ci.idCidade;

SELECT *FROM ValorMedioLocacoesPorCidade;

-- 7.  Crie uma view que liste todas as locações que começaram e terminaram no mesmo dia.

CREATE VIEW LocacoesMesmoDia AS
SELECT *
FROM Locacoes
WHERE DATE(dataInicio) = DATE(dataFim);

SELECT *FROM LocacoesMesmoDia;

-- 8.  Desenvolva uma view que mostre cada cliente e sua respectiva pontuação de bônus acumulada.

CREATE VIEW PontuacaoClientes AS
SELECT idCliente, SUM(pontos) AS total_pontos
FROM Bonus
GROUP BY idCliente;
CREATE VIEW PontuacaoClientes AS
SELECT idCliente, SUM(pontos) AS total_pontos
FROM Bonus
GROUP BY idCliente;
SELECT  *FROM PontuacaoClientes;

-- 9.  Elabore uma view que apresente o lucro total obtido com as locações para cada mês.

CREATE VIEW LucroTotalPorMes AS
SELECT MONTH(data) AS mes, SUM(valor) AS lucro_total
FROM Lucros
GROUP BY mes;

SELECT *FROM LucroTotalPorMes;
-- 10.  Crie uma view que mostre os tipos de bicicleta mais populares, baseando-se no número de vezes que foram alugadas.

CREATE VIEW TiposBicicletaPopulares AS
SELECT tb.idTipo, tb.descricao AS tipo_bicicleta, COUNT(*) AS total_locacoes
FROM TiposBicicleta tb
JOIN Bicicletas b ON tb.idTipo = b.idTipo
JOIN Locacoes l ON b.idBicicleta = l.idBicicleta
GROUP BY tb.idTipo
ORDER BY total_locacoes DESC;

SELECT *FROM TiposBicicletaPopulares;

-- 11.  Desenvolva uma view que analise os horários do dia com maior número de locações iniciadas.

CREATE VIEW HorarioMaisLocacoes AS
SELECT HOUR(dataInicio) AS hora, COUNT(*) AS total_locacoes
FROM Locacoes
GROUP BY hora
ORDER BY total_locacoes DESC
LIMIT 1;

SELECT *FROM HorarioMaisLocacoes;
-- 12.  Elabore uma view que identifique clientes que ainda não realizaram nenhuma locação.


CREATE VIEW ClientesSemLocacoes AS
SELECT c.idCliente, c.nome
FROM Clientes c
LEFT JOIN Locacoes l ON c.idCliente = l.idCliente
WHERE l.idLocacao IS NULL;

SELECT *FROM ClientesSemLocacoes;
-- 13. Crie uma view que mostre o lucro total gerado por cada tipo de bicicleta.

CREATE VIEW LucroPorTipoBicicleta AS
SELECT tb.idTipo, tb.descricao AS tipo_bicicleta, SUM(valorTotal) AS lucro_total
FROM Bicicletas b
JOIN Locacoes l ON b.idBicicleta = l.idBicicleta
JOIN TiposBicicleta tb ON b.idTipo = tb.idTipo
GROUP BY tb.idTipo;

SELECT *from LucroPorTipoBicicleta;


-- 14. Desenvolva uma view que apresente a locação com a maior duração para cada tipo de bicicleta.

CREATE VIEW LocacaoMaiorDuracaoPorTipo AS
SELECT l.idLocacao, l.idCliente, l.idBicicleta, l.dataInicio, l.dataFim, l.valorTotal, tb.descricao AS tipo_bicicleta
FROM Locacoes l
JOIN Bicicletas b ON l.idBicicleta = b.idBicicleta
JOIN TiposBicicleta tb ON b.idTipo = tb.idTipo
WHERE (l.idLocacao, TIMESTAMPDIFF(HOUR, l.dataInicio, l.dataFim)) IN (
    SELECT idLocacao, MAX(TIMESTAMPDIFF(HOUR, dataInicio, dataFim))
    FROM Locacoes
    GROUP BY idBicicleta
);

SELECT *FROM LocacaoMaiorDuracaoPorTipo;
-- 15. Elabore uma view que compare o número total de locações realizadas, agrupadas por estado.

CREATE VIEW LocacoesPorEstado AS
SELECT ci.estado, COUNT(*) AS total_locacoes
FROM Locacoes l
JOIN Bicicletas b ON l.idBicicleta = b.idBicicleta
JOIN Cidades ci ON b.idCidade = ci.idCidade
GROUP BY ci.estado;

SELECT *FROM LocacoesPorEstado;


