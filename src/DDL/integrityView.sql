
-- all FK-Ids in fact exist in customer_dim 'integrity' 
CREATE OR ALTER VIEW vw_CustomerIntegrity AS

with
    cus_cte
    as
    (
        select CustomerId
        from sales_fct s
        where not exists(
    select 1
        from customer_dim 
        where s.CustomerId = CustomerId )
    )

SELECT
    'Customer dim' AS [Source Table],
    'CustomerId' AS [Source Column],
    'sales fact' as [Target Table],
    'CustomerId' AS [Target Column],

    (select *
    from cus_cte) AS [Integrity Misamtch]
 GO
 

-- all FK-Ids in fact exist in product_dim 'integrity' 
CREATE OR ALTER VIEW vw_ProductIntegrity AS

with
    prod_cte
    as
    (
        select CustomerId
        from sales_fct s
        where not exists(
    select 1
        from product_dim 
        where s.CustomerId = CustomerId )
    )

SELECT
    'Customer dim' AS [Source Table],
    'CustomerId' AS [Source Column],
    'sales fact' as [Target Table],
    'CustomerId' AS [Target Column],

    (select *
    from prod_cte) AS [Integrity Misamtch]
 GO
