-- Cria a tabela `Loja` se ela não existir
CREATE TABLE IF NOT EXISTS `Exercicio02`.`Loja` (
  `idLoja` INT(11) NOT NULL AUTO_INCREMENT,  -- Campo de ID da loja, autoincrementável e chave primária
  `Nome` VARCHAR(45) NULL DEFAULT NULL,      -- Campo para nome da loja, até 45 caracteres, opcional
  PRIMARY KEY (`idLoja`))                    -- Define `idLoja` como chave primária
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Cria a tabela `Produtos` se ela não existir
CREATE TABLE IF NOT EXISTS `Exercicio02`.`Produtos` (
  `idProdutos` INT(11) NOT NULL AUTO_INCREMENT, -- Campo de ID dos produtos, autoincrementável e chave primária
  `Nome` VARCHAR(45) NULL DEFAULT NULL,         -- Campo para nome do produto, até 45 caracteres, opcional
  `Valor` DECIMAL(10,2) NULL DEFAULT NULL,      -- Campo para valor do produto, com dois decimais, opcional
  `Descricao` VARCHAR(45) NULL DEFAULT NULL,    -- Campo para descrição do produto, até 45 caracteres, opcional
  `Loja_idLoja` INT(11) NOT NULL,               -- Campo de chave estrangeira para ID da loja associada
  PRIMARY KEY (`idProdutos`),                   -- Define `idProdutos` como chave primária
  INDEX `fk_Produtos_Loja_idx` (`Loja_idLoja` ASC),  -- Índice para chave estrangeira da loja
  CONSTRAINT `fk_Produtos_Loja`                  -- Restrição de chave estrangeira que referencia `Loja`
    FOREIGN KEY (`Loja_idLoja`)
    REFERENCES `Exercicio02`.`Loja` (`idLoja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Cria a tabela `Pedido` se ela não existir
CREATE TABLE IF NOT EXISTS `Exercicio02`.`Pedido` (
  `idPedido` INT(11) NOT NULL AUTO_INCREMENT,  -- Campo de ID do pedido, autoincrementável e chave primária
  `Quantidade` INT(11) NULL DEFAULT NULL,      -- Campo para quantidade de produtos no pedido, opcional
  `Produtos_idProdutos` INT(11) NOT NULL,      -- Campo de chave estrangeira para ID do produto associado
  `Cliente_idCliente` INT(11) NOT NULL,        -- Campo de chave estrangeira para ID do cliente associado
  PRIMARY KEY (`idPedido`),                    -- Define `idPedido` como chave primária
  INDEX `fk_Pedido_Produtos1_idx` (`Produtos_idProdutos` ASC), -- Índice para chave estrangeira dos produtos
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC),    -- Índice para chave estrangeira dos clientes
  CONSTRAINT `fk_Pedido_Produtos1`              -- Restrição de chave estrangeira que referencia `Produtos`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `Exercicio02`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Cliente1`               -- Restrição de chave estrangeira que referencia `Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Exercicio02`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Cria a tabela `Cliente` se ela não existir
CREATE TABLE IF NOT EXISTS `Exercicio02`.`Cliente` (
  `idCliente` INT(11) NOT NULL AUTO_INCREMENT, -- Campo de ID do cliente, autoincrementável e chave primária
  `Nome` VARCHAR(45) NULL DEFAULT NULL,        -- Campo para nome do cliente, até 45 caracteres, opcional
  `idade` INT(11) NULL DEFAULT NULL,           -- Campo para idade do cliente, opcional
  `CPF` VARCHAR(45) NULL DEFAULT NULL,         -- Campo para CPF do cliente, até 45 caracteres, opcional
  `endereco` VARCHAR(45) NULL DEFAULT NULL,    -- Campo para endereço do cliente, até 45 caracteres, opcional
  PRIMARY KEY (`idCliente`))                   -- Define `idCliente` como chave primária
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Cria a tabela `Log` se ela não existir
CREATE TABLE IF NOT EXISTS `Exercicio02`.`Log` (
  `idLog` INT(11) NOT NULL AUTO_INCREMENT,     -- Campo de ID do log, autoincrementável e chave primária
  `Descricao` VARCHAR(300) NULL DEFAULT NULL,  -- Campo para descrição do log, até 300 caracteres, opcional
  PRIMARY KEY (`idLog`))                       -- Define `idLog` como chave primária
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- Restaura as configurações de SQL originais após as alterações temporárias
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- 							Exercício

/*
1.: Crie uma trigger que ao atualizar o valor de um produto, seja gerado um log,
informando qual produto foi alterado, quanto foi o aumento ou decréscimo no
valor e em qual loja foi realizado a atualização do valor.

*/

DELIMITER //
CREATE TRIGGER ProductValueUpdate
AFTER UPDATE ON Produtos
FOR EACH ROW
BEGIN
    DECLARE logDesc VARCHAR(300);
    DECLARE valueChange DECIMAL(10,2);
    
    IF OLD.Valor <> NEW.Valor THEN
        SET valueChange = NEW.Valor - OLD.Valor;
        SET logDesc = CONCAT('Produto ', NEW.Nome, ' teve o valor alterado em ', valueChange, ' na loja ', NEW.Loja_idLoja);
        INSERT INTO Log (Descricao) VALUES (logDesc);
    END IF;
END //

DELIMITER ;

/*
2.: Crie uma trigger que quando for atualizado o endereço de uma loja, todos os
produtos daquela loja tenham seus valores aumentados em 5%
*/

DELIMITER //

CREATE TRIGGER UpdateProductPrices
AFTER UPDATE ON Loja
FOR EACH ROW
BEGIN
    IF OLD.Endereco <> NEW.Endereco THEN
        UPDATE Produtos SET Valor = Valor * 1.05 WHERE Loja_idLoja = NEW.idLoja;
    END IF;
END //

DELIMITER ;

/*
3.: Crie uma trigger que ao ser realizado uma alteração na tabela cliente, se a idade
dele for maior ou igual a 18 anos, seja gerado um registro na seguinte forma:
Cliente: nome_do_cliente, Idade: idade_cliente, Alterou os dados do Registro.
Caso a idade dele, seja menor que 18 anos, o registro será gerado da seguinte
forma: Cliente: nome_do_cliente, Idade: idade_cliente, Alterou os dados do Registro,
informar os responsáveis!*/

DELIMITER //

CREATE TRIGGER ClientAgeChange
AFTER UPDATE ON Cliente
FOR EACH ROW
BEGIN
    DECLARE logDesc VARCHAR(300);
    
    IF OLD.idade >= 18 AND NEW.idade >= 18 THEN
        SET logDesc = CONCAT('Cliente: ', NEW.Nome, ', Idade: ', NEW.idade, ', Alterou os dados do Registro.');
    ELSE
        SET logDesc = CONCAT('Cliente: ', NEW.Nome, ', Idade: ', NEW.idade, ', Alterou os dados do Registro, informar os responsáveis!');
    END IF;
    
    INSERT INTO Log (Descricao) VALUES (logDesc);
END //

DELIMITER ;

/*
4.: Crie uma trigger que quando um cliente for deletado, seja gerado um registro na
tabela log, informando o nome do cliente, o CPF e informando que a conta do
cliente foi deletada.*/

DELIMITER //

CREATE TRIGGER ClientDeletion
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
    DECLARE logDesc VARCHAR(300);
    SET logDesc = CONCAT('Cliente: ', OLD.Nome, ', CPF: ', OLD.CPF, ', informando que a conta do cliente foi deletada.');
    INSERT INTO Log (Descricao) VALUES (logDesc);
END //

DELIMITER ;
