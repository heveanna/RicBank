CREATE DATABASE RickBankPower;
GO 

USE RickBankPower;
GO

CREATE TABLE [dbo].[Cliente](
								Id				INT IDENTITY (1,1),
								Nome			VARCHAR(100)		NOT NULL, 
								CPF				VARCHAR(14)			NOT NULL,
								Email			VARCHAR(50)			NOT NULL,
								DataNascimento	DATE				NOT NULL, 
								DataCadastro	DATETIME			NOT NULL,

								CONSTRAINT PK_IdCliente PRIMARY KEY	(Id)
);
GO 

CREATE TABLE [dbo].[Agencia](
								Id				INT IDENTITY (1,1),
								Numero			VARCHAR(10)			NOT NULL,
								Nome			VARCHAR(100)		NOT NULL,
								DataCadastro	DATETIME			NOT NULL,

								CONSTRAINT PK_IdAgencia PRIMARY KEY	(Id)
);
GO

CREATE TABLE [dbo].[Conta](
							Id				INT IDENTITY (1,1),
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
							Id				INT IDENTITY (1,1),
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
									Id				INT IDENTITY (1,1),
									IdSaldo			INT					NOT NULL, 
									DataLancamento  DATETIME			NOT NULL, 
									Historico		VARCHAR(50)			NOT NULL,
									DebCre			DECIMAL(10,2)		NOT NULL,
									Valor			DECIMAL (10,2)		NOT NULL,

									CONSTRAINT PK_IdLancamento			PRIMARY KEY (Id),
									CONSTRAINT FK_IdSaldo_Lancamento	FOREIGN KEY (IdSaldo) REFERENCES Lancamento(Id)
);
GO

CREATE TABLE [dbo].[TipoLancamento](
									Id			INT,
									Descricao	VARCHAR(50) NOT NULL, 

									CONSTRAINT Id_TipoLancamento PRIMARY KEY(Id)
);

GO

INSERT INTO [dbo].[TipoLancamento] (Id, Descricao )
VALUES	
(1, 'Cartao de crédito'),
(2, 'Debito Automatico '),
(3, 'Trasferencia'),
(4, 'Internet'),
(5, 'PIX'),
(6, 'Agencia');
			
INSERT INTO [dbo].[Agencia] (Numero, Nome, DataCadastro)
VALUES 
('001', 'Agência Central São Paulo', GETDATE()),
('002', 'Agência Digital RickBank', GETDATE());

INSERT INTO [dbo].[Cliente] (Nome, CPF, Email, DataNascimento, DataCadastro)
VALUES 
('Ana Silva', '123.456.789-00', 'ana.silva@email.com', '1990-05-15', GETDATE()),
('Bruno Costa', '234.567.890-11', 'bruno.c@email.com', '1985-10-20', GETDATE()),
('Carla Souza', '345.678.901-22', 'carla.s@email.com', '1992-02-10', GETDATE()),
('Diego Lima', '456.789.012-33', 'diego.l@email.com', '1988-12-05', GETDATE()),
('Elena Dias', '567.890.123-44', 'elena.d@email.com', '1995-07-30', GETDATE());

-- para cliente impares cria 1, para cliente pares crie duas conta

INSERT INTO [dbo].[Conta] (Id, IdCliente, IdAgencia, Numero, DataCadastro )
VALUES 
(1, 1, 1, 0001, '2026-02-10 12:20:09.234'),
(2, 2, 1, 0002, '2025-01-10 15:25:09.234'),
(3, 2, 1, 0003, '2025-02-05 14:40:09.234'),
(4, 3, 2, 0004, '2024-01-03 17:23:09.234'),
(5, 4, 1, 0005, '2025-01-10 15:25:09.234'),
(6, 4, 1, 0006, '2025-01-10 15:25:09.247'),
(7, 5, 2, 0007, '2024-05-20 18:25:09.234');

-- CRIE SALDO TUDO zerado das contas 

INSERT INTO [dbo].[Saldo] (	Id, IdConta, DataSaldo, SaldoInicial, Credito, Debito)
VALUES (1, )
