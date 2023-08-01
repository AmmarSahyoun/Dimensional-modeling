-- All values are unique and there is no duplicates

CREATE OR ALTER VIEW [dbo].[vw_uniqueness]
AS
    SELECT
        'customer_dim' as [Table],
        'CustomerId' as [Column],
        COUNT(CustomerId) AS [count records],
        COUNT(DISTINCT CustomerId) AS [count distinct records],
        COUNT(CustomerId) - COUNT(DISTINCT CustomerId) AS [count duplicates]
    FROM customer_dim
UNION ALL
SELECT
        'customer_dim' as [Table],
        'FirstName' as [Column],
        COUNT(FirstName) AS [count records],
        COUNT(DISTINCT FirstName) AS [count distinct records],
        COUNT(FirstName) - COUNT(DISTINCT FirstName) AS [count duplicates]
    FROM customer_dim
UNION ALL
SELECT
        'customer_dim' as [Table],
        'EmailAddress' as [Column],
        COUNT(EmailAddress) AS [count records],
        COUNT(DISTINCT EmailAddress) AS [count distinct records],
        COUNT(EmailAddress) - COUNT(DISTINCT EmailAddress) AS [count duplicates]
    FROM customer_dim
UNION ALL
SELECT
        'product_dim' as [Table],
        'ProductId' as [Column],
        COUNT(ProductId) AS [count records],
        COUNT(DISTINCT ProductId) AS [count distinct records],
        COUNT(ProductId) - COUNT(DISTINCT ProductId) AS [count duplicates]
    FROM product_dim
UNION ALL
SELECT
        'product_dim' as [Table],
        'ListPrice' as [Column],
        COUNT(ListPrice) AS [count records],
        COUNT(DISTINCT ListPrice) AS [count distinct records],
        COUNT(ListPrice) - COUNT(DISTINCT ListPrice) AS [count duplicates]
    FROM product_dim
UNION ALL
SELECT
        'sales_fct' as [Table],
        'SalesOrderId' as [Column],
        COUNT(SalesOrderId) AS [count records],
        COUNT(DISTINCT SalesOrderId) AS [count distinct records],
        COUNT(SalesOrderId) - COUNT(DISTINCT SalesOrderId) AS [count duplicates]
    FROM sales_fct
UNION ALL
SELECT
        'sales_fct' as [Table],
        'OrderDate' as [Column],
        COUNT(OrderDate) AS [count records],
        COUNT(DISTINCT OrderDate) AS [count distinct records],
        COUNT(OrderDate) - COUNT(DISTINCT OrderDate) AS [count duplicates]
    FROM sales_fct
UNION ALL
SELECT
        'sales_fct' as [Table],
        'LineItemId' as [Column],
        COUNT(LineItemId) AS [count records],
        COUNT(DISTINCT LineItemId) AS [count distinct records],
        COUNT(LineItemId) - COUNT(DISTINCT LineItemId) AS [count duplicates]
    FROM sales_fct
UNION ALL
SELECT
        'sales_fct' as [Table],
        'CustomerId' as [Column],
        COUNT(CustomerId) AS [count records],
        COUNT(DISTINCT CustomerId) AS [count distinct records],
        COUNT(CustomerId) - COUNT(DISTINCT CustomerId) AS [count duplicates]
    FROM sales_fct
UNION ALL
SELECT
        'sales_fct' as [Table],
        'ProductId' as [Column],
        COUNT(ProductId) AS [count records],
        COUNT(DISTINCT ProductId) AS [count distinct records],
        COUNT(ProductId) - COUNT(DISTINCT ProductId) AS [count duplicates]
    FROM sales_fct
UNION ALL
SELECT
        'sales_fct' as [Table],
        'Quantity' as [Column],
        COUNT(Quantity) AS [count records],
        COUNT(DISTINCT Quantity) AS [count distinct records],
        COUNT(Quantity) - COUNT(DISTINCT Quantity) AS [count duplicates]
    FROM sales_fct
GO

select * from vw_uniqueness