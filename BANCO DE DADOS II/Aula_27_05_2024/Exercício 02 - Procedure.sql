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


-- 2. Procedure para adicionar um produto


-- 3. Procedure para adicionar um cliente se for de São Jeronimo


-- 4. Procedure para adicionar 15% de desconto em produtos da categoria Eletronicos


-- 5. Procedure para verificar valor do produto de um pedido


-- 6. Procedure para listar produtos de pedidos de clientes de uma cidade


-- 7. Procedure para retornar a média dos valores dos produtos de uma categoria


-- 8. Procedure para atualizar o nome de um cliente com base no seu código


-- 9. Procedure para excluir um pedido com base no seu código


-- 10. Procedure para listar todos os clientes e seus respectivos pedidos


-- 11. Procedure para adicionar um novo pedido


-- 12. Procedure para listar produtos com preço acima de um valor especificado


-- Para testar todas as procedures que foram criadas, vamos executar chamadas para cada uma delas com os parâmetros apropriados.


-- 1. AddCategoria: Adicionar uma nova categoria

-- 2. AddProduto: Adicionar um novo produto

-- 3. AddCliente: Adicionar um novo cliente (cidade Araguaína)

-- 4. AddDescontoEletronicos: Adicionar 15% de desconto em produtos da categoria Eletronicos

-- 5. VerificaValorPedido: Verificar valor do produto de um pedido

-- 6. ListaProdutosPorCidade: Listar produtos de pedidos de clientes de uma cidade

-- 7. MediaPrecoPorCategoria: Retornar a média dos valores dos produtos de uma categoria

-- 8. AtualizaNomeCliente: Atualizar o nome de um cliente com base no seu código

-- 9. ExcluiPedido: Excluir um pedido com base no seu código

-- 10. ListaClientesEPedidos: Listar todos os clientes e seus respectivos pedidos

-- 11. AdicionaPedido: Adicionar um novo pedido

-- 12 Teste da Procedure 12: ListaProdutosAcimaDe 100





