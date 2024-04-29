CREATE DATABASE BB_GERENCIAMENTO_RURAL;

USE BB_GERENCIAMENTO_RURAL; 

CREATE TABLE Fazenda (
    FazendaID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Localizacao VARCHAR(255)
);

CREATE TABLE Gado (
    GadoID INT AUTO_INCREMENT PRIMARY KEY,
    FazendaID INT,
    Nome VARCHAR(50),
    Raca VARCHAR(50),
    DataNascimento DATE,
    PesoAtual FLOAT,
    FOREIGN KEY (FazendaID) REFERENCES Fazenda(FazendaID)
);

CREATE TABLE Veterinario (
    VeterinarioID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Especialidade VARCHAR(100)
);

CREATE TABLE Vacinacao (
    VacinacaoID INT AUTO_INCREMENT PRIMARY KEY,
    GadoID INT,
    VeterinarioID INT,
    DataVacina DATE,
    NomeVacina VARCHAR(100),
    FOREIGN KEY (GadoID) REFERENCES Gado(GadoID),
    FOREIGN KEY (VeterinarioID) REFERENCES Veterinario(VeterinarioID)
);

CREATE TABLE Alimentacao (
    AlimentacaoID INT AUTO_INCREMENT PRIMARY KEY,
    GadoID INT,
    DataAlimentacao DATE,
    TipoAlimento VARCHAR(100),
    Quantidade FLOAT,
    FOREIGN KEY (GadoID) REFERENCES Gado(GadoID)
);

-- Inserção na tabela Fazenda
INSERT INTO Fazenda (Nome, Localizacao) VALUES
('Fazenda Santa Fé', 'Cidade Alta, MG'),
('Fazenda Boa Esperança', 'Vale do Rio Doce, MG'),
('Fazenda São Jorge', 'Planalto Central, GO');

-- Inserção na tabela Gado
INSERT INTO Gado (FazendaID, Nome, Raca, DataNascimento, PesoAtual) VALUES
(1, 'Boi1', 'Nelore', '2018-03-21', 450.0),
(2, 'Boi2', 'Angus', '2019-04-15', 500.0),
(3, 'Boi3', 'Hereford', '2020-05-10', 530.0);

-- Inserção na tabela Veterinario
INSERT INTO Veterinario (Nome, Especialidade) VALUES
('Dr. Ana', 'Bovinos'),
('Dr. Carlos', 'Suínos'),
('Dr. Maria', 'Equinos');

-- Inserção na tabela Vacinacao
INSERT INTO Vacinacao (GadoID, VeterinarioID, DataVacina, NomeVacina) VALUES
(1, 1, '2021-06-01', 'Febre Aftosa'),
(2, 1, '2021-06-01', 'Brucelose'),
(3, 1, '2021-06-01', 'Raiva');

-- Inserção na tabela Alimentação
INSERT INTO Alimentacao (GadoID, DataAlimentacao, TipoAlimento, Quantidade) VALUES
(1, '2021-07-01', 'Milho', 5.0),
(2, '2021-07-02', 'Soja', 4.5),
(3, '2021-07-03', 'Capim', 6.0);

CREATE TABLE AuditoriaGado (
    AuditoriaID INT AUTO_INCREMENT PRIMARY KEY,
    TipoOperacao CHAR(1),
    GadoID INT,
    NomeAntigo VARCHAR(50),
    RacaAntiga VARCHAR(50),
    DataHoraOperacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Exercício Prático de Triggers


/* 
1. Criação de Trigger de Inserção:
   - Crie uma trigger chamada `TriggerInsercaoGado` que atua após a inserção de um novo registro na tabela `Gado`.
   Essa trigger deve inserir um registro na tabela `AuditoriaGado`,
   indicando o ID do gado, o nome, a raça, e o tipo de operação ('I' para inserção).
   */	

   -- Trigger de Inserção
DELIMITER //
CREATE TRIGGER TriggerInsercaoGado AFTER INSERT ON Gado
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaGado (TipoOperacao, GadoID, NomeAntigo, RacaAntiga)
    VALUES ('I', NEW.GadoID, NEW.Nome, NEW.Raca);
END //
DELIMITER ;

/*
2. Criação de Trigger de Atualização:
   - Crie uma trigger chamada `TriggerAtualizacaoGado` que atua após a atualização de um registro na tabela `Gado`.
   A trigger deve registrar na tabela `AuditoriaGado` qualquer alteração no nome ou na raça do gado, indicando o ID do gado,
   os valores antigos de nome e raça, e o tipo de operação ('U' para atualização).
   */
   -- Trigger de Atualização
DELIMITER //
CREATE TRIGGER TriggerAtualizacaoGado AFTER UPDATE ON Gado
FOR EACH ROW
BEGIN
    IF OLD.Nome != NEW.Nome OR OLD.Raca != NEW.Raca THEN
        INSERT INTO AuditoriaGado (TipoOperacao, GadoID, NomeAntigo, RacaAntiga)
        VALUES ('U', OLD.GadoID, OLD.Nome, OLD.Raca);
    END IF;
END //
DELIMITER ;

/*
3. Criação de Trigger de Deleção:
   - Crie uma trigger chamada `TriggerDelecaoGado` que atua antes da deleção de um registro na tabela `Gado`.
   Essa trigger deve inserir um registro na tabela `AuditoriaGado`, incluindo o ID do gado, o nome,
   a raça, e o tipo de operação ('D' para deleção).
   */

-- Trigger de Deleção
DELIMITER //
CREATE TRIGGER TriggerDelecaoGado BEFORE DELETE ON Gado
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaGado (TipoOperacao, GadoID, NomeAntigo, RacaAntiga)
    VALUES ('D', OLD.GadoID, OLD.Nome, OLD.Raca);
END //
DELIMITER ;

/*
4. Teste das Triggers:
   - Insira três novos registros na tabela `Gado`.
   - Atualize o nome e a raça de um dos registros inseridos.
   - Delete um dos registros inseridos.
   - Consulte a tabela `AuditoriaGado` e verifique se as operações foram registradas corretamente.
   */

INSERT INTO Gado (FazendaID, Nome, Raca, DataNascimento, PesoAtual) VALUES
(1, 'Boi4', 'Holandês', '2019-06-12', 480.0),
(2, 'Boi5', 'Charolês', '2020-07-25', 510.0),
(3, 'Boi6', 'Simmental', '2021-08-18', 540.0);

UPDATE Gado SET Nome = 'Boi2 Updated', Raca = 'Angus Updated' WHERE GadoID = 2;

DELETE FROM Gado WHERE GadoID = 3;

SELECT * FROM AuditoriaGado;








