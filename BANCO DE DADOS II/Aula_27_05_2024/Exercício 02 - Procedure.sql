-- MySQL Workbench Synchronization
-- Generated: 2021-05-31 16:27
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Gilvan

CREATE database BB_proceduras02;

USE BB_proceduras02;

-- Criação das tabelas

CREATE TABLE Categoria (
  CodigoCategoria INT(11) NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NULL DEFAULT NULL,
  Desconto VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (CodigoCategoria));


CREATE TABLE Produto(
  CodigoProduto INT(11) NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NULL DEFAULT NULL,
  Preco VARCHAR(45) NULL DEFAULT NULL,
  CodigoCategoria INT(11) NOT NULL,
  PRIMARY KEY (CodigoProduto),
  CONSTRAINT fk_Produto_Categoria    FOREIGN KEY (CodigoCategoria)
  REFERENCES Categoria (CodigoCategoria));
   
CREATE TABLE Cliente (
  CodigoCliente INT(11) NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NULL DEFAULT NULL,
  CPF VARCHAR(45) NULL DEFAULT NULL,
  Idade INT(11) NULL DEFAULT NULL,
  Cidade VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (CodigoCliente));


CREATE TABLE Pedido (
  CodigoPedido INT(11) NOT NULL AUTO_INCREMENT,
  CodigoProduto INT(11) NOT NULL,
  CodigoCliente INT(11) NOT NULL,
  PRIMARY KEY (CodigoPedido),
  
  CONSTRAINT fk_Pedido_Produto1 FOREIGN KEY (CodigoProduto)  REFERENCES Produto (CodigoProduto),
  CONSTRAINT fk_Pedido_Cliente1 FOREIGN KEY (CodigoCliente)  REFERENCES Cliente (CodigoCliente));
    

-- Inserção de registros

INSERT INTO `BB_proceduras02`.`Categoria` (`Nome`, `Desconto`) VALUES
('Eletronicos', '10%'),
('Moveis', '5%'),
('Vestuário', '20%'),
('Alimentos', '15%'),
('Brinquedos', '25%'),
('Ferramentas', '8%');

INSERT INTO `BB_proceduras02`.`Produto` (`Nome`, `Preco`, `CodigoCategoria`) VALUES
('Televisão', '2000', 1),
('Sofá', '500', 2),
('Camisa', '100', 3),
('Arroz', '20', 4),
('Carrinho de Brinquedo', '50', 5),
('Martelo', '30', 6);

INSERT INTO `BB_proceduras02`.`Cliente` (`Nome`, `CPF`, `Idade`, `Cidade`) VALUES
('João Silva', '111.111.111-11', 30, 'São Jeronimo'),
('Maria Santos', '222.222.222-22', 25, 'Porto Alegre'),
('Carlos Oliveira', '333.333.333-33', 40, 'São Jeronimo'),
('Ana Costa', '444.444.444-44', 35, 'Rio de Janeiro'),
('Paula Souza', '555.555.555-55', 28, 'São Paulo'),
('Pedro Gomes', '666.666.666-66', 32, 'São Jeronimo');

INSERT INTO `BB_proceduras02`.`Pedido` (`CodigoProduto`, `CodigoCliente`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

-- Exercício de Procedures

-- 1. Procedure para adicionar uma categoria

CREATE PROCEDURE AddCategoria(
    IN nome VARCHAR(45),
    IN desconto VARCHAR(45)
)
BEGIN
    INSERT INTO Categoria (Nome, Desconto) VALUES (nome, desconto);
END;


-- 2. Procedure para adicionar um produto
CREATE PROCEDURE AddProduto(
    IN nome VARCHAR(45),
    IN preco VARCHAR(45),
    IN codigoCategoria INT
)
BEGIN
    INSERT INTO Produto (Nome, Preco, CodigoCategoria) VALUES (nome, preco, codigoCategoria);
END;

-- 3. Procedure para adicionar um cliente se for de São Jeronimo
CREATE PROCEDURE AddCliente(
    IN nome VARCHAR(45),
    IN cpf VARCHAR(45),
    IN idade INT,
    IN cidade VARCHAR(45)
)
BEGIN
    IF cidade = 'São Jeronimo' THEN
        INSERT INTO Cliente (Nome, CPF, Idade, Cidade) VALUES (nome, cpf, idade, cidade);
    END IF;
END;
-- 4. Procedure para adicionar 15% de desconto em produtos da categoria Eletronicos
CREATE PROCEDURE AddDescontoEletronicos()
BEGIN
    UPDATE Produto
    SET Preco = Preco * 0.85
    WHERE CodigoCategoria = (SELECT CodigoCategoria FROM Categoria WHERE Nome = 'Eletronicos');
END;

-- 5. Procedure para verificar valor do produto de um pedido
CREATE PROCEDURE VerificaValorPedido(
    IN codigoPedido INT,
    OUT valorProduto DECIMAL(10,2)
)
BEGIN
    SELECT Preco INTO valorProduto
    FROM Produto
    WHERE CodigoProduto = (SELECT CodigoProduto FROM Pedido WHERE CodigoPedido = codigoPedido);
END;

-- 6. Procedure para listar produtos de pedidos de clientes de uma cidade
CREATE PROCEDURE ListaProdutosPorCidade(
    IN cidade VARCHAR(45)
)
BEGIN
    SELECT p.Nome
    FROM Produto p
    JOIN Pedido pe ON p.CodigoProduto = pe.CodigoProduto
    JOIN Cliente c ON pe.CodigoCliente = c.CodigoCliente
    WHERE c.Cidade = cidade;
END;


-- 7. Procedure para retornar a média dos valores dos produtos de uma categoria
CREATE PROCEDURE MediaPrecoPorCategoria(
    IN nomeCategoria VARCHAR(45),
    OUT media DECIMAL(10,2)
)
BEGIN
    SELECT AVG(Preco) INTO media
    FROM Produto
    WHERE CodigoCategoria = (SELECT CodigoCategoria FROM Categoria WHERE Nome = nomeCategoria);
END;


-- 8. Procedure para atualizar o nome de um cliente com base no seu código
CREATE PROCEDURE AtualizaNomeCliente(
    IN codigoCliente INT,
    IN novoNome VARCHAR(45)
)
BEGIN
    UPDATE Cliente
    SET Nome = novoNome
    WHERE CodigoCliente = codigoCliente;
END;


-- 9. Procedure para excluir um pedido com base no seu código
CREATE PROCEDURE ExcluiPedido(
    IN codigoPedido INT
)
BEGIN
    DELETE FROM Pedido
    WHERE CodigoPedido = codigoPedido;
END;


-- 10. Procedure para listar todos os clientes e seus respectivos pedidos
CREATE PROCEDURE ListaClientesEPedidos()
BEGIN
    SELECT c.Nome AS NomeCliente, p.Nome AS NomeProduto
    FROM Cliente c
    JOIN Pedido pe ON c.CodigoCliente = pe.CodigoCliente
    JOIN Produto p ON pe.CodigoProduto = p.CodigoProduto;
END;


-- 11. Procedure para adicionar um novo pedido
CREATE PROCEDURE ListaClientesEPedidos()
BEGIN
    SELECT c.Nome AS NomeCliente, p.Nome AS NomeProduto
    FROM Cliente c
    JOIN Pedido pe ON c.CodigoCliente = pe.CodigoCliente
    JOIN Produto p ON pe.CodigoProduto = p.CodigoProduto;
END;


-- 12. Procedure para listar produtos com preço acima de um valor especificado
CREATE PROCEDURE ListaProdutosAcimaDe(
    IN valor DECIMAL(10,2)
)
BEGIN
    SELECT Nome, Preco
    FROM Produto
    WHERE Preco > valor;
END;


-- Para testar todas as procedures que foram criadas, vamos executar chamadas para cada uma delas com os parâmetros apropriados.


-- 1. AddCategoria: Adicionar uma nova categoria
CALL AddCategoria('Nova Categoria', '5%');
-- 2. AddProduto: Adicionar um novo produto
CALL AddProduto('Novo Produto', '150', 1); -- Assuming the category ID for the new product is 1
-- 3. AddCliente: Adicionar um novo cliente (cidade Araguaína)
CALL AddCliente('Novo Cliente', '777.777.777-77', 35, 'Araguaína');
-- 4. AddDescontoEletronicos: Adicionar 15% de desconto em produtos da categoria Eletronicos
CALL AddDescontoEletronicos();
-- 5. VerificaValorPedido: Verificar valor do produto de um pedido
CALL VerificaValorPedido(1, @valorProduto); -- Assuming order ID 1, @valorProduto will hold the output
SELECT @valorProduto;
-- 6. ListaProdutosPorCidade: Listar produtos de pedidos de clientes de uma cidade
CALL ListaProdutosPorCidade('São Jeronimo');
-- 7. MediaPrecoPorCategoria: Retornar a média dos valores dos produtos de uma categoria
CALL MediaPrecoPorCategoria('Eletronicos', @media);
SELECT @media;
-- 8. AtualizaNomeCliente: Atualizar o nome de um cliente com base no seu código
CALL AtualizaNomeCliente(1, 'Novo Nome');
-- 9. ExcluiPedido: Excluir um pedido com base no seu código
CALL ExcluiPedido(1); -- Assuming order ID 1 to be deleted
-- 10. ListaClientesEPedidos: Listar todos os clientes e seus respectivos pedidos
CALL ListaClientesEPedidos();
-- 11. AdicionaPedido: Adicionar um novo pedido
CALL AdicionaPedido(1, 1); -- Assuming product ID 1 and customer ID 1 for the new order
-- 12 Teste da Procedure 12: ListaProdutosAcimaDe 100
CALL ListaProdutosAcimaDe(100);





