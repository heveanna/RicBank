CREATE DATABASE RickBankPower;
GO

USE RickBankPower;
GO

CREATE TABLE [dbo].[Cliente](
								Id				INT					IDENTITY (1,1),
								Nome			VARCHAR(100)		NOT NULL, 
								Email			VARCHAR(255)		NOT NULL,
								CPF				BIGINT				NOT NULL,
								DataNascimento	DATE				NOT NULL, 
								DataCadastro	DATETIME			NOT NULL,

								CONSTRAINT PK_IdCliente		PRIMARY KEY	(Id),
								CONSTRAINT UQ_CPF_Cliente	UNIQUE (CPF)
							);
GO 

CREATE TABLE [dbo].[Agencia](
								Id				INT					IDENTITY (1,1),
								Numero			INT					NOT NULL,
								Nome			VARCHAR(100)		NOT NULL,
								DataCadastro	DATETIME			NOT NULL,

								CONSTRAINT PK_IdAgencia PRIMARY KEY	(Id),
								CONSTRAINT UQ_Numero	UNIQUE		(Numero)
);
GO

CREATE TABLE [dbo].[Conta](
							Id				INT						IDENTITY (1,1),
							IdCliente		INT						NOT NULL, 
							IdAgencia		INT						NOT NULL, 
							Numero			VARCHAR(10)				NOT NULL,
							DataCadastro	DATETIME				NOT NULL,

							CONSTRAINT PK_IdConta			PRIMARY KEY	(Id),
							CONSTRAINT FK_IdCliente_Conta	FOREIGN KEY (IdCliente) REFERENCES Cliente(Id),
							CONSTRAINT FK_IdAgencia_Conta	FOREIGN KEY (IdAgencia) REFERENCES Agencia(Id)
);
GO

CREATE TABLE [dbo].[Saldo](
							Id				INT						IDENTITY (1,1),
							IdConta			INT						NOT NULL, 
							DataSaldo		DATETIME				NOT NULL, 
							SaldoInicial	DECIMAL(10,2)			NOT NULL,
							Credito			DECIMAL(10,2)			NOT NULL,
							Debito			DECIMAL(10,2)			NOT NULL,

							CONSTRAINT PK_IdSaldo		PRIMARY KEY (Id),
							CONSTRAINT FK_IdConta_Saldo FOREIGN KEY	(IdConta) REFERENCES Conta(Id)
						  );
GO

CREATE TABLE [dbo].[Lancamento](
									Id				INT					IDENTITY (1,1),
									IdSaldo			INT					NOT NULL, 
									DataLancamento  DATETIME			NOT NULL, 
									Historico		VARCHAR(200)			NOT NULL,
									DebCre			CHAR(1)				NOT NULL,
									Valor			DECIMAL (10,2)		NOT NULL,

									CONSTRAINT PK_IdLancamento			PRIMARY KEY (Id),
									CONSTRAINT FK_IdSaldo_Lancamento	FOREIGN KEY (IdSaldo) REFERENCES Saldo (Id)
								);
GO

CREATE TABLE [dbo].[TipoLancamento](
									Id			INT,
									Nome	VARCHAR(100) NOT NULL, 

									CONSTRAINT Id_TipoLancamento PRIMARY KEY(Id)
);

GO

INSERT INTO [dbo].[TipoLancamento] (Id, Nome)
	VALUES	(1, 'Cartao de crédito'),
			(2, 'Debito Automatico '),
			(3, 'Trasferencia'),
			(4, 'Internet'),
			(5, 'PIX'),
			(6, 'Agencia');

GO
			
INSERT INTO [dbo].[Agencia] (Numero, Nome, DataCadastro)
VALUES 
('101', 'Agência Central São Paulo', GETDATE()),
('102', 'Agência Digital RickBank', GETDATE());

SELECT *
	FROM [dbo].[Agencia] WITH(NOLOCK);

GO

INSERT INTO [dbo].[Cliente] (Nome, CPF, Email, DataNascimento, DataCadastro)
	VALUES	('Ana Silva',	'12345678900',		'ana.silva@email.com',		'1990-05-15', GETDATE()),
			('Bruno Costa', '23456789011',		'bruno.cararas@email.com',	'1985-10-20', GETDATE()),
			('Carla Souza', '34567890122',		'carla.santos@email.com',	'1992-02-10', GETDATE()),
			('Diego Lima',	'45678901233',		'diego.l@email.com',		'1988-12-05', GETDATE()),
			('Elena Dias',	'56789012344',		'elena.d@email.com',		'1995-07-30', GETDATE());

SELECT * 
	FROM [dbo].[Cliente] WITH(NOLOCK);

-- para cliente impares cria 1, para cliente pares crie duas conta

GO

INSERT INTO [dbo].[Conta] ( IdCliente, IdAgencia, Numero, DataCadastro )
	VALUES	(6, 1, 10001, GETDATE()),
			(2, 2, 10001, GETDATE()),
			(2, 1, 10002, GETDATE()),
			(3, 2, 10002, GETDATE()),
			(5, 1, 10003, GETDATE()),
			(5, 2, 10003, GETDATE()),
			(4, 1, 10004, GETDATE()),
			(4, 2, 10004, GETDATE());

SELECT *
	FROM [dbo].[Conta] WITH(NOLOCK)
	ORDER BY Numero;

-- CRIE SALDO TUDO zerado das contas 
GO

INSERT INTO [dbo].[Saldo] (IdConta, DataSaldo, SaldoInicial, Credito, Debito)
VALUES  (13, GETDATE(), 0, 0, 0),
		(14, GETDATE(), 0, 0, 0),
		(15, GETDATE(), 0, 0, 0),
		(16, GETDATE(), 0, 0, 0),
		(17, GETDATE(), 0, 0, 0),
		(18, GETDATE(), 0, 0, 0),
		(19, GETDATE(), 0, 0, 0),
		(20, GETDATE(), 0, 0, 0);

GO;

SELECT *
	FROM [dbo].[Saldo] WITH(NOLOCK);

-- criar script que incluam lançamento e atualizem saldo (30)
-- Deb: 1     |   Cre: 2 
GO

-- 1
INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES (7, GETDATE(), 'Pagamento de conta', 'D', 150.75);
GO

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 150.75
	WHERE Id = 7;

-- 2.
GO

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES (8, GETDATE(), 'Pagamento aluguel', 'D', 950.00);
GO

UPDATE [dbo].[Saldo]	
	SET Debito = Debito + 950.00
	WHERE Id = 8;

-- 3.
GO

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES (8, GETDATE(), 'Salario Mensal', 'D', 3550.00);

UPDATE [dbo].[Saldo]	
	SET Debito = Debito + 3550.00
	WHERE Id = 8;

-- 4. 
GO 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES (9, GETDATE(), 'Conta de água', 'C', 185.30);

UPDATE [dbo].[Saldo]	
	SET Credito = Credito + 185.30
	WHERE Id = 9;

-- 5.
GO

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES  (9, GETDATE(), 'Conta de luz', 'C', 142.90);

UPDATE [dbo].[Saldo]
	SET Credito = Credito + 142.90
	WHERE Id = 9;

-- 6. 
GO

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES (10, GETDATE(), 'Internet residencial', 'D', 99.90);

UPDATE [dbo].[Saldo]	
	SET Debito = Debito + 99.90
	WHERE Id = 10;

--7.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (10, GETDATE(), 'Venda produto', 'C', 450.00);

UPDATE [dbo].[Saldo]
	SET Credito = Credito + 450.00
	WHERE Id = 10;

--8.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (10, GETDATE(), 'Transferencia recebida', 'C', 700.00);

UPDATE [dbo].[Saldo]	
	SET Credito = Credito + 700.00
	WHERE Id = 10;

-- 9.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (10, GETDATE(), 'Combustivel', 'D', 200.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 200.00
	WHERE Id = 10;

-- 10.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (11, GETDATE(), 'Farmacia', 'D', 76.45);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 76.45
	WHERE Id = 11;

-- 11.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (11, GETDATE(), 'Academia', 'D', 89.90);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 89.90 
	WHERE Id = 11;

-- 12.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES (11, GETDATE(), 'Freelance desenvolvimento', 'C', 1200.00);

UPDATE [dbo].[Saldo]
	SET Credito = Credito + 1200.00
	WHERE Id = 11;

-- 13. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (11, GETDATE(), 'Pagamento cartao', 'D', 680.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 680.00
	WHERE Id = 11;

-- 14. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (12, GETDATE(), 'Restaurante', 'D', 54.80);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 54.80
	WHERE Id = 12;

-- 15.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (12, GETDATE(), 'Cinema', 'D', 42.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 42.00
	WHERE Id = 12;

-- 16.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (12, GETDATE(), 'Presente aniversario', 'D', 130.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 130.00
	WHERE Id = 12;

-- 17.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (8, GETDATE(), 'Bonus empresa', 'C', 900.00);

UPDATE [dbo].[Saldo]
	SET Credito = Credito + 900.00
	WHERE Id = 8;

-- 18. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (12, GETDATE(), 'Manutencao notebook', 'D', 250.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 250.00 
	WHERE Id = 12;

-- 19.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (13, GETDATE(), 'Curso online', 'D', 59.90);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 59.90 
	WHERE Id = 13;

-- 20.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (13, GETDATE(), 'Venda acessorios', 'C', 320.00);

UPDATE [dbo].[Saldo] 
	SET Credito = Credito + 320.00
	WHERE Id = 13;

-- 21.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (13, GETDATE(), 'Uber', 'D', 27.50);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 27.50
	WHERE Id = 13;

-- 22.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (12, GETDATE(), 'Spotify premium', 'D', 21.90);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 21.90
	WHERE Id = 12;

-- 23.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (9, GETDATE(), 'Netflix', 'D', 39.90);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 39.90
	WHERE Id = 9;

-- 24.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (14, GETDATE(), 'Dividendos investimento', 'C', 180.75);

UPDATE [dbo].[Saldo] 
	SET Credito = Credito + 180.75
	WHERE Id = 14;

-- 25.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (14, GETDATE(), 'Material faculdade', 'D', 210.40);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 210.40
	WHERE Id = 14;

-- 26.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (14, GETDATE(), 'Compra teclado mecanico', 'D', 340.00);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 340.00
	WHERE Id = 14;

-- 27. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (12, GETDATE(), 'Reembolso empresa', 'C', 150.00);

UPDATE [dbo].[Saldo] 
SET Credito = Credito + 150.00
WHERE Id = 12;

-- 28. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (10, GETDATE(), 'Lavagem carro', 'D', 45.00);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 45.00
	WHERE Id = 10;

-- 29.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (14, GETDATE(), 'Servico prestado', 'C', 800.00);

UPDATE [dbo].[Saldo] 
	SET Credito = Credito + 880.00
	WHERE Id = 14;

-- 30. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES (14, GETDATE(), 'Mercado', 'C', 800.00);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 800.00
	WHERE Id = 14;

SELECT *
	FROM [dbo].[Lancamento] WITH(NOLOCK);
