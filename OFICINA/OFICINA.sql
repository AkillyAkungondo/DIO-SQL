create database oficina;
use oficina;

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(45),
    Apelido VARCHAR(45),
    Endereco VARCHAR(45),
    Celular INT,
    Viatura VARCHAR(45)
);

CREATE TABLE Celular (
    idCelular INT PRIMARY KEY,
    Numero_de_Celular VARCHAR(45)
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    Servico VARCHAR(45),
    Descricao VARCHAR(100),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Ordem_de_Servico (
    idOrdem_de_Servico INT PRIMARY KEY,
    Data_de_Emissao DATE,
    Data_de_Entrega DATE,
    Valor FLOAT,
    Status VARCHAR(45),
    Pedido_idPedido INT,
    Pedido_Cliente_idCliente INT,
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Pedido_Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Tabela_de_Servicos (
    idTabela_de_Servicos INT PRIMARY KEY,
    Tipo_de_Servico VARCHAR(45),
    Valor FLOAT
);

CREATE TABLE Tabela_de_Servicos_Ordem_de_Servico (
    Tabela_de_Servicos_idTabela_de_Servicos INT,
    Ordem_de_Servico_idOrdem_de_Servico INT,
    Ordem_de_Servico_Pedido_idPedido INT,
    Ordem_de_Servico_Pedido_Cliente_idCliente INT,
    FOREIGN KEY (Tabela_de_Servicos_idTabela_de_Servicos) REFERENCES Tabela_de_Servicos(idTabela_de_Servicos),
    FOREIGN KEY (Ordem_de_Servico_idOrdem_de_Servico) REFERENCES Ordem_de_Servico(idOrdem_de_Servico)
);

CREATE TABLE Mecanico (
    idMecanico INT PRIMARY KEY,
    Nome VARCHAR(45),
    Apelido VARCHAR(45),
    Endereco VARCHAR(45),
    Celular INT,
    Especialidade VARCHAR(45),
    Equipe VARCHAR(45)
);

CREATE TABLE Equipe_Responsavel (
    idEquipe_Responsavel INT PRIMARY KEY,
    Nome_da_Equipe VARCHAR(45),
    Especialidade VARCHAR(45),
    Mecanico_idMecanico INT,
    Pedido_idPedido INT,
    FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanico(idMecanico),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);
-----------------------------------------------------------------------
-- Insercao de dados
-- Inserindo Clientes
INSERT INTO Cliente VALUES (1, 'João', 'Silva', 'Rua A', 1, 'ABC1234');
INSERT INTO Cliente VALUES (2, 'Maria', 'Souza', 'Rua B', 2, 'XYZ5678');

-- Inserindo Celulares
INSERT INTO Celular VALUES (1, '99999-1111');
INSERT INTO Celular VALUES (2, '98888-2222');

-- Inserindo Pedidos
INSERT INTO Pedido VALUES (1, 'Troca de óleo', 'Cliente solicitou troca de óleo', 1);
INSERT INTO Pedido VALUES (2, 'Revisão completa', 'Verificação geral', 2);

-- Inserindo Ordens de Serviço
INSERT INTO Ordem_de_Servico VALUES (1, '2025-04-01', '2025-04-03', 150.00, 'Concluído', 1, 1);
INSERT INTO Ordem_de_Servico VALUES (2, '2025-04-05', '2025-04-10', 400.00, 'Em andamento', 2, 2);

-- Inserindo Serviços
INSERT INTO Tabela_de_Servicos VALUES (1, 'Troca de óleo', 100.00);
INSERT INTO Tabela_de_Servicos VALUES (2, 'Revisão completa', 300.00);

-- Associando serviços às ordens
INSERT INTO Tabela_de_Servicos_Ordem_de_Servico VALUES (1, 1, 1, 1);
INSERT INTO Tabela_de_Servicos_Ordem_de_Servico VALUES (2, 2, 2, 2);

-- Inserindo Mecânicos
INSERT INTO Mecanico VALUES (1, 'Carlos', 'Mendes', 'Rua C', 1, 'Motor', 'Equipe Alfa');
INSERT INTO Mecanico VALUES (2, 'Pedro', 'Oliveira', 'Rua D', 2, 'Freios', 'Equipe Beta');

-- Equipes responsáveis
INSERT INTO Equipe_Responsavel VALUES (1, 'Equipe Alfa', 'Motor', 1, 1);
INSERT INTO Equipe_Responsavel VALUES (2, 'Equipe Beta', 'Freios', 2, 2);

-- Lista de ordens de serviço com nome do cliente e status
SELECT o.idOrdem_de_Servico, c.Nome, o.Status
FROM Ordem_de_Servico o
JOIN Cliente c ON o.Pedido_Cliente_idCliente = c.idCliente;

--  Ordens de serviço com valor maior que 200, ordenadas por data de entrega
SELECT * 
FROM Ordem_de_Servico
WHERE Valor > 200
ORDER BY Data_de_Entrega ASC;

-- Total gasto por cliente
SELECT c.Nome, SUM(o.Valor) AS Total_Gasto
FROM Cliente c
JOIN Ordem_de_Servico o ON o.Pedido_Cliente_idCliente = c.idCliente
GROUP BY c.Nome;



