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

IF EXISTS(SELECT 1 FROM [dbo].[sysobjects] WHERE Id = OBJECT_Id(N'[dbo].[TRG_ATUALIZASALDO]') AND TYPE  = 'TR')
	BEGIN 
		DROP TRIGGER [dbo].[TRG_AtualizaSaldo]
	END

	GO
CREATE TRIGGER [dbo].[TRG_AtualizaSaldo]
	ON [dbo].[Lancamento]
	FOR INSERT, DELETE, UPDATE

	AS 
		/*
		Documentação: 
		Arquivo Nome:
		Objetivo: 
		Autor:
		Data Criação:
		Exemplo: 
		*/
-- checando tabela deleted
	BEGIN
		IF EXISTS (SELECT 1 FROM deleted) 
			BEGIN 
				UPDATE SD 
					SET Credito =	(CASE WHEN d.DebCre = 'C' THEN Credito - d.Valor ELSE Credito END),
						Debito =	(CASE WHEN d.DebCre = 'D' THEN Debito  - d.Valor ELSE Debito END)

					FROM [dbo].[Saldo] AS SD 
						INNER JOIN Deleted as d 
							ON SD.Id = d.IdSaldo
			END
	
-- checando tabela inserted 
		IF EXISTS (SELECT 1 FROM inserted)
			BEGIN
				UPDATE Saldo
					SET Credito = (CASE WHEN i.DebCre = 'C' THEN Credito - i.Valor ELSE Credito END),
						Debito =  (CASE WHEN i.DebCre = 'D' THEN Debito - i.Valor ELSE Debito END)

					FROM [dbo].[Saldo] as sd
						INNER JOIN inserted as i
							ON sd.Id = i.IdSaldo
			END
	END

SELECT * FROM Saldo;
-- 1060.75 1350.40 

INSERT INTO [dbo].[Saldo] (Id, IdConta, DataSaldo, Credito, Debito)
VALUES (14, 20, GETDATE(), 0.00, 1060.75, 1350.40)


-- dia 06

IF EXISTS (SELECT 1 FROM [dbo].[sysobjects] WHERE Id = OBJECT_ID (N'[dbo].[SP_InsLancamento]')
		AND OBJECTPROPERTY(Id, N'IsProcedure') = 1)
	
	BEGIN
        DROP PROCEDURE [dbo].[SP_InsLancamento]
    END
GO

CREATE PROCEDURE [dbo].[SP_InsLancamento]
	@IdSaldo			INT,
	@DataLancamento		DATETIME = GETDATE,
	@Historico			VARCHAR(200),
	@DebCre				CHAR(1),
	@Valor				DECIMAL(10, 2)
	
	AS 
	/*
		Documentação: 
		Arquivo Nome: RickBankDia06.sql
		Objetivo: 
		Autor:
		Data Criação:
		Exemplo: 
	

	BEGIN TRANSACTION 
		DECLARE @RET INT, @DAT_INI DATETIME = GETDATE()
		EXEC @RET = [dbo].[SP.InsLancamento] 
			@IdSaldo = 1, 
			@DataLancamento = @DAT_INI,
			@Historico = 'TESTE',
			@DebCre = 'C',
			@Valor = 500

		SELECT @RET AS RETORNO,
			DATEDIFF (MILLISECOND, @DAT_INI, GETDATE()) AS TEMPO 

		SELECT * FROM [dbo].[Lancamento]

		SELECT TOP 1 * FROM [dbo].[Lancamento] WITH(NOLOCK)
			ORDER BY Id DESC
		ROLLBACK TRANSACTION 
		END 
	*/

	BEGIN 
		-- Inclusão Registro 
		DECLARE @ERRO	INT,
				@Id		INT

		INSERT INTO [dbo].[Lancamento] (IdSaldo, DataLancamento, Historico, DebCre, Valor)
		VALUES (@IdSaldo, @DataLancamento, @Historico, @DebCre, @Valor);

		SELECT	@ERRO = @@ERROR,
				@Id    = SCOPE_IDENTITY();

		IF @ERRO <> 0
			BEGIN
				RETURN -1
			END

		RETURN @Id
	END

GO

		BEGIN TRANSACTION 

			DECLARE @RET INT,
					@DAT_INI DATETIME = GETDATE()

			SELECT * FROM Saldo WHERE Id = 7
		
			EXEC	@RET = [dbo].[SP_InsLancamento] 
						@IdSaldo = 7, 
						@DataLancamento = @DAT_INI,
						@Historico = 'TESTE',
						@DebCre = 'C',
						@Valor = 10.50

			SELECT @RET AS Returno,
				DATEDIFF (MILLISECOND, @DAT_INI, GETDATE()) AS TEMPO;

			SELECT TOP 1 * FROM [dbo].[Lancamento] WITH(NOLOCK)
				ORDER BY Id DESC
		
			SELECT * FROM Saldo WHERE Id = 7

		ROLLBACK TRANSACTION 

-- atualização do lançamento e exclusão do lançamento 