CREATE DATABASE IF NOT EXISTS VendaDoces;
USE VendaDoces;

-- Criação das Tabelas

-- Tabela Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Endereco VARCHAR(255),
    Telefone VARCHAR(15),
    Email VARCHAR(100)
);

-- Tabela Produtos
CREATE TABLE IF NOT EXISTS Produtos (
    ProdutoID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Descricao TEXT,
    Preco DECIMAL(10, 2),
    Estoque INT
);

-- Tabela Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    PedidoID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT,
    DataPedido DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabela DetalhesPedidos
CREATE TABLE IF NOT EXISTS DetalhesPedidos (
    DetalhePedidoID INT PRIMARY KEY AUTO_INCREMENT,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT,
    Preco DECIMAL(10, 2),
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Tabela Fornecedores
CREATE TABLE IF NOT EXISTS Fornecedores (
    FornecedorID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Contato VARCHAR(100),
    Telefone VARCHAR(15),
    Email VARCHAR(100)
);

-- Inserção de Registros

-- Inserção de registros na tabela Clientes
INSERT INTO Clientes (Nome, Endereco, Telefone, Email) VALUES
('Maria Silva', 'Rua das Flores, 123', '1111-1111', 'maria@exemplo.com'),
('João Souza', 'Avenida Brasil, 456', '2222-2222', 'joao@exemplo.com'),
('Ana Pereira', 'Praça da Sé, 789', '3333-3333', 'ana@exemplo.com'),
('Carlos Santos', 'Rua XV de Novembro, 101', '4444-4444', 'carlos@exemplo.com'),
('Lucia Lima', 'Avenida Paulista, 202', '5555-5555', 'lucia@exemplo.com');

-- Inserção de registros na tabela Produtos
INSERT INTO Produtos (Nome, Descricao, Preco, Estoque) VALUES
('Brigadeiro', 'Doce de chocolate com granulado', 1.50, 100),
('Beijinho', 'Doce de coco com açúcar', 1.50, 80),
('Cajuzinho', 'Doce de amendoim com chocolate', 1.70, 60),
('Bala de Coco', 'Bala de coco tradicional', 0.50, 200),
('Pé de Moleque', 'Doce de amendoim caramelizado', 2.00, 50);

-- Inserção de registros na tabela Pedidos
INSERT INTO Pedidos (ClienteID, DataPedido) VALUES
(1, '2024-05-01'),
(2, '2024-05-02'),
(3, '2024-05-03'),
(4, '2024-05-04'),
(5, '2024-05-05');

-- Inserção de registros na tabela DetalhesPedidos
INSERT INTO DetalhesPedidos (PedidoID, ProdutoID, Quantidade, Preco) VALUES
(1, 1, 10, 1.50),
(1, 2, 5, 1.50),
(2, 3, 7, 1.70),
(2, 4, 20, 0.50),
(3, 5, 4, 2.00),
(3, 1, 15, 1.50),
(4, 2, 8, 1.50),
(4, 3, 10, 1.70),
(5, 4, 25, 0.50),
(5, 5, 3, 2.00);

-- Inserção de registros na tabela Fornecedores
INSERT INTO Fornecedores (Nome, Contato, Telefone, Email) VALUES
('Fornecedor A', 'contatoA@exemplo.com', '6666-6666', 'contatoA@exemplo.com'),
('Fornecedor B', 'contatoB@exemplo.com', '7777-7777', 'contatoB@exemplo.com'),
('Fornecedor C', 'contatoC@exemplo.com', '8888-8888', 'contatoC@exemplo.com'),
('Fornecedor D', 'contatoD@exemplo.com', '9999-9999', 'contatoD@exemplo.com'),
('Fornecedor E', 'contatoE@exemplo.com', '1010-1010', 'contatoE@exemplo.com');


-- Definição das Stored Procedures

DELIMITER //

-- 1. Retornar todos os registros da tabela Clientes
CREATE PROCEDURE SelecionarTodosClientes()
BEGIN
    SELECT * FROM Clientes;
END //

-- 2. Inserir um novo produto na tabela Produtos
CREATE PROCEDURE InserirNovoProduto(
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT,
    IN p_preco DECIMAL(10, 2),
    IN p_estoque INT
)
BEGIN
    INSERT INTO Produtos (Nome, Descricao, Preco, Estoque)
    VALUES (p_nome, p_descricao, p_preco, p_estoque);
END //

-- 3. Atualizar o preço de um produto específico na tabela Produtos
CREATE PROCEDURE AtualizarPrecoProduto(
    IN p_produto_id INT,
    IN p_novo_preco DECIMAL(10, 2)
)
BEGIN
    UPDATE Produtos SET Preco = p_novo_preco WHERE ProdutoID = p_produto_id;
END //

-- 4. Excluir um cliente da tabela Clientes
CREATE PROCEDURE ExcluirClientePorId(
    IN p_cliente_id INT
)
BEGIN
    DELETE FROM Clientes WHERE ClienteID = p_cliente_id;
END //

-- 5. Contar o número de produtos disponíveis no estoque
CREATE PROCEDURE ContarProdutosEstoque(
    OUT p_count INT
)
BEGIN
    SELECT SUM(Estoque) INTO p_count FROM Produtos;
END //

-- 6. Listar todos os pedidos feitos por um cliente específico
CREATE PROCEDURE ListarPedidosCliente(
    IN p_cliente_id INT
)
BEGIN
    SELECT * FROM Pedidos WHERE ClienteID = p_cliente_id;
END //

-- 7. Calcular o valor total de um pedido específico
CREATE PROCEDURE CalcularValorTotalPedido(
    IN p_pedido_id INT,
    OUT p_valor_total DECIMAL(10, 2)
)
BEGIN
    SELECT SUM(Quantidade * Preco) INTO p_valor_total FROM DetalhesPedidos WHERE PedidoID = p_pedido_id;
END //

-- 8. Inserir um novo pedido e detalhes do pedido
CREATE PROCEDURE InserirNovoPedido(
    IN p_cliente_id INT,
    IN p_data_pedido DATE,
    IN p_detalhes_pedido TABLE_TYPE
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE pid INT;

    -- Inserir o pedido
    INSERT INTO Pedidos (ClienteID, DataPedido) VALUES (p_cliente_id, p_data_pedido);
    SET pid = LAST_INSERT_ID();

    -- Inserir os detalhes do pedido
    DECLARE cur CURSOR FOR SELECT * FROM p_detalhes_pedido;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO pid, @produto_id, @quantidade, @preco;
        IF done THEN
            LEAVE read_loop;
        END IF;
        INSERT INTO DetalhesPedidos (PedidoID, ProdutoID, Quantidade, Preco)
        VALUES (pid, @produto_id, @quantidade, @preco);
    END LOOP;

    CLOSE cur;
END //

-- 9. Listar todos os produtos fornecidos por um fornecedor específico
CREATE PROCEDURE ListarProdutosPorFornecedor(
    IN p_fornecedor_id INT
)
BEGIN
    SELECT p.* FROM Produtos p
    JOIN Fornecedores f ON p.FornecedorID = f.FornecedorID
    WHERE f.FornecedorID = p_fornecedor_id;
END //

-- 10. Atualizar a quantidade em estoque de um produto específico
CREATE PROCEDURE AtualizarEstoqueProduto(
    IN p_produto_id INT,
    IN p_nova_quantidade INT
)
BEGIN
    UPDATE Produtos SET Estoque = p_nova_quantidade WHERE ProdutoID = p_produto_id;
END //

-- 11. Listar todos os produtos cujo estoque está abaixo de um determinado valor
CREATE PROCEDURE ListarProdutosBaixoEstoque(
    IN p_limite INT
)
BEGIN
    SELECT * FROM Produtos WHERE Estoque < p_limite;
END //

-- 12. Listar os clientes que fizeram pedidos acima de um determinado valor
CREATE PROCEDURE ListarClientesPedidosAcimaValor(
    IN p
