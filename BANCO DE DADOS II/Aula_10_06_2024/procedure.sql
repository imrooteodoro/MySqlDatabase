-- Arquivo: procedures.sql

-- Definição das Stored Procedures

DELIMITER //

-- 01 - SelecionarTodosUsuarios
CREATE PROCEDURE SelecionarTodosUsuarios()
BEGIN
    SELECT * FROM usuarios;
END //

-- 02 - SelecionarUsuarioPorId
CREATE PROCEDURE SelecionarUsuarioPorId(
    IN p_usuario_id INT
)
BEGIN
    SELECT * FROM usuarios WHERE id = p_usuario_id;
END //

-- 03 - ObterNomeUsuario
CREATE PROCEDURE ObterNomeUsuario(
    IN p_usuario_id INT,
    OUT p_nome_usuario VARCHAR(100)
)
BEGIN
    SELECT nome INTO p_nome_usuario FROM usuarios WHERE id = p_usuario_id;
END //

-- 04 - InserirNovoCurso
CREATE PROCEDURE InserirNovoCurso(
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT,
    IN p_data_inicio DATE,
    IN p_data_fim DATE
)
BEGIN
    INSERT INTO cursos (nome, descricao, data_inicio, data_fim)
    VALUES (p_nome, p_descricao, p_data_inicio, p_data_fim);
END //

-- 05 - AtualizarDescricaoCurso
CREATE PROCEDURE AtualizarDescricaoCurso(
    IN p_curso_id INT,
    IN p_nova_descricao TEXT
)
BEGIN
    UPDATE cursos SET descricao = p_nova_descricao WHERE id = p_curso_id;
END //

-- 06 - DeletarCursoPorId
CREATE PROCEDURE DeletarCursoPorId(
    IN p_curso_id INT
)
BEGIN
    DELETE FROM cursos WHERE id = p_curso_id;
END //

-- 07 - VerificarCurso
CREATE PROCEDURE VerificarCurso(
    IN p_curso_id INT
)
BEGIN
    DECLARE v_existe INT;

    SELECT COUNT(*) INTO v_existe FROM cursos WHERE id = p_curso_id;

    IF v_existe > 0 THEN
        SELECT 'Curso encontrado' AS mensagem;
    ELSE
        SELECT 'Curso não encontrado' AS mensagem;
    END IF;
END //

-- 08 - ListarNomesUsuarios
CREATE PROCEDURE ListarNomesUsuarios()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nome VARCHAR(100);

    DECLARE cur CURSOR FOR SELECT nome FROM usuarios;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_nome;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Aqui pode-se fazer algo com o nome, como SELECT, INSERT, etc.
        SELECT v_nome;
    END LOOP;

    CLOSE cur;
END //

-- 09 - InserirNovoUsuario
CREATE PROCEDURE InserirNovoUsuario(
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Erro ao inserir usuário. Verifique os dados.' AS mensagem;
    END;

    INSERT INTO usuarios (nome, email, senha)
    VALUES (p_nome, p_email, p_senha);

    SELECT 'Usuário inserido com sucesso.' AS mensagem;
END //

-- 10 - TransacaoInserirCursos
CREATE PROCEDURE TransacaoInserirCursos(
    IN p_nome1 VARCHAR(100),
    IN p_descricao1 TEXT,
    IN p_data_inicio1 DATE,
    IN p_data_fim1 DATE,
    IN p_nome2 VARCHAR(100),
    IN p_descricao2 TEXT,
    IN p_data_inicio2 DATE,
    IN p_data_fim2 DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Erro ao inserir cursos. Transação revertida.' AS mensagem;
    END;

    START TRANSACTION;

    INSERT INTO cursos (nome, descricao, data_inicio, data_fim)
    VALUES (p_nome1, p_descricao1, p_data_inicio1, p_data_fim1);

    INSERT INTO cursos (nome, descricao, data_inicio, data_fim)
    VALUES (p_nome2, p_descricao2, p_data_inicio2, p_data_fim2);

    COMMIT;
    SELECT 'Cursos inseridos com sucesso.' AS mensagem;
END //

-- 11 - ProcedureA e ProcedureB
CREATE PROCEDURE ProcedureB()
BEGIN
    SELECT 'Procedure B foi chamada.' AS mensagem;
END //

CREATE PROCEDURE ProcedureA()
BEGIN
    CALL ProcedureB();
END //

DELIMITER ;
