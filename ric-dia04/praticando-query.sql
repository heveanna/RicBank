USE RickBankPower;

-- 1. Listagem Geral de Contas
-- Crie uma consulta que mostre o Nome do Cliente, o Número da Agência, o Número da Conta e a Data de Cadastro da conta.
-- Ordene pelo nome do cliente.

SELECT	cl.Nome AS Cliente,
		ag.Numero AS Agencia,
		co.numero AS Conta,
		co.DataCadastro AS 'Data Cadastro'
	FROM Cliente as cl 
		JOIN Agencia as ag
			ON cl.Id = ag.Id
		JOIN Conta as co
			ON cl.Id = co.Id
	ORDER BY 

-- 2. Saldo Atual por Conta
-- O saldo real de uma conta é $(SaldoInicial + Credito - Debito)$. 
-- Escreva um SELECT que retorne o Nome do Cliente, o Número da Conta e o Saldo Atual calculado.

-- 
