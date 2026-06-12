use vendas_db;

-- vendas por regiao
SELECT regiao, COUNT(*) AS Vendas_Por_Regiao
from vendas
group by regiao;

-- receita por regiao
select regiao, round(sum(receita), 2) AS receita_por_regiao
from vendas
group by regiao;

-- receita por mes
SELECT mes, ROUND(SUM(receita), 2) AS receita_por_mes
FROM vendas
GROUP BY mes
ORDER BY MIN(data);

-- receita por vendedor
SELECT vendedor, ROUND(SUM(receita), 2) AS Receita_por_vendedor
from vendas
group by vendedor
order by receita_por_vendedor DESC;


-- Receita por produto
SELECT produto, ROUND(SUM(receita), 2)AS receita_por_produto
FROM vendas
GROUP BY produto
ORDER BY receita_por_produto DESC;

-- produtos por volume
SELECT produto, SUM(quantidade) as qnt_de_produtos_vendidos
FROM vendas
GROUP BY produto
ORDER BY qnt_de_produtos_vendidos DESC;

-- receita por pedido
SELECT data, vendedor, ROUND(SUM(receita), 2) AS receita_por_pedido
FROM vendas
GROUP BY data, vendedor
ORDER BY data;

-- margem media por produto
SELECT produto, ROUND(AVG(margem) * 100, 2) AS margem_media
from vendas
group by produto
order by margem_media DESC;

-- ticket medio por vendedor
SELECT vendedor, ROUND(AVG(receita), 2) AS ticketMedio_por_vendedor
from vendas
group by vendedor
order by ticketMedio_por_vendedor DESC;