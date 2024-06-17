-- 1: ListarUsuarios
DELIMITER //

CREATE PROCEDURE ListarUsuarios()
BEGIN
    SELECT * FROM Usuarios;
END //

DELIMITER ;

-- 2: InserirUsuario
DELIMITER //

CREATE PROCEDURE InserirUsuario(
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(100),
    IN p_data_nascimento DATE,
    IN p_cpf VARCHAR(20)
)
BEGIN
    INSERT INTO Usuarios (nome, email, senha, data_nascimento, cpf)
    VALUES (p_nome, p_email, p_senha, p_data_nascimento, p_cpf);
END //

DELIMITER ;

-- 3: AtualizarEmailUsuario
DELIMITER //

CREATE PROCEDURE AtualizarEmailUsuario(
    IN p_id INT,
    IN p_novo_email VARCHAR(100)
)
BEGIN
    UPDATE Usuarios SET email = p_novo_email WHERE id = p_id;
END //

DELIMITER ;

-- 4: DeletarUsuario
DELIMITER //

CREATE PROCEDURE DeletarUsuario(
    IN p_id INT
)
BEGIN
    DELETE FROM Usuarios WHERE id = p_id;
END //

DELIMITER ;

-- 5: ListarVacinasDisponiveis
DELIMITER //

CREATE PROCEDURE ListarVacinasDisponiveis()
BEGIN
    SELECT v.*
    FROM Vacinas v
    INNER JOIN Estoques e ON v.id = e.vacina_id
    WHERE e.quantidade > 0;
END //

DELIMITER ;

-- 6: RegistrarLote
DELIMITER //

CREATE PROCEDURE RegistrarLote(
    IN p_vacina_id INT,
    IN p_numero_lote VARCHAR(50),
    IN p_data_fabricacao DATE,
    IN p_data_validade DATE,
    IN p_quantidade INT
)
BEGIN
    INSERT INTO Lotes (vacina_id, numero_lote, data_fabricacao, data_validade, quantidade)
    VALUES (p_vacina_id, p_numero_lote, p_data_fabricacao, p_data_validade, p_quantidade);
END //

DELIMITER ;

-- 7: ContarPacientesCentro
DELIMITER //

CREATE PROCEDURE ContarPacientesCentro(
    IN p_centro_id INT,
    OUT p_contagem INT
)
BEGIN
    SELECT COUNT(*) INTO p_contagem
    FROM Agendamentos a
    WHERE a.centro_id = p_centro_id;
END //

DELIMITER ;

-- 8: ListarAgendamentosPaciente
DELIMITER //

CREATE PROCEDURE ListarAgendamentosPaciente(
    IN p_paciente_id INT
)
BEGIN
    SELECT a.*
    FROM Agendamentos a
    WHERE a.paciente_id = p_paciente_id;
END //

DELIMITER ;

-- 9: RegistrarAplicacao
DELIMITER //

CREATE PROCEDURE RegistrarAplicacao(
    IN p_agendamento_id INT,
    IN p_profissional_id INT,
    IN p_data_aplicacao DATE
)
BEGIN
    INSERT INTO Aplicacoes (agendamento_id, profissional_id, data_aplicacao)
    VALUES (p_agendamento_id, p_profissional_id, p_data_aplicacao);
END //

DELIMITER ;

-- 10: ListarEfeitosAdversos
DELIMITER //

CREATE PROCEDURE ListarEfeitosAdversos()
BEGIN
    SELECT * FROM Efeitos_Adversos;
END //

DELIMITER ;

-- 11: RegistrarEfeitoAdverso
DELIMITER //

CREATE PROCEDURE RegistrarEfeitoAdverso(
    IN p_aplicacao_id INT,
    IN p_descricao VARCHAR(255),
    IN p_data_ocorrencia DATE
)
BEGIN
    INSERT INTO Efeitos_Adversos (aplicacao_id, descricao, data_ocorrencia)
    VALUES (p_aplicacao_id, p_descricao, p_data_ocorrencia);
END //

DELIMITER ;

-- 12: AtualizarEstoque
DELIMITER //

CREATE PROCEDURE AtualizarEstoque(
    IN p_centro_id INT,
    IN p_vacina_id INT,
    IN p_nova_quantidade INT
)
BEGIN
    UPDATE Estoques
    SET quantidade = p_nova_quantidade
    WHERE centro_id = p_centro_id AND vacina_id = p_vacina_id;
END //

DELIMITER ;

-- 13: ListarProfissionaisCentro
DELIMITER //

CREATE PROCEDURE ListarProfissionaisCentro(
    IN p_centro_id INT
)
BEGIN
    SELECT p.*
    FROM Profissionais p
    WHERE p.centro_id = p_centro_id;
END //

DELIMITER ;

-- 14: ListarVacinasPaciente
DELIMITER //

CREATE PROCEDURE ListarVacinasPaciente(
    IN p_paciente_id INT
)
BEGIN
    SELECT v.nome, a.data_aplicacao
    FROM Vacinas v
    JOIN Agendamentos ag ON v.id = ag.vacina_id
    JOIN Aplicacoes a ON ag.id = a.agendamento_id
    WHERE ag.paciente_id = p_paciente_id;
END //

DELIMITER ;

-- 15: ListarCentrosComEstoque
DELIMITER //

CREATE PROCEDURE ListarCentrosComEstoque()
BEGIN
    SELECT DISTINCT c.*
    FROM Centros c
    JOIN Estoques e ON c.id = e.centro_id
    WHERE e.quantidade > 0;
END //

DELIMITER ;
