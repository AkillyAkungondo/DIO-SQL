-- criacao de banco de dados e-commerce
create database ecommerce;
use ecommerce;

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    Nome VARCHAR(45),
    Apelido VARCHAR(45),
    Endereco VARCHAR(80),
    Identificacao VARCHAR(45),
    Celular INT,
    Tipo_de_Cliente VARCHAR(45),
    Conta_Bancaria INT
);

CREATE TABLE Celular (
    IdCelular INT PRIMARY KEY,
    Numero_de_Celular VARCHAR(45)
);

CREATE TABLE Cartao_Bancario (
    Numero_do_Cartao INT PRIMARY KEY,
    Nome_Completo VARCHAR(45),
    Validade DATE
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    Status_do_pedido VARCHAR(45),
    Descricao VARCHAR(45),
    cliente_idCliente INT,
    Frete FLOAT,
    FOREIGN KEY (cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Produto (
    idProduto INT PRIMARY KEY,
    Categoria VARCHAR(45),
    Descricao VARCHAR(45),
    Valor VARCHAR(45)
);

CREATE TABLE Produto_Pedido (
    Pedido_idPedido INT,
    Produto_idProduto INT,
    Quantidade INT,
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY,
    Pedido_idPedido INT,
    Pedido_Cliente_idCliente INT,
    Status VARCHAR(45),
    Codigo_de_Rastreio VARCHAR(45),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Pedido_Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY,
    Razao_Social VARCHAR(45),
    CNPJ VARCHAR(45)
);

CREATE TABLE Produto_has_Fornecedor (
    Produto_idProduto INT,
    Fornecedor_idFornecedor INT,
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor)
);

CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY,
    Local VARCHAR(45)
);

CREATE TABLE Produto_has_Estoque (
    Produto_idProduto INT,
    Estoque_idEstoque INT,
    Quantidade INT,
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
);

CREATE TABLE Terceiros_Vendedor (
    idTerceiros_Vendedor INT PRIMARY KEY,
    Razao_Social VARCHAR(45),
    Local VARCHAR(45)
);

CREATE TABLE Produto_Vendedor (
    Terceiros_Vendedor_idTerceiros_Vendedor INT,
    Produto_idProduto INT,
    Quantidade INT,
    FOREIGN KEY (Terceiros_Vendedor_idTerceiros_Vendedor) REFERENCES Terceiros_Vendedor(idTerceiros_Vendedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

------------------------------------------------------------
-- Insercao de dados
-- Clientes
INSERT INTO Cliente VALUES (1, 'Lucas', 'Ferreira', 'Rua das Flores', 'CPF123', 1, 'Físico', 123456);
INSERT INTO Cliente VALUES (2, 'Aline', 'Souza', 'Av. Brasil', 'CPF456', 2, 'Jurídico', 654321);

-- Celulares
INSERT INTO Celular VALUES (1, '99999-9999');
INSERT INTO Celular VALUES (2, '98888-8888');

-- Cartões
INSERT INTO Cartao_Bancario VALUES (123456789, 'Lucas Ferreira', '2026-10-01');
INSERT INTO Cartao_Bancario VALUES (987654321, 'Aline Souza', '2027-05-01');

-- Pedidos
INSERT INTO Pedido VALUES (1, 'Enviado', 'Pedido de eletrônicos', 1, 20.00);
INSERT INTO Pedido VALUES (2, 'Aguardando', 'Pedido de livros', 2, 15.00);

-- Produtos
INSERT INTO Produto VALUES (1, 'Eletrônicos', 'Fone Bluetooth', '150.00');
INSERT INTO Produto VALUES (2, 'Livros', 'Clean Code', '80.00');

-- Produto_Pedido
INSERT INTO Produto_Pedido VALUES (1, 1, 2);
INSERT INTO Produto_Pedido VALUES (2, 2, 1);

-- Entrega
INSERT INTO Entrega VALUES (1, 1, 1, 'Entregue', 'BR123456');
INSERT INTO Entrega VALUES (2, 2, 2, 'Aguardando', 'BR654321');

-- Fornecedores
INSERT INTO Fornecedor VALUES (1, 'Tech Supplier', '12.345.678/0001-99');
INSERT INTO Fornecedor VALUES (2, 'Editora Alpha', '98.765.432/0001-11');

-- Produto_has_Fornecedor
INSERT INTO Produto_has_Fornecedor VALUES (1, 1);
INSERT INTO Produto_has_Fornecedor VALUES (2, 2);

-- Estoques
INSERT INTO Estoque VALUES (1, 'Centro 1');
INSERT INTO Estoque VALUES (2, 'Centro 2');

-- Produto_has_Estoque
INSERT INTO Produto_has_Estoque VALUES (1, 1, 10);
INSERT INTO Produto_has_Estoque VALUES (2, 2, 5);

-- Terceiros
INSERT INTO Terceiros_Vendedor VALUES (1, 'Loja Parceira A', 'São Paulo');
INSERT INTO Terceiros_Vendedor VALUES (2, 'Loja Parceira B', 'Rio de Janeiro');

-- Produto_Vendedor
INSERT INTO Produto_Vendedor VALUES (1, 1, 4);
INSERT INTO Produto_Vendedor VALUES (2, 2, 3);

-- Produtos comprados por cada cliente
SELECT c.Nome, p.Descricao AS Produto, pp.Quantidade
FROM Cliente c
JOIN Pedido pe ON c.idCliente = pe.cliente_idCliente
JOIN Produto_Pedido pp ON pe.idPedido = pp.Pedido_idPedido
JOIN Produto p ON pp.Produto_idProduto = p.idProduto;

-- Quantidade total de produtos em estoque por categoria
SELECT pr.Categoria, SUM(pe.Quantidade) AS Total_Estoque
FROM Produto pr
JOIN Produto_has_Estoque pe ON pr.idProduto = pe.Produto_idProduto
GROUP BY pr.Categoria;

-- Clientes com pedidos com frete acima de R$18
SELECT Nome, Apelido, Frete
FROM Cliente
JOIN Pedido ON Cliente.idCliente = Pedido.cliente_idCliente
WHERE Frete > 18;
