
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
