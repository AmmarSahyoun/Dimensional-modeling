-- Adhere to business rules "Validity"

CREATE OR ALTER VIEW [dbo].[vw_validity]
AS
                SELECT
            'customer_dim' as [Table],
            'EmailAddress' as [Column],
            '%@%' as [Rule],
            Sum(CASE WHEN EmailAddress LIKE '%@%' THEN 1 ELSE 0 END) AS [valid records],
            Sum(CASE WHEN EmailAddress NOT LIKE '%@%' THEN 1 ELSE 0 END) AS [invalid records]

        FROM customer_dim
    UNION ALL
        SELECT
            'product_dim' as [Table],
            'ItemSku' as [Column],
            '__-%' as [Rule],
            Sum(CASE WHEN ItemSku LIKE '__-%' THEN 1 ELSE 0 END) AS [valid records],
            Sum(CASE WHEN ItemSku NOT LIKE '__-%' THEN 1 ELSE 0 END) AS [invalid records]

        FROM product_dim
    UNION ALL
        SELECT
            'sales_fct' as [Table],
            'Quantity' as [Column],
            '>0' as [Rule],
            Sum(CASE WHEN Quantity >0 THEN 1 ELSE 0 END) AS [valid records],
            Sum(CASE WHEN Quantity  <=0 THEN 1 ELSE 0 END) AS [invalid records]

        FROM sales_fct
GO

select * from vw_validity