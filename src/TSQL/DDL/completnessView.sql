-- Include all the values without Null 'Completeness'

CREATE OR ALTER VIEW [dbo].[vw_completeness]
AS
                SELECT
            'customer_dim' as [Table],
            'CustomerId' as [Column],
            SUM(CASE WHEN CustomerId IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[customer_dim]
    UNION ALL
        SELECT
            'customer_dim' as [Table],
            'FirstName' as [Column],
            SUM(CASE WHEN FirstName IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[customer_dim]
    UNION ALL
        SELECT
            'customer_dim' as [Table],
            'EmailAddress' as [Column],
            SUM(CASE WHEN EmailAddress IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[customer_dim]
UNION ALL
 SELECT
            'product_dim' as [Table],
            'ProductId' as [Column],
            SUM(CASE WHEN ProductId IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[product_dim]
UNION ALL
SELECT
            'product_dim' as [Table],
            'ListPrice' as [Column],
            SUM(CASE WHEN ListPrice IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[product_dim]
UNION ALL
SELECT
            'sales_fct' as [Table],
            'SalesOrderId' as [Column],
            SUM(CASE WHEN SalesOrderId IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[sales_fct]
UNION ALL
SELECT
            'sales_fct' as [Table],
            'OrderDate' as [Column],
            SUM(CASE WHEN OrderDate IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[sales_fct]
UNION ALL
SELECT
            'sales_fct' as [Table],
            'LineItemId' as [Column],
            SUM(CASE WHEN LineItemId IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[sales_fct]
UNION ALL
SELECT
            'sales_fct' as [Table],
            'CustomerId' as [Column],
            SUM(CASE WHEN CustomerId IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[sales_fct]
UNION ALL
SELECT
            'sales_fct' as [Table],
            'ProductId' as [Column],
            SUM(CASE WHEN ProductId IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[sales_fct]
UNION ALL
SELECT
            'sales_fct' as [Table],
            'Quantity' as [Column], 
            SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS [count of null]
        FROM [dbo].[sales_fct];
GO


select * from vw_completeness