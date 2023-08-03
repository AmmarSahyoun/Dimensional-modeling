select top(3)
    *
from customer_dim
order by EmailAddress
select count(distinct(CustomerId)) as cnt_dist_cus, count(CustomerId) cnt_cus_all
from customer_dim 

GO

with
    cte
    as
    (
        select EmailAddress, count(*) counts
        from customer_dim
        group by EmailAddress
    )
select counts as duplication_type, count(*) cnt
from cte
group by counts

-- The customer table has 407 duplicated records!


select top(3)
    *
from product_dim
order by ProductName
select count(distinct(ProductName)) as cnt_dist_cus, count(ProductName) cnt_cus_all
from product_dim 
GO
with
    cte
    as
    (
        select ProductName, count(*) counts
        from product_dim
        group by ProductName
    )
select counts as duplication_type, count(*) cnt
from cte
group by counts
GO
    -- Customer table has no duplication regarding ProductName


