CREATE DATABASE IF NOT EXISTS ServicosPrestados;
USE ServicosPrestados;

-- Criação das Tabelas
CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco VARCHAR(255),
    Telefone VARCHAR(20)
);

CREATE TABLE Funcionarios (
    FuncionarioID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Cargo VARCHAR(100),
    Salario DECIMAL(10, 2)
);

CREATE TABLE Servicos (
    ServicoID INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(255),
    Preco DECIMAL(10, 2)
);

CREATE TABLE OrdensDeServico (
    OrdemID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    ServicoID INT,
    Data DATE,
    Status VARCHAR(50),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (ServicoID) REFERENCES Servicos(ServicoID)
);

CREATE TABLE Fornecedores (
    FornecedorID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco VARCHAR(255),
    ProdutoFornecido VARCHAR(255)
);

CREATE TABLE Produtos (
    ProdutoID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Preco DECIMAL(10, 2),
    FornecedorID INT,
    FOREIGN KEY (FornecedorID) REFERENCES Fornecedores(FornecedorID)
);

CREATE TABLE OrdensDeCompra (
    OrdemCompraID INT AUTO_INCREMENT PRIMARY KEY,
    ProdutoID INT,
    Quantidade INT,
    Data DATE,
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

CREATE TABLE Agendamentos (
    AgendamentoID INT AUTO_INCREMENT PRIMARY KEY,
    OrdemID INT,
    FuncionarioID INT,
    DataAgendamento DATE,
    FOREIGN KEY (OrdemID) REFERENCES OrdensDeServico(OrdemID),
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionarios(FuncionarioID)
);


-- Inserção na tabela Clientes
INSERT INTO Clientes (Nome, Endereco, Telefone) VALUES
('João Silva', 'Rua das Flores, 123', '11 98765-4321'),
('Maria Oliveira', 'Avenida Central, 456', '21 98765-4321'),
('Carlos Souza', 'Rua do Lago, 789', '31 98765-4321'),
('Ana Costa', 'Alameda dos Anjos, 101', '41 98765-4321'),
('Pedro Amaral', 'Travessa da Praia, 202', '51 98765-4321');

-- Inserção na tabela Funcionarios
INSERT INTO Funcionarios (Nome, Cargo, Salario) VALUES
('José Ramos', 'Eletricista', 2500.00),
('Luciana Martins', 'Jardineira', 2200.00),
('Ricardo Nunes', 'Encanador', 2300.00),
('Márcia Lima', 'Limpeza', 2100.00),
('Eduardo Rocha', 'Pintor', 2400.00);

-- Inserção na tabela Servicos
INSERT INTO Servicos (Descricao, Preco) VALUES
('Instalação elétrica', 200.00),
('Manutenção de jardim', 150.00),
('Reparo hidráulico', 180.00),
('Serviço de limpeza', 130.00),
('Pintura residencial', 250.00);

-- Inserção na tabela OrdensDeServico
INSERT INTO OrdensDeServico (ClienteID, ServicoID, Data, Status) VALUES
(1, 1, '2023-10-01', 'Concluído'),
(2, 2, '2023-10-05', 'Em andamento'),
(3, 3, '2023-10-10', 'Concluído'),
(4, 4, '2023-10-15', 'Cancelado'),
(5, 5, '2023-10-20', 'Concluído');

-- Inserção na tabela Fornecedores
INSERT INTO Fornecedores (Nome, Endereco, ProdutoFornecido) VALUES
('Fornecimentos XYZ', 'Rua Industrial, 100', 'Materiais elétricos'),
('Jardim & Cia', 'Avenida das Flores, 200', 'Insumos para jardinagem'),
('Hidráulica Central', 'Alameda dos Encanadores, 300', 'Peças hidráulicas'),
('Limpeza Total', 'Travessa dos Limpeza, 400', 'Produtos de limpeza'),
('Pinturas Qualitá', 'Rua das Artes, 500', 'Tintas e pincéis');

-- Inserção na tabela Produtos
INSERT INTO Produtos (Nome, Preco, FornecedorID) VALUES
('Cabo elétrico', 50.00, 1),
('Adubo', 20.00, 2),
('Torneira', 30.00, 3),
('Detergente', 10.00, 4),
('Tinta látex', 60.00, 5);

-- Inserção na tabela OrdensDeCompra
INSERT INTO OrdensDeCompra (ProdutoID, Quantidade, Data) VALUES
(1, 100, '2023-09-25'),
(2, 50, '2023-09-26'),
(3, 30, '2023-09-27'),
(4, 200, '2023-09-28'),
(5, 40, '2023-09-29');

-- Inserção na tabela Agendamentos
INSERT INTO Agendamentos (OrdemID, FuncionarioID, DataAgendamento) VALUES
(1, 1, '2023-10-02'),
(2, 2, '2023-10-06'),
(3, 3, '2023-10-11'),
(4, 4, '2023-10-16'),
(5, 5, '2023-10-21');
 --                            Exercício

-- 1. Crie uma view chamada `VwDetalhesServicos` para mostrar os detalhes completos de cada serviço prestado, incluindo o nome do cliente, descrição do serviço, data e status.
CREATE VIEW VwDetalhesServicos AS
SELECT c.Nome AS Cliente, s.Descricao AS Servico, os.Data, os.Status
FROM Clientes c
JOIN OrdensDeServico os ON c.ClienteID = os.ClienteID
JOIN Servicos s ON os.ServicoID = s.ServicoID;
SELECT *FROM VwDetalhesServicos;

-- 2. Desenvolva uma view `VwSalariosFuncionarios` para listar os funcionários e seus respectivos salários, ordenados do maior para o menor.
CREATE VIEW VwSalariosFuncionarios AS
SELECT Nome, Salario
FROM Funcionarios
ORDER BY Salario DESC;
SELECT *FROM VwSalariosFuncionarios;
-- 3. Crie uma view `VwProdutosFornecedores` que exiba todos os produtos, seus preços e o nome do fornecedor correspondente.
CREATE VIEW VwProdutosFornecedores AS
SELECT p.Nome AS Produto, p.Preco, f.Nome AS Fornecedor
FROM Produtos p
JOIN Fornecedores f ON p.FornecedorID = f.FornecedorID;

SELECT *FROM VwProdutosFornecedores;
-- 4. Desenvolva uma view `VwOrdensRecentes` para listar as ordens de serviço dos últimos 30 dias, incluindo cliente, serviço e data.
CREATE VIEW VwOrdensRecentes AS
SELECT c.Nome AS Cliente, s.Descricao AS Servico, os.Data
FROM Clientes c
JOIN OrdensDeServico os ON c.ClienteID = os.ClienteID
JOIN Servicos s ON os.ServicoID = s.ServicoID
WHERE os.Data >= DATE_SUB(NOW(), INTERVAL 30 DAY);

SELECT *FROM VwOrdensRecentes;
-- 5. Crie uma view `VwDespesasComProdutos` que mostre a soma total de despesas com produtos, agrupadas por fornecedor.
CREATE VIEW VwDespesasComProdutos AS
SELECT f.Nome AS Fornecedor, SUM(p.Preco * oc.Quantidade) AS DespesasTotais
FROM Produtos p
JOIN Fornecedores f ON p.FornecedorID = f.FornecedorID
JOIN OrdensDeCompra oc ON p.ProdutoID = oc.ProdutoID
GROUP BY f.Nome;

SELECT *FROM VwDespesasComProdutos;
-- 6. Desenvolva uma view `VwAgendamentosPorFuncionario` que liste todos os agendamentos futuros, incluindo o nome do funcionário, o serviço a ser prestado e a data do agendamento.
CREATE VIEW VwAgendamentosPorFuncionario AS
SELECT f.Nome AS Funcionario, s.Descricao AS Servico, a.DataAgendamento
FROM Agendamentos a
JOIN Funcionarios f ON a.FuncionarioID = f.FuncionarioID
JOIN OrdensDeServico os ON a.OrdemID = os.OrdemID
JOIN Servicos s ON os.ServicoID = s.ServicoID
WHERE a.DataAgendamento > CURDATE();

SELECT *FROM VwAgendamentosPorFuncionario;
-- 7. Crie uma view `VwClientesFrequentes` que liste os clientes que fizeram mais de 5 ordens de serviço.
CREATE VIEW VwClientesFrequentes AS
SELECT c.Nome AS Cliente, COUNT(*) AS NumOrdens
FROM Clientes c
JOIN OrdensDeServico os ON c.ClienteID = os.ClienteID
GROUP BY c.ClienteID
HAVING NumOrdens > 5;

SELECT *FROM VwClientesFrequentes;
-- 8. Desenvolva uma view `VwMediaPrecoServico` que mostre a média de preço dos serviços oferecidos.
CREATE VIEW VwMediaPrecoServico AS
SELECT AVG(Preco) AS MediaPreco
FROM Servicos;

SELECT *FROM VwMediaPrecoServico;
-- 9. Crie uma view `VwDetalhesCompras` para mostrar os detalhes das ordens de compra, incluindo nome do produto, quantidade, data e nome do fornecedor.
CREATE VIEW VwDetalhesCompras AS
SELECT p.Nome AS Produto, oc.Quantidade, oc.Data, f.Nome AS Fornecedor
FROM Produtos p
JOIN OrdensDeCompra oc ON p.ProdutoID = oc.ProdutoID
JOIN Fornecedores f ON p.FornecedorID = f.FornecedorID;

SELECT *FROM VwDetalhesCompras;
-- 10. Desenvolva uma view `VwFuncionariosPorCargo` que liste o número de funcionários por cargo.
CREATE VIEW VwFuncionariosPorCargo AS
SELECT Cargo, COUNT(*) AS NumFuncionarios
FROM Funcionarios
GROUP BY Cargo;

SELECT *FROM VwFuncionariosPorCargo;