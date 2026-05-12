USE RicBank;

-- Quntidade de conta com os nome de sua agencia 

SELECT	a.AgenciaID,
		a.NomeAgencia,
		COUNT(c.ContaID) as QTDE
		FROM dbo.Agencia as a WITH(NOLOCK)
			LEFT OUTER JOIN [dbo].[Conta] as c WITH(NOLOCK)
				ON a.AgenciaID = c.AgenciaID
		GROUP BY a.AgenciaID,
				 a.NomeAgencia
		ORDER BY a.NomeAgencia ASC;

-- Agencia sem o nome da conta 

SELECT	a.AgenciaID,
		a.NomeAgencia,
		c.ContaID
		FROM [dbo].[Agencia] as a WITH(NOLOCK)
			LEFT OUTER JOIN [dbo].[Conta] as c WITH(NOLOCK)
				ON a.AgenciaID = c.AgenciaID
					AND c.AgenciaID IS NULL;
				
-- Mesmo resultado sem usar join, quantas contas existe por agencia por quantidade 

SELECT	a.AgenciaID,
		a.NomeAgencia,
		(
			SELECT COUNT(c.ContaID)
				FROM Conta as c WITH(NOLOCK)
				WHERE c.AgenciaID = a.AgenciaID
		) AS QNTD 
	FROM Agencia as a WITH(NOLOCK)
	ORDER BY QNTD ASC;

-- retorna somente a agencia com quantidade de contas impares

SELECT	a.AgenciaID, 
		a.NomeAgencia,
		COUNT(c.ContaID) as 'Contas'
		FROM [dbo].[Agencia] as a 
			JOIN [dbo].[Conta] as c WITH(NOLOCK)
				ON c.AgenciaID = a.AgenciaID 
		WHERE 'Contas' % 2 = 1 
		GROUP BY a.AgenciaID as a
	
SELECT * FROM dbo.Agencia;
