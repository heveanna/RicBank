USE RickBankPower;

-- para cliente impares cria 1, para cliente pares crie duas conta

GO

INSERT INTO [dbo].[Conta] (IdCliente, IdAgencia, Numero, DataCadastro )
	VALUES	(1, 1, 10001, GETDATE()),
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
VALUES  (2, GETDATE(), 0, 0, 0),
		(3, GETDATE(), 0, 0, 0),
		(4, GETDATE(), 0, 0, 0),
		(5, GETDATE(), 0, 0, 0),
		(6, GETDATE(), 0, 0, 0),
		(7, GETDATE(), 0, 0, 0),
		(8, GETDATE(), 0, 0, 0),
		(9, GETDATE(), 0, 0, 0);

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
VALUES (2, GETDATE(), 'Internet residencial', 'D', 99.90);

UPDATE [dbo].[Saldo]	
	SET Debito = Debito + 99.90
	WHERE Id = 2;

--7.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (2, GETDATE(), 'Venda produto', 'C', 450.00);

UPDATE [dbo].[Saldo]
	SET Credito = Credito + 450.00
	WHERE Id = 2;

--8.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (3, GETDATE(), 'Transferencia recebida', 'C', 700.00);

UPDATE [dbo].[Saldo]	
	SET Credito = Credito + 700.00
	WHERE Id = 3;

-- 9.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (3, GETDATE(), 'Combustivel', 'D', 200.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 200.00
	WHERE Id = 3;

-- 10.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (3, GETDATE(), 'Farmacia', 'D', 76.45);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 76.45
	WHERE Id = 3;

-- 11.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (4, GETDATE(), 'Academia', 'D', 89.90);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 89.90 
	WHERE Id = 4;

-- 12.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES (4, GETDATE(), 'Freelance desenvolvimento', 'C', 1200.00);

UPDATE [dbo].[Saldo]
	SET Credito = Credito + 1200.00
	WHERE Id = 4;

-- 13. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (4, GETDATE(), 'Pagamento cartao', 'D', 680.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 680.00
	WHERE Id = 4;

-- 14. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (5, GETDATE(), 'Restaurante', 'D', 54.80);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 54.80
	WHERE Id = 5;

-- 15.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (5, GETDATE(), 'Cinema', 'D', 42.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 42.00
	WHERE Id = 5;

-- 16.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (5, GETDATE(), 'Presente aniversario', 'D', 130.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 130.00
	WHERE Id = 5;

-- 17.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (6, GETDATE(), 'Bonus empresa', 'C', 900.00);

UPDATE [dbo].[Saldo]
	SET Credito = Credito + 900.00
	WHERE Id = 6;

-- 18. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (7, GETDATE(), 'Manutencao notebook', 'D', 250.00);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 250.00 
	WHERE Id = 7;

-- 19.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (8, GETDATE(), 'Curso online', 'D', 59.90);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 59.90 
	WHERE Id = 8;

-- 20.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (9, GETDATE(), 'Venda acessorios', 'C', 320.00);

UPDATE [dbo].[Saldo] 
	SET Credito = Credito + 320.00
	WHERE Id = 9;

-- 21.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (5, GETDATE(), 'Uber', 'D', 27.50);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 27.50
	WHERE Id = 5;

-- 22.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (6, GETDATE(), 'Spotify premium', 'D', 21.90);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 21.90
	WHERE Id = 6;

-- 23.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (7, GETDATE(), 'Netflix', 'D', 39.90);

UPDATE [dbo].[Saldo]
	SET Debito = Debito + 39.90
	WHERE Id = 7;

-- 24.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (6, GETDATE(), 'Dividendos investimento', 'C', 180.75);

UPDATE [dbo].[Saldo] 
	SET Credito = Credito + 180.75
	WHERE Id = 6;

-- 25.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (4, GETDATE(), 'Material faculdade', 'D', 210.40);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 210.40
	WHERE Id = 4;

-- 26.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (4, GETDATE(), 'Compra teclado mecanico', 'D', 340.00);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 340.00
	WHERE Id = 4;

-- 27. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (2, GETDATE(), 'Reembolso empresa', 'C', 150.00);

UPDATE [dbo].[Saldo] 
SET Credito = Credito + 150.00
WHERE Id = 2;

-- 28. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (9, GETDATE(), 'Lavagem carro', 'D', 45.00);

UPDATE [dbo].[Saldo] 
	SET Debito = Debito + 45.00
	WHERE Id = 9;

-- 29.

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
	VALUES (4, GETDATE(), 'Servico prestado', 'C', 800.00);

UPDATE [dbo].[Saldo] 
	SET Credito = Credito + 880.00
	WHERE Id = 4;

-- 30. 

INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
VALUES (5, GETDATE(), 'Mercado', 'C', 800.00);

UPDATE [dbo].[Saldo] 
	SET Credito = Credito + 800.00
	WHERE Id = 15;

SELECT *
	FROM [dbo].[Lancamento] WITH(NOLOCK);
