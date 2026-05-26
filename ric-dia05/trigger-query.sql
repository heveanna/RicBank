USE RickBankPower;

WITH Lancamento_TEMP AS (
	SELECT IdSaldo,
		(CASE WHEN DebCre = 'C' THEN Valor 
			ELSE (Valor * -1)
			END) AS ValorMovimento 
		FROM [dbo].[Lancamento] WITH(NOLOCK)
),

RESUMO AS (
			SELECT	IdSaldo,
					SUM (ValorMovimento) AS ValorTotal 
				FROM Lancamento_TEMP
				GROUP BY IdSaldo
			)

SELECT	re.IdSaldo,
		re.ValorTotal,
		sd.SaldoInicial, 
		sd.Debito,
		sd.Credito,
		(sd.Credito - sd.Debito - re.ValorTotal) AS DIF
	FROM [dbo].[Saldo] as sd WITH(NOLOCK)
		INNER JOIN RESUMO as re
			ON sd.Id = re.IdSaldo;

-- exercicio casa ZERAr saldo 

IF EXISTS(SELECT 1 FROM [dbo].[sysobjects]
			WHERE Id = OBJECT_Id(N'[dbo].[TRG_ATUALIZASALDO]') 
				AND TYPE  = 'TR')
	BEGIN 
		DROP TRIGGER [dbo].[TRG_ATUALIZASALDO]
	END

CREATE TRIGGER [dbo].[TRG_ATUALIZASALDO]
	ON [dbo].[Lancamento]
	FOR INSERT, DELETE, UPDATE

	AS 
	BEGIN
/*
Documentação: 
Arquivo Nome:
Objetivo: 
Autor:
Data Criação:
Exemplo: 
*/
-- checando tabela delete
--	IF EXISTS (SELECT 1 FROM deleted) 
	--	BEGIN 
UPDATE SD 
	SET Credito =	(CASE WHEN d.DebCre = 'C' THEN Credito - d.Valor ELSE Credito END),
		Debito =	(CASE WHEN d.DebCre = 'D' THEN Debito  - d.Valor ELSE Debito END)
			FROM [dbo].[Saldo] AS SD 
				INNER JOIN Deleted as d 
					ON SD.Id = d.IdSaldo
--	END
	
-- checando tabela inserted 

UPDATE sd 
	SET Credito = (CASE WHEN i.DebCre = 'C' THEN Credito - i.Valor ELSE Credito END),
		Debito =  (CASE WHEN i.DebCre = 'D' THEN Debito - i.Valor ELSE Debito END)
			FROM [dbo].[Saldo] as sd
				INNER JOIN Inserted as i
					ON sd.Id = i.IdSaldo

SELECT * FROM Saldo;

INSERT INTO [dbo].[Saldo] (Id, IdConta, DataSaldo, Credito, Debito)
VALUES (14, 20, GETDATE(), 0.00, 1060.75, 1350.40)

-- 1060.75 1350.40 