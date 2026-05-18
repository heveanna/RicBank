USE RickBankPower;

-- 1. Listagem Geral de Contas
-- Crie uma consulta que mostre o Nome do Cliente, o Número da Agência, o Número da Conta e a Data de Cadastro da conta.
-- Ordene pelo nome do cliente.

SELECT	cl.Nome AS Cliente,
		ag.Numero AS Agencia,
		co.Numero AS Conta,
		co.DataCadastro AS 'Data Cadastro'
	FROM [dbo].[Conta] as co WITH(NOLOCK)
		JOIN [dbo].[Cliente] as cl
			ON cl.Id = co.IdCliente
		JOIN [dbo].[Agencia] as ag
			ON ag.Id = co.IdAgencia
	ORDER BY cl.Nome ASC;

-- 2. Saldo Atual por Conta
-- O saldo real de uma conta é $(SaldoInicial + Credito - Debito)$. 
-- Escreva um SELECT que retorne o Nome do Cliente, o Número da Conta e o Saldo Atual calculado.

SELECT  cl.Nome AS Cliente, 
		co.Numero AS Conta,
		SUM(sa.SaldoInicial + sa.Credito + sa.Debito) AS Saldo
	FROM [dbo].[Conta] as co WITH(NOLOCK)
		JOIN [dbo].[Cliente] as cl
			ON cl.Id = co.IdCliente
		JOIN [dbo].[Saldo] as sa	
			ON sa.IdConta = co.Id
		GROUP BY sa.SaldoInicial, sa.Credito, sa.Debito, cl.Nome, co.Numero;

-- 3. Clientes sem Movimentação
-- Encontre todos os clientes (Nome e CPF) que possuem uma conta cadastrada, mas que ainda
-- não possuem nenhum registro na tabela de Lancamento.				 	

SELECT  co.Id,
		cl.Nome AS Cliente,
		cl.CPF,
		la.Historico AS Lancamento
	FROM [dbo].[Conta] as co
		JOIN [dbo].[Cliente] as cl
			ON cl.Id = co.IdCliente
		JOIN [dbo].[Lancamento] as la
			ON la.Id = cl.Id
	WHERE la.Historico = ' ';

-- 4. Resumo de Lançamentos por Tipo
-- Utilizando a tabela Lancamento, mostre o Histórico (ou agrupe por palavras-chave)    ('D') e a soma para Crédito ('C').

SELECT	la.Historico,
		Format(SUM(sa.Debito + sa.Credito), 'C', 'Pt-Br') AS 'Soma de valores'
	FROM [dbo].[Lancamento] as la
		JOIN [dbo].[Saldo] as sa 
			ON sa.Id = la.Id
	GROUP BY la.Historico, la.Valor, 
				sa.Debito, sa.Credito;

-- 5. Ranking de Agências
-- Descubra qual agência possui o maior volume de dinheiro movimentado (Soma de Crédito +
-- Soma de Débito). Exiba o Nome da Agência e o Total Movimentado.

SELECT	TOP 1 ag.Id,
		ag.Nome AS Agencia,
		SUM(sa.Debito + sa.Credito) AS 'Total Movimentado'
	FROM [dbo].[Agencia] as ag WITH(NOLOCK)
		JOIN [dbo].[Conta] as co
			ON co.IdAgencia = ag.Id
		JOIN [dbo].[Saldo] as sa
			ON sa.Id = co.Id
	GROUP BY ag.Id, ag.Nome
	ORDER BY 'Total Movimentado' DESC;

-- 6. Filtro de Idade (Data de Nascimento)
-- Selecione o nome e a idade de todos os clientes que têm mais de 30 anos.

DECLARE @Ano INT = 2026;
DECLARE @Idade INT = 30;

SELECT 