CREATE database tRIGGER01;

USE tRIGGER01;

CREATE TABLE Alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_criacao DATETIME
);

CREATE TABLE Professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    departamento VARCHAR(100)
);



CREATE TABLE Cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    id_professor INT,
    FOREIGN KEY (id_professor) REFERENCES Professores(id)
);


CREATE TABLE LogDepartamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_professor INT,
    departamento_anterior VARCHAR(100),
    departamento_novo VARCHAR(100),
    data_mudanca DATETIME
);


CREATE TABLE LogDeletados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_delecao DATETIME
);




DELIMITER $$

CREATE TRIGGER antes_inserir_aluno
BEFORE INSERT ON Alunos
FOR EACH ROW
BEGIN
    SET NEW.data_criacao = NOW();  -- Define a data e hora atual como a data de criação do registro
END$$

DELIMITER ;


select *from Alunos;

insert into alunos (id, nome, email) values ('01','Carla','carla@gmail.com');

DELIMITER $$

CREATE TRIGGER verifica_professor
BEFORE INSERT ON Cursos
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT * FROM Professores WHERE id = NEW.id_professor) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Professor não encontrado.';
    END IF;
END $$

DELIMITER ;

select *from professores

select *from cursos;

insert into cursos (id, nome, id_professor) values ('1','Informática','1');

DELIMITER $$

CREATE TRIGGER antes_atualizar_aluno
BEFORE UPDATE ON Alunos
FOR EACH ROW
BEGIN
    IF OLD.email <> NEW.email THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Alteração de e-mail não permitida.';
    END IF;
END $$

DELIMITER ;

select *from alunos;

update alunos set nome= 'Carlas', email='carlassilva@gmail.com' where id=1;
update alunos set nome= 'Carlas silva' where id=1;


DELIMITER $$
CREATE TRIGGER atualiza_departamento
AFTER UPDATE ON Professores
FOR EACH ROW
BEGIN
    INSERT INTO LogDepartamento (id_professor, departamento_anterior, departamento_novo, data_mudanca)
    VALUES (NEW.id, OLD.departamento, NEW.departamento, NOW());
END $$

DELIMITER ;

select *from Professores;

insert into professores (id, nome, departamento) values ('2','Ana Paula','Informática');


update professores set departamento='desenvolvedor' where id=1;

select *from LogDepartamento;

DELIMITER $$

CREATE TRIGGER antes_deletar_aluno
BEFORE DELETE ON Alunos
FOR EACH ROW
BEGIN
    INSERT INTO LogDeletados (id_aluno, nome, email, data_delecao)
    VALUES (OLD.id, OLD.nome, OLD.email, NOW());
END $$

DELIMITER ; 

select *from alunos;

delete from alunos where id=1;


select *from LogDeletados;

DELIMITER $$

CREATE TRIGGER depois_deletar_curso
AFTER DELETE ON Cursos
FOR EACH ROW
BEGIN
    UPDATE Professores SET departamento = 'Atualizar' WHERE id = OLD.id_professor;
END $$

DELIMITER ;

select *from professores;

select *from cursos;

insert into cursos (id, nome, id_professor) values (1, 'Banco de Dados',1);
insert into cursos (id, nome, id_professor) values (2, 'C#',2);

delete from cursos where id=2;

1-- 
DELIMITER $$
CREATE TRIGGER antes_inserir_aluno
BEFORE INSERT ON Alunos
FOR EACH ROW
BEGIN
    SET NEW.data_criacao = NOW();  
END$$
DELIMITER ;
2--
DELIMITER $$
CREATE TRIGGER verifica_professor
BEFORE INSERT ON Cursos
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT * FROM Professores WHERE id = NEW.id_professor) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Professor não encontrado.';
    END IF;
END$$
DELIMITER ;
3-- 
DELIMITER $$
CREATE TRIGGER atualiza_departamento
AFTER UPDATE ON Professores
FOR EACH ROW
BEGIN
    INSERT INTO LogDepartamento (id_professor, departamento_anterior, departamento_novo, data_mudanca)
    VALUES (NEW.id, OLD.departamento, NEW.departamento, NOW());
END$$
DELIMITER ;




