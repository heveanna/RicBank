USE RickBankPower;
GO

-- criar uma procedure de atualizar lançamento 
-- exclusão de lançamento 

GO 

IF EXISTS (SELECT 1 FROM [dbo].[sysobjects]
				WHERE Id = OBJECT_ID(N'SP_AtulLancamento')
					AND OBJECTPROPERTY(Id, N'IsProcedure') = 7)
			BEGIN
				DROP PROCEDURE [dbo].[SP_AtuLancamento]
			END
GO
	CREATE PROCEDURE [dbo].[SP_AtuLancamento]
		@Id					INT,
		@IdSaldo			INT,
		@DataLancamento		DATETIME,
		@Historico			VARCHAR(200),
		@DebCre				CHAR(1),
		@Valor				DECIMAL(10,2)
AS
/*
	Documentação: 
	Arquivo Nome: RickBankDia06.sql
	Objetivo: Atualizar os lançamentos
	Autor: Anna Hevellyn 
	Data Criação: 02/06/2026
	Exemplo: BEGIN TRANSACTION 
			 DECLARE @RET INT,
					 @DAT_INI  DATETIME = GETDATE()
			 EXEC @RET = [dbo].[SP_AtuLancamento]	@Id					= 1,
													@IdSaldo			= 1,
													@DataLancamento		= @DAT_INI,
													@Historico			= 'Teste Update',
													@DebCre				= 'C',
													@Valor				= 750
			SELECT	@RET AS Retorno,
					DATEDIFF (MILLISECOND, @DAT_INI, GETDATE() AS 'Tempo(ms)'
			SELECT TOP 1 * FROM [dbo].[Lancamento] WITH(NOLOCK)
				WHERE Id = 1
				ORDER BY DataLancamento DESC
			ROLLBACK TRANSACTION 

Retornos: - 1 - Falha na execução 
		  Retorno positivo se refere ao ID do Lançamento 
*/
BEGIN 
	DECLARE @Erro	INT

	IF NOT EXISTS (SELECT 1 FROM [dbo].[Lancamento] WITH(NOLOCK) WHERE Id = @Id)
		BEGIN 
			RETURN -1 
		END

	UPDATE [dbo].[Lancamento]
		SET IdSaldo				= @IdSaldo,
			DataLancamento		= @DataLancamento, 
			Historico			= @Historico,
			DebCre				= @DebCre,
			Valor				= @Valor 
		WHERE Id = @Id;
	SELECT @Erro = @@ERROR
	IF @Erro <> 0
		BEGIN 
			RETURN -1
		END 
	RETURN @Id
END 

BEGIN TRANSACTION 
					DECLARE @RET INT,
							@DAT_INI DATETIME = GETDATE()
					EXEC @RET = [dbo].[SP_AtuLancamento]	@Id					= 7,
															@IdSaldo			= 7,
															@DataLancamento		= @DAT_INI,
															@Historico			= 'Teste Update',
															@DebCre				= 'C',
															@Valor				= 750
					SELECT	@RET AS Retorno,
							DATEDIFF(MILLISECOND, @DAT_INI, GETDATE()) AS 'Tempo(ms)'
					SELECT TOP 1 * FROM [dbo].[Lancamento] WITH(NOLOCK) 
						WHERE Id = 1
						ORDER BY DataLancamento DESC
ROLLBACK TRANSACTION 