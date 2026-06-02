USE RickBankPower;

-- criar uma procedure de atualizar lançamento e 

UPDATE 





-- exclusão de lançamento 

GO 

IF EXISTS (SELECT 1 FROM [dbo].[sysobjects]
				WHERE Id = OBJECT_ID(N'SP_DelLancamento')
					AND OBJECTPROPERTY(Id, N'IsProcedure') = 1)
			BEGIN
				DROP PROCEDURE [dbo].[SP_InsDelLancamento]
			END
BEGIN 
	CREATE PROCEDURE [dbo].[SP_DelLancamento]
		@IdLancamento	INT
/*
	Documentação: 
	Arquivo Nome: RickBankDia06.sql
	Objetivo: 
	Autor: Anna Hevellyn 
	Data Criação:
	Exemplo: 
*/
END

GO

	DECLARE @ERRO	INT,
			@Id		INT 

	SELECT @ERRO	= @@ERROR,
			@Id		= SCOPE_IDENTITY();

	IF	@ERRO <> 0 
		BEGIN 
			RETURN -1
		END 

		RETURN @Id
END 
