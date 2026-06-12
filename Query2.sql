use olist_db;

-- liste o nome do cliente, a data do pedido e o status
-- JOIN com clientes

SELECT c.nome, p.data_pedido, p.status
From pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente;


-- Liste nome do cliente, nome do prodto e quantidade
-- uma linha é um item de pedido

SELECT c.nome, pt.nome_produto, i.quantidade
FROM itens_pedido i
JOIN produtos pt ON pt.id_produto = i.id_produto
JOIN pedidos p ON i.id_pedido = p.id_pedido
JOIN clientes c ON p.id_cliente = c.id_cliente;


-- valor total por pedido
SELECT pd.id_pedido as pedido, SUM(pt.preco * i.quantidade) AS valor_total
FROM pedidos pd
JOIN itens_pedido i ON i.id_pedido = pd.id_pedido
JOIN produtos pt ON pt.id_produto = i.id_produto
GROUP BY pd.pedido
ORDER BY pd.id_pedido;

-- Qual cliente mais gastou no total
SELECT c.nome as Nome_cliente, SUM(pt.preco * i.quantidade) AS valor_gasto
FROM clientes c
JOIN pedidos pd ON c.id_cliente = pd.id_cliente
JOIN itens_pedido i ON pd.id_pedido = i.id_pedido
JOIN produtos pt ON i.id_produto = pt.id_produto
GROUP BY c.id_cliente, c.nome -- evita a junção de dois clientes com o mesmo nome
ORDER BY valor_gasto DESC;


-- Para cada cliente mostre total gasto, quantidade de pedidos, ticket médio
SELECT c.nome, SUM(pt.preco * i.quantidade) AS valor_gasto, COUNT(DISTINCT pd.id_pedido) AS quantidade_pedidos,  SUM(pt.preco * i.quantidade) / nullif(count(DISTINCT pd.id_pedido), 0) AS ticket_medio
FROM clientes c
JOIN pedidos pd ON pd.id_cliente = c.id_cliente
JOIN itens_pedido i ON i.id_pedido = pd.id_pedido
JOIN produtos pt ON pt.id_produto = i.id_produto;


-- para cada mes -> receita total, qnt de pedidos, ticket medio
SELECT YEAR(PD.DATA_PEDIDO), MONTH(pd.data_pedido) AS mes, SUM(pt.preco * i.quantidade) AS receita_total, COUNT(DISTINCT pd.id_pedido) AS qnt_pedidos, SUM(pt.preco * i.quantidade) / nullif(count(DISTINCT pd.id_pedido), 0) AS ticket_medio
FROM pedidos pd
JOIN itens_pedido i ON i.id_pedido = pd.id_pedido
JOIN produtos pt ON pt.id_produto = i.id_produto
GROUP BY MONTH(pd.data_pedido);
