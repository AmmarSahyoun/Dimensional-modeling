-- The same data value stored in a different columns are identical 'Consistency'

CREATE OR ALTER VIEW [dbo].[vw_consistency]
AS
    SELECT
        DISTINCT c.EmailAddress AS [distinct value],
            COUNT (*) AS [number of records],
            'sales_fct' AS [Table],
            'EmailAddress' AS [Column]
        FROM sales_fct s
            JOIN customer_dim c on c.CustomerId = s.CustomerId
            GROUP BY EmailAddress
    UNION ALL
    SELECT
        DISTINCT p.ProductName AS [distinct value],
            COUNT(*) AS [number of records],
            'sales_fct' AS [Table],
            'ProductName' AS [Column]
        FROM sales_fct s
            JOIN product_dim p on p.ProductId = s.ProductId
            GROUP BY ProductName
GO



select * from vw_consistency