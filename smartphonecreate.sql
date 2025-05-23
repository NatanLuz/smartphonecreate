-- Excluir o banco de dados

DROP DATABASE IF EXISTS SmartphoneDB;

-- criar novo banco de dados
CREATE DATABASE SmartphoneDB;
USE SmartphoneDB;

-- tabela de marcas
CREATE TABLE Marca (
    Codigo INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL
);

-- tabela de proprietários
CREATE TABLE Proprietario (
    Codigo INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Idade TINYINT NOT NULL,
    Localizacao VARCHAR(100) NOT NULL
);

-- tabela de smartphones
CREATE TABLE Smartphone (
    Codigo INT PRIMARY KEY AUTO_INCREMENT,
    Marca INT NOT NULL,
    SistemaOperacional VARCHAR(50) NOT NULL,
    Tela VARCHAR(50) NOT NULL,
    MemoriaRAM INT NOT NULL,
    ArmazenamentoInterno INT NOT NULL,
    Camera VARCHAR(50) NOT NULL,
    FOREIGN KEY (Marca) REFERENCES Marca(Codigo)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- tabela de relacionamento entre proprietários e smartphones
CREATE TABLE SmartphonesDoProprietario (
    CodigoDoProprietario INT NOT NULL,
    CodigoDoSmartphone INT NOT NULL,
    PRIMARY KEY (CodigoDoProprietario, CodigoDoSmartphone),
    FOREIGN KEY (CodigoDoProprietario) REFERENCES Proprietario(Codigo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CodigoDoSmartphone) REFERENCES Smartphone(Codigo)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- inserindo marcas
INSERT INTO Marca (Nome) VALUES
    ('Motorola'),
    ('Samsung'),
    ('Apple'),
    ('Google'),
    ('Xiaomi'),
    ('Huawei');

-- inserindo proprietários
INSERT INTO Proprietario (Nome, Idade, Localizacao) VALUES
    ('Natan', 22, 'Jardim Figueiras'),
    ('João', 25, 'São Paulo'),
    ('Maria', 30, 'Rio de Janeiro'),
    ('Pedro', 28, 'Belo Horizonte'),
    ('Ana', 24, 'Brasília');

-- inserindo smartphones
INSERT INTO Smartphone (Marca, SistemaOperacional, Tela, MemoriaRAM, ArmazenamentoInterno, Camera) VALUES
    (1, 'Android', '6.5"', 4, 128, '48MP'),
    (2, 'Android', '6.2"', 6, 64, '12MP'),
    (3, 'iOS', '6.1"', 4, 64, '12MP'),
    (4, 'Android', '6.7"', 8, 256, '108MP'),
    (5, 'Android', '6.5"', 8, 128, '108MP'),
    (6, 'Android', '6.4"', 6, 128, '50MP');

-- relacionando smartphones com seus proprietários
INSERT INTO SmartphonesDoProprietario (CodigoDoProprietario, CodigoDoSmartphone) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);
    
-- ver todos os smartphones com inforamçoes da marca 
SELECT s.codigo, m.Nome AS Marca, s.SistemaOperacional, s.Tela, s.MemoriaRAM, s.ArmazenamentoInterno, s.Camera
FROM Smartphone s
JOIN Marca m ON s.Marca = m.Codigo;

-- como ver os propietarios com os smartphones que eles tem
SELECT 
    p.Nome AS Propietario, 
    sm.Codigo AS SmartphoneID, 
    m.Nome AS Marca
FROM SmartphonesDoProprietario sp
JOIN Proprietario p ON sp.CodigoDoProprietario = p.Codigo
JOIN Smartphone sm ON sp.CodigoDoSmartphone = sm.Codigo
JOIN Marca m ON sm.Marca = m.Codigo;

-- vendo a ram e mais info dos smartphones
SELECT 
    p.Nome AS Proprietario,
    sm.Codigo AS SmartphoneID,
    m.Nome AS Marca,
    sm.SistemaOperacional,
    sm.Tela,
    sm.MemoriaRAM,
    sm.ArmazenamentoInterno,
    sm.Camera
FROM SmartphonesDoProprietario sp
JOIN Proprietario p ON sp.CodigoDoProprietario = p.Codigo
JOIN Smartphone sm ON sp.CodigoDoSmartphone = sm.Codigo
JOIN Marca m ON sm.Marca = m.Codigo;

-- Criar view para facilitar consultas entre proprietários e smartphones no sql
CREATE OR REPLACE VIEW vw_ProprietariosSmartphones AS
SELECT 
    p.Codigo AS CodigoProprietario,
    p.Nome AS Proprietario,
    p.Idade,
    p.Localizacao,
    sm.Codigo AS CodigoSmartphone,
    m.Nome AS Marca,
    sm.SistemaOperacional,
    sm.Tela,
    sm.MemoriaRAM,
    sm.ArmazenamentoInterno,
    sm.Camera
FROM Proprietario p
JOIN SmartphonesDoProprietario sp ON p.Codigo = sp.CodigoDoProprietario
JOIN Smartphone sm ON sp.CodigoDoSmartphone = sm.Codigo
JOIN Marca m ON sm.Marca = m.Codigo;


-- Procedure para inserir novo smartphone e relacionar a um proprietário
DELIMITER $$

CREATE PROCEDURE InserirSmartphone(
    IN p_CodigoProprietario INT,
    IN p_Marca INT,
    IN p_SistemaOperacional VARCHAR(50),
    IN p_Tela VARCHAR(50),
    IN p_MemoriaRAM INT,
    IN p_ArmazenamentoInterno INT,
    IN p_Camera VARCHAR(50)
)
BEGIN
    -- Inserir smartphone
    INSERT INTO Smartphone (Marca, SistemaOperacional, Tela, MemoriaRAM, ArmazenamentoInterno, Camera)
    VALUES (p_Marca, p_SistemaOperacional, p_Tela, p_MemoriaRAM, p_ArmazenamentoInterno, p_Camera);
    
    -- Pegar o último ID inserido do smartphone
    SET @ultimoSmartphone = LAST_INSERT_ID();
    
    -- Relacionar o smartphone com o proprietário
    INSERT INTO SmartphonesDoProprietario (CodigoDoProprietario, CodigoDoSmartphone)
    VALUES (p_CodigoProprietario, @ultimoSmartphone);
END$$

DELIMITER ;

-- teste pode variar n as info para poder obter outras consultas no sql

SELECT 
    p.Nome AS Proprietario,
    sm.Codigo AS SmartphoneID,
    m.Nome AS Marca,
    sm.SistemaOperacional,
    sm.Tela,
    sm.MemoriaRAM,
    sm.ArmazenamentoInterno,
    sm.Camera
FROM SmartphonesDoProprietario sp
JOIN Proprietario p ON sp.CodigoDoProprietario = p.Codigo
JOIN Smartphone sm ON sp.CodigoDoSmartphone = sm.Codigo
JOIN Marca m ON sm.Marca = m.Codigo
WHERE p.Codigo = 1;

