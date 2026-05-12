USE RicBank;

-- Rick Bank

-- 1. Criar tabela
CREATE TABLE #Conta (
    Id              INT,
    IdCliente       INT,
    IdAgencia       INT,
    Numero          VARCHAR(20),
    Tipo            VARCHAR(1),
    Saldo           DECIMAL(15,2),
    Situacao        VARCHAR(20),
    DataAbertura    DATETIME,
    SaldoMedioAgencia DECIMAL(18, 2) NULL
);

-- 2. Popular TEMP sem atributo media

INSERT INTO #Conta (Id, IdCliente, IdAgencia, Numero, Tipo, Saldo, Situacao, DataAbertura)
    SELECT Id, 
           IdCliente, 
           IdAgencia, 
           Numero, 
           Tipo, 
           Saldo, 
           Situacao, 
           DataAbertura
        FROM Conta;

-- 3. SELECT TEMP 

SELECT * FROM #Conta;

-- 4. Apaga todos registros TEMP 

DELETE FROM #Conta;

-- 5. Popula TEMP com atributo
-- separa conta por agencia, e fazer calculo da média 

INSERT INTO #Conta (Id, IdCliente, IdAgencia, Numero, Tipo, Saldo, Situacao, DataAbertura, SaldoMedioAgencia)
    SELECT Id, 
           IdCliente, 
           IdAgencia, 
           Numero, 
           Tipo, 
           Saldo, 
           Situacao, 
           DataAbertura,
           (SELECT AVG(Saldo)
                FROM Conta c1
                WHERE c1.IdAgencia = c2.IdAgencia
                GROUP BY c1.IdAgencia)
        FROM Conta as c2;
            
-- 6. SELECT TEMP(tabela temporaria) ordenado pelo saldo crescente

SELECT  Id,
        IdCliente,
        IdAgencia, 
        Numero, 
        Tipo, 
        Saldo, 
        Situacao, 
        DataAbertura,
        FORMAT(SaldoMedioAgencia, 'C', 'Pt-Br')
    FROM #Conta
    ORDER BY Saldo ASC;

-- 7. Apague da TEMP a conta que tiver o menor saldo 

DELETE
    FROM #Conta 
    WHERE Saldo = 
        (SELECT MIN(Saldo)
            FROM #Conta)

-- 8. SELECT TEMP ordenado pelo saldo maior 

SELECT  Id,
        IdCliente,
        IdAgencia, 
        Numero, 
        Tipo, 
        Saldo, 
        Situacao, 
        DataAbertura,
        FORMAT(SaldoMedioAgencia, 'C', 'Pt-Br')
    FROM #Conta
    ORDER BY Saldo DESC;

-- 9. lISTAR as contas com saldo maior que saldo medio em ordem decresecente

SELECT Id, 
       IdCliente, 
       IdAgencia, 
       Numero, 
       Tipo, 
       Saldo, 
       Situacao, 
       DataAbertura,
       SaldoMedioAgencia
    FROM #Conta 
    WHERE Saldo > SaldoMedioAgencia
    ORDER BY Saldo DESC

-- 10. LISTAR as contas informando as palavras "IMPAR" ou "PAR" dependendo
-- do saldo. Este atributo tem que se chamar "Tipo Saldo"

CASE 

-- 11. Altere o saldo da conta que atualmente tem o menor saldo para
-- R$ 1.000 a mais 

SELECT 

-- 12. Liste as conta em ordem de saldo crescente 

-- 13. Apague a TEMP 

DELETE * FROM #Conta;
