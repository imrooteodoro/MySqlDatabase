-- Criação do Banco de dados
CREATE DATABASE SistemaStartup;

-- Usar Banco de Dados
USE SistemaStartup;

-- Criação da tabela de Usuários
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(255) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    UserRole ENUM('Investidor', 'Empreendedor') NOT NULL,
    SignupDate DATETIME NOT NULL
);

-- Criação da tabela de Categorias de Projetos
CREATE TABLE ProjectCategories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT
);

-- Criação da tabela de Projetos
CREATE TABLE Projects (
    ProjectID INT AUTO_INCREMENT PRIMARY KEY,
    OwnerUserID INT NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL,
    CategoryID INT,
    TargetAmount DECIMAL(10, 2) NOT NULL,
    RaisedAmount DECIMAL(10, 2) DEFAULT 0,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (OwnerUserID) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES ProjectCategories(CategoryID)
);

-- Criação da tabela de Investimentos
CREATE TABLE Investments (
    InvestmentID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectID INT NOT NULL,
    InvestorUserID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    InvestmentDate DATE NOT NULL,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (InvestorUserID) REFERENCES Users(UserID)
);

-- Criação da tabela de Avaliações de Projetos
CREATE TABLE ProjectReviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectID INT NOT NULL,
    ReviewerUserID INT NOT NULL,
    Rating INT NOT NULL,
    Comments TEXT,
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (ReviewerUserID) REFERENCES Users(UserID)
);

-- Criação da tabela de Eventos
CREATE TABLE Events (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    EventDate DATETIME NOT NULL,
    Location VARCHAR(255) NOT NULL
);

-- Criação da tabela de Participantes dos Eventos
CREATE TABLE EventParticipants (
    EventID INT,
    UserID INT,
    ParticipationType ENUM('Palestrante', 'Ouvinte', 'Patrocinador') NOT NULL,
    PRIMARY KEY (EventID, UserID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Criação da tabela de Marcas de Interesse dos Investidores
CREATE TABLE InvestorInterests (
    InterestID INT AUTO_INCREMENT PRIMARY KEY,
    InvestorUserID INT NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (InvestorUserID) REFERENCES Users(UserID),
    FOREIGN KEY (CategoryID) REFERENCES ProjectCategories(CategoryID)
);


-- Inserção de Dados na Tabela Users

INSERT INTO Users (Email, PasswordHash, Name, UserRole, SignupDate) VALUES 
('investidor1@example.com', 'hash1', 'Investidor Um', 'Investidor', '2023-01-01'),
('empreendedor1@example.com', 'hash2', 'Empreendedor Dois', 'Empreendedor', '2023-01-02'),
('investidor2@example.com', 'hash3', 'Investidor Dois', 'Investidor', '2023-01-03'),
('empreendedor2@example.com', 'hash4', 'Empreendedor Quatro', 'Empreendedor', '2023-01-04'),
('investidor3@example.com', 'hash5', 'Investidor Três', 'Investidor', '2023-01-05'),
('empreendedor3@example.com', 'hash6', 'Empreendedor Seis', 'Empreendedor', '2023-01-06'),
('investidor4@example.com', 'hash7', 'Investidor Quatro', 'Investidor', '2023-01-07'),
('empreendedor4@example.com', 'hash8', 'Empreendedor Oito', 'Empreendedor', '2023-01-08'),
('investidor5@example.com', 'hash9', 'Investidor Cinco', 'Investidor', '2023-01-09'),
('empreendedor5@example.com', 'hash10', 'Empreendedor Dez', 'Empreendedor', '2023-01-10');


-- Inserção de Dados na Tabela ProjectCategories


INSERT INTO ProjectCategories (Name, Description) VALUES 
('Tecnologia', 'Projetos inovadores na área de tecnologia'),
('Saúde', 'Startups focadas em soluções de saúde e bem-estar'),
('Educação', 'Projetos que buscam inovar na educação'),
('Meio Ambiente', 'Soluções sustentáveis e eco-friendly'),
('Alimentação', 'Inovações no setor de alimentos e bebidas'),
('Moda', 'Startups de moda com foco em sustentabilidade'),
('Finanças', 'Soluções inovadoras para o setor financeiro'),
('Entretenimento', 'Projetos no setor de entretenimento e lazer'),
('Esportes', 'Startups focadas em esportes e atividades físicas'),
('Viagem', 'Soluções inovadoras para o setor de turismo e viagens');


-- Inserção de Dados na Tabela Projects


INSERT INTO Projects (OwnerUserID, Title, Description, CategoryID, TargetAmount, RaisedAmount, StartDate, EndDate) VALUES 
(2, 'App de Educação Financeira', 'Um aplicativo que ajuda no controle financeiro pessoal.', 7, 100000, 50000, '2023-02-01', '2023-08-01'),
(4, 'Plataforma de E-learning', 'Plataforma online com cursos de diversas áreas do conhecimento.', 3, 200000, 150000, '2023-03-01', '2023-09-01'),
(6, 'Moda Sustentável', 'Marca de roupas que utiliza materiais reciclados.', 6, 75000, 30000, '2023-04-01', '2023-10-01'),
(8, 'Marketplace de Orgânicos', 'Plataforma online para venda de alimentos orgânicos.', 5, 50000, 20000, '2023-05-01', '2023-11-01'),
(10, 'App de Bem-Estar', 'Aplicativo com foco em meditação e práticas de mindfulness.', 2, 85000, 42500, '2023-06-01', '2023-12-01'),
(2, 'Tecnologia Verde', 'Soluções tecnológicas para redução de carbono.', 4, 120000, 60000, '2023-02-15', '2023-08-15'),
(4, 'Startup de Turismo', 'Plataforma de experiências de viagens únicas.', 10, 95000, 47500, '2023-03-15', '2023-09-15'),
(6, 'Fitness Tech', 'Wearable que monitora a saúde e a atividade física.', 9, 130000, 65000, '2023-04-15', '2023-10-15'),
(8, 'Gastronomia Inovadora', 'Restaurante com cardápio baseado em impressão 3D de alimentos.', 5, 110000, 55000, '2023-05-15', '2023-11-15'),
(10, 'Plataforma de eSports', 'Organização e transmissão de campeonatos de eSports.', 8, 160000, 80000, '2023-06-15', '2023-12-15');


-- Inserção de Dados na Tabela Investments


INSERT INTO Investments (ProjectID, InvestorUserID, Amount, InvestmentDate) VALUES 
(1, 1, 10000, '2023-02-10'),
(2, 3, 15000, '2023-02-12'),
(3, 5, 5000, '2023-02-15'),
(4, 7, 8000, '2023-02-18'),
(5, 9, 20000, '2023-02-20'),
(6, 1, 12000, '2023-03-05'),
(7, 3, 25000, '2023-03-07'),
(8, 5, 7000, '2023-03-10'),
(9, 7, 9500, '2023-03-12'),
(10, 9, 30000, '2023-03-15');


-- Inserção de Dados na Tabela ProjectReviews


INSERT INTO ProjectReviews (ProjectID, ReviewerUserID, Rating, Comments, ReviewDate) VALUES 
(1, 2, 4, 'Muito promissor, mas precisa de ajustes.', '2023-02-20'),
(2, 4, 5, 'Excelente projeto. Muito necessário.', '2023-02-22'),
(3, 6, 3, 'Ideia boa, mas o plano de negócios é fraco.', '2023-02-24'),
(4, 8, 5, 'Inovador e com grande potencial de mercado.', '2023-02-26'),
(5, 10, 4, 'Gostei muito, mas precisa de mais marketing.', '2023-02-28'),
(6, 2, 5, 'Fantástico. Totalmente a bordo.', '2023-03-02'),
(7, 4, 2, 'Não me convenceu. Falta um diferencial.', '2023-03-04'),
(8, 6, 4, 'Bom projeto. Tem potencial se bem executado.', '2023-03-06'),
(9, 8, 3, 'Interessante, mas vejo muitos riscos.', '2023-03-08'),
(10, 10, 5, 'Adorei! Inovador e com visão de futuro.', '2023-03-10');

-- Inserção de Dados na Tabela Events

INSERT INTO Events (Title, Description, EventDate, Location) VALUES 
('Demo Day Março', 'Apresentação de startups para investidores.', '2023-03-20', 'Auditório Central'),
('Hackathon Saúde', 'Maratona de programação com foco em soluções para saúde.', '2023-04-15', 'Campus Tech'),
('Webinar sobre Investimentos', 'Sessão online sobre tendências de investimento em startups.', '2023-05-10', 'Online'),
('Feira de Empreendedorismo', 'Exposição de startups e networking.', '2023-06-05', 'Centro de Convenções Rio'),
('Pitch Night', 'Noite de pitches de startups buscando investimentos.', '2023-07-18', 'Espaço Inovação'),
('Conferência de Tecnologia', 'Conferência sobre as últimas tendências em tecnologia.', '2023-08-22', 'Centro Tech SP'),
('Meetup de Empreendedores', 'Encontro informal para troca de ideias e experiências.', '2023-09-12', 'Café Empreende'),
('Workshop de Marketing Digital', 'Workshop sobre estratégias de marketing para startups.', '2023-10-03', 'Espaço Coworking'),
('Seminário de Finanças', 'Seminário sobre gestão financeira para startups.', '2023-11-15', 'Auditório Finanças'),
('Evento de Networking', 'Evento para networking entre empreendedores e investidores.', '2023-12-06', 'Hotel Business');


-- Inserção de Dados na Tabela EventParticipants

INSERT INTO EventParticipants (EventID, UserID, ParticipationType) VALUES 
(1, 1, 'Ouvinte'),
(2, 2, 'Palestrante'),
(3, 3, 'Ouvinte'),
(4, 4, 'Palestrante'),
(5, 5, 'Ouvinte'),
(6, 6, 'Palestrante'),
(7, 7, 'Ouvinte'),
(8, 8, 'Palestrante'),
(9, 9, 'Ouvinte'),
(10, 10, 'Palestrante');


-- Inserção de Dados na Tabela InvestorInterests

INSERT INTO InvestorInterests (InvestorUserID, CategoryID) VALUES 
(1, 1),
(3, 2),
(5, 3),
(7, 4),
(9, 5),
(1, 6),
(3, 7),
(5, 8),
(7, 9),
(9, 10);

Select *from Users;
Select *from ProjectCategories;
Select *from Projects;
Select *from Investments;
Select *from ProjectReviews;
Select *from Events;
Select *from EventParticipants;
Select *from InvestorInterests;

             -- Exercício de Criação de Views em Banco de Dados

-- 1 - Crie uma view chamada ‘View_UserRoles’ que exiba o nome e o papel (UserRole) de cada usuário.
CREATE VIEW View_UserRoles AS
SELECT Name, UserRole FROM Users;

SELECT *FROM View_UserRoles;
-- 2 - Desenvolva uma view ‘View_ProjectSummary’ que mostre o título do projeto, o nome do empreendedor e a quantidade total arrecadada.
CREATE VIEW View_ProjectSummary AS
SELECT p.Title, u.Name AS Entrepreneur, SUM(i.Amount) AS TotalRaised
FROM Projects p
JOIN Users u ON p.OwnerUserID = u.UserID
JOIN Investments i ON p.ProjectID = i.ProjectID
GROUP BY p.ProjectID;
SELECT *FROM View_ProjectSummary;
-- 3 - Elabore uma view ‘View_InvestmentsDetails’ para exibir detalhes dos investimentos, incluindo o título do projeto, o nome do investidor e o montante investido.
CREATE VIEW View_InvestmentsDetails AS
SELECT p.Title AS ProjectTitle, u.Name AS InvestorName, i.Amount AS InvestmentAmount
FROM Investments i
JOIN Projects p ON i.ProjectID = p.ProjectID
JOIN Users u ON i.InvestorUserID = u.UserID;
SELECT *FROM View_InvestmentsDetails;
-- 4 - Crie uma view ‘View_ActiveProjects’ que liste todos os projetos ainda ativos (considerando a data atual como referência).
CREATE VIEW View_ActiveProjects AS
SELECT *
FROM Projects
WHERE CURDATE() BETWEEN StartDate AND EndDate;
SELECT *FROM View_ActiveProjects;
-- 5 -  Desenvolva uma view ‘View_ProjectsByCategory’ que agrupe os projetos por categoria, exibindo o nome da categoria e a quantidade de projetos em cada uma.
CREATE VIEW View_ProjectsByCategory AS
SELECT pc.Name AS CategoryName, COUNT(p.ProjectID) AS ProjectCount
FROM Projects p
JOIN ProjectCategories pc ON p.CategoryID = pc.CategoryID
GROUP BY pc.CategoryID;
SELECT *FROM View_ProjectsByCategory;
-- 6 - Elabore uma view ‘View_HighRatedProjects’ que mostre os projetos com uma avaliação média superior a 4.
CREATE VIEW View_HighRatedProjects AS
SELECT p.Title, AVG(pr.Rating) AS AverageRating
FROM Projects p
JOIN ProjectReviews pr ON p.ProjectID = pr.ProjectID
GROUP BY p.ProjectID
HAVING AVG(pr.Rating) > 4;
SELECT *FROM  View_HighRatedProjects;
-- 7 - Crie uma view ‘View_EventParticipantsCount’ que conte o número de participantes para cada evento.
CREATE VIEW View_EventParticipantsCount AS
SELECT e.Title AS EventTitle, COUNT(ep.UserID) AS ParticipantCount
FROM Events e
JOIN EventParticipants ep ON e.EventID = ep.EventID
GROUP BY e.EventID;
 SELECT *FROM  View_EventParticipantsCount;
-- 8 - Desenvolva uma view ‘View_InvestorInterests’ para exibir os interesses de cada investidor, mostrando o nome do investidor e as categorias de interesse.
CREATE VIEW View_InvestorInterests AS
SELECT u.Name AS InvestorName, pc.Name AS CategoryName
FROM InvestorInterests ii
JOIN Users u ON ii.InvestorUserID = u.UserID
JOIN ProjectCategories pc ON ii.CategoryID = pc.CategoryID;

SELECT *FROM  View_InvestorInterests;
-- 9 - Elabore uma view ‘View_ProjectsWithNoInvestments’ que liste os projetos que ainda não receberam nenhum investimento.
CREATE VIEW View_ProjectsWithNoInvestments AS
SELECT p.Title
FROM Projects p
LEFT JOIN Investments i ON p.ProjectID = i.ProjectID
WHERE i.InvestmentID IS NULL;
SELECT *FROM  View_ProjectsWithNoInvestments;
-- 10 - Crie uma view ‘View_RecentInvestments’ para mostrar os investimentos realizados nos últimos 30 dias--.
CREATE VIEW View_RecentInvestments AS
SELECT *
FROM Investments
WHERE InvestmentDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT *FROM  View_RecentInvestments;

-- 11 -  Desenvolva uma view ‘View_TopInvestors’ que exiba os 5 investidores com maior montante total investido.
CREATE VIEW View_TopInvestors AS
SELECT u.Name AS InvestorName, SUM(i.Amount) AS TotalInvestment
FROM Investments i
JOIN Users u ON i.InvestorUserID = u.UserID
GROUP BY u.UserID
ORDER BY TotalInvestment DESC
LIMIT 5;CREATE VIEW View_TopInvestors AS
SELECT u.Name AS InvestorName, SUM(i.Amount) AS TotalInvestment
FROM Investments i
JOIN Users u ON i.InvestorUserID = u.UserID
GROUP BY u.UserID
ORDER BY TotalInvestment DESC
LIMIT 5;
SELECT *FROM  View_TopInvestors;
-- 12 - Elabore uma view ‘View_ProjectFeedback’ que mostre o feedback dos usuários para cada projeto, incluindo o nome do usuário, o título do projeto e os comentários.
CREATE VIEW View_ProjectFeedback AS
SELECT u.Name AS UserName, p.Title AS ProjectTitle, pr.Comments
FROM ProjectReviews pr
JOIN Users u ON pr.ReviewerUserID = u.UserID
JOIN Projects p ON pr.ProjectID = p.ProjectID;

SELECT *FROM  View_ProjectFeedback;


-- 13 - Crie uma view ‘View_FullProjectDetails’ que combine informações de projetos, investimentos, e avaliações, fornecendo uma visão completa de cada projeto.
CREATE VIEW View_FullProjectDetails AS
SELECT p.*, i.Amount AS InvestmentAmount, pr.Rating AS ProjectRating, pr.Comments AS ProjectComments
FROM Projects p
LEFT JOIN Investments i ON p.ProjectID = i.ProjectID
LEFT JOIN ProjectReviews pr ON p.ProjectID = pr.ProjectID;

SELECT *FROM  View_FullProjectDetails;
-- 14 - Desenvolva uma view ‘View_CategoryInvestments’ que mostre o total investido por categoria de projeto.
CREATE VIEW View_CategoryInvestments AS
SELECT pc.Name AS CategoryName, SUM(i.Amount) AS TotalInvestment
FROM Investments i
JOIN Projects p ON i.ProjectID = p.ProjectID
JOIN ProjectCategories pc ON p.CategoryID = pc.CategoryID
GROUP BY pc.CategoryID;
SELECT *FROM  View_CategoryInvestments;
-- 15 - Elabore uma view ‘View_UserActivity’ que indique a atividade de cada usuário, baseando-se na quantidade de investimentos feitos, projetos criados, e eventos participados.

CREATE VIEW View_UserActivity AS
SELECT u.Name AS UserName, COUNT(DISTINCT i.InvestmentID) AS InvestmentCount, COUNT(DISTINCT p.ProjectID) AS ProjectCount, COUNT(DISTINCT ep.EventID) AS EventCount
FROM Users u
LEFT JOIN Investments i ON u.UserID = i.InvestorUserID
LEFT JOIN Projects p ON u.UserID = p.OwnerUserID
LEFT JOIN EventParticipants ep ON u.UserID = ep.UserID
GROUP BY u.UserID;
SELECT *FROM  View_UserActivity;