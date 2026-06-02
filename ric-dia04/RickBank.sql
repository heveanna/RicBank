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
