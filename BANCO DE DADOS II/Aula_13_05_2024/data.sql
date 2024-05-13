-- Questão 1: Criação de Procedure
DELIMITER //
CREATE PROCEDURE adicionarAutor (IN nomeAutor VARCHAR(255))
BEGIN
    INSERT INTO Autores (Nome) VALUES (nomeAutor);
END //
DELIMITER ;

-- Questão 2: Utilização de Procedure
CALL adicionarAutor('J.K. Rowling');
CALL adicionarAutor('George R.R. Martin');
CALL adicionarAutor('Isaac Asimov');

-- Questão 3: Procedure com Parâmetros de Saída
DELIMITER //
CREATE PROCEDURE contarLivrosPorAutor (IN autorID INT, OUT totalLivros INT)
BEGIN
    SELECT COUNT(*) INTO totalLivros FROM Livros WHERE AutorID = autorID;
END //
DELIMITER ;

-- Questão 4: Procedure de Atualização
DELIMITER //
CREATE PROCEDURE atualizarEmailUsuario (IN userID INT, IN novoEmail VARCHAR(255))
BEGIN
    UPDATE Usuarios SET Email = novoEmail WHERE UsuarioID = userID;
END //
DELIMITER ;

-- Questão 5: Procedure de Exclusão
DELIMITER //
CREATE PROCEDURE removerLivro (IN livroID INT)
BEGIN
    DELETE FROM Livros WHERE LivroID = livroID;
END //
DELIMITER ;

-- Questão 6: Procedure de Consulta
DELIMITER //
CREATE PROCEDURE listarEmprestimosPorUsuario (IN userID INT)
BEGIN
    SELECT Livros.Titulo, Emprestimos.DataEmprestimo, Emprestimos.DataDevolucao
    FROM Emprestimos
    JOIN Livros ON Emprestimos.LivroID = Livros.LivroID
    WHERE Emprestimos.UsuarioID = userID;
END //
DELIMITER ;

-- Questão 7: Procedure de Multi-tabelas
DELIMITER //
CREATE PROCEDURE detalhesLivro (IN livroID INT)
BEGIN
    SELECT Livros.Titulo, Livros.AnoPublicacao, Autores.Nome AS NomeAutor, Editoras.Nome AS NomeEditora
    FROM Livros
    JOIN Autores ON Livros.AutorID = Autores.AutorID
    JOIN Editoras ON Livros.EditoraID = Editoras.EditoraID
    WHERE Livros.LivroID = livroID;
END //
DELIMITER ;
