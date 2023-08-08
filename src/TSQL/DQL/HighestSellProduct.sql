use [SalesDW]
GO

-- The highest selling 3 products

with
    cte
    as
    (
        select *, ROW_NUMBER() over (order by ProductId desc) as rn
        from sales_fct
    )
select ProductName
from product_dim
where ProductId in (select ProductId
from cte
where rn < 4)
