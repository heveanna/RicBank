# dia 02 - Resumo comentado 

- Stored Procedures (Prockedimentos Armazenados)

Uma Stored Procedure é um bloco de código SQL que você salva no banco de dados para ser executado repetidamente.
Elas aceitam parâmetros de entrada, podem processar lógica complexa (como IF/ELSE, loops WHILE) e retornam resultados ou apenas executam ações.

- Trigger (gatilhos)

Um Trigger é um bloco de código que é executado automaticamente em resposta a um evento específico em uma tabela (como um INSERT, UPDATE ou DELETE).
Diferente da Procedure, você não "chama" um Trigger. Ele "vigia" a tabela e dispara sozinho quando a condição é atendida.

## ⚠️ Cuidados Importantes

Triggers Ocultos: O excesso de Triggers pode tornar o sistema difícil de debugar, pois as coisas acontecem "por baixo dos panos". Se um Trigger falha, a operação principal (o INSERT ou UPDATE) também falha.

Recursividade: Cuidado para não criar um Trigger que altera uma tabela que dispara outro Trigger, criando um loop infinito.