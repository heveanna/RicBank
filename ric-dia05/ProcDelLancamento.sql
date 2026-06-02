USE RickBankPower;

GO 

IF EXISTS (SELECT 1 FROM [dbo].[sysobjects]
				WHERE Id = OBJECT_ID(N'SP_DelLancamento')
					AND OBJECTPROPERTY(Id, N'IsProcedure') = 7)
			BEGIN 
				DROP PROCEDURE [dbo].[SP_DelLancamento]
			END 
GO

CREATE PROCEDURE [dbo].[SP_DelLancamento]
	@Id INT 
AS 
	/*
		Arquivo Fonte:	ProcDelLancamento.sql
		Objetivo:		Deletar Lançamento
		Autor:			Anna Hevellyn 
		Data Criação:	02/06/2026
		Exemplo:		BEGIN TRANSACTION 
						IF EXISTS(SELECT 1 FROM [dbo].[sysobjects]
							WHERE Id = OBJECT_ID(N'SP_DelLancamento')
								AND OBJECTPROPROPERITY(Id, N'IsProcedure') = 7)
						BEGIN 
							DROP PROCEDURE [dbo].[SP_DelLancamento]
						END
				
	*/
BEGIN 
	DECLARE @Erro	INT 

	IF NOT EXISTS (SELECT 1 FROM [dbo].[Lancamento] WITH(NOLOCK) WHERE Id = @Id)
		BEGIN
			RETURN -1
		END 
	
	DELETE [dbo].[Lancamento]
		WHERE Id = @Id
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
					SELECT * FROM [dbo].[Lancamento] WHERE Id = 1
					EXEC @RET = [dbo].[SP_DelLancamento] @Id = 1
					SELECT  @RET AS Retorno,
							DATEDIFF(MILLISECOND, @DAT_INI, GETDATE()) AS 'Tempo(ms)'
					SELECT TOP 1 * FROM [dbo].[Lancamento] WITH(NOLOCK)
						WHERE Id = 1 
						ORDER BY DataLancamento DESC
ROLLBACK TRANSACTION