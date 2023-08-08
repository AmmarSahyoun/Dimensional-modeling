use [SalesDW]
GO


-- check for uniqeness for a column
with
    cte
    as
    (
        select *, ROW_NUMBER() over (partition by  ProductId order by ProductId) as duplicate
        from product_dim
    )
select *
from cte
where duplicate >1 ;
GO

with
    cte
    as
    (
        select *, ROW_NUMBER() over (partition by  ProductName order by ProductName) as duplicate
        from product_dim
    )
select *
from cte
where duplicate >1 ;
GO