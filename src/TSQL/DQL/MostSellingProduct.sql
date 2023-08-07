
-- The most selling product
select s.ProductId, ProductName, p.ListPrice, count(*) cnt
from sales_fct s join product_dim p on s.ProductId=p.ProductId
group by s.ProductId, p.ListPrice, ProductName
order by count(*) desc