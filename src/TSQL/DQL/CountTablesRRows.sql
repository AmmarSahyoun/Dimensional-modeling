-- Count the rows of each table
use [SalesDW]
GO


SELECT s.name AS SchemaName, t.name AS TableName, SUM(p.rows) AS TableRowCount
FROM sys.schemas AS s
    JOIN sys.tables AS t ON t.schema_id = s.schema_id
    JOIN sys.partitions AS p ON p.object_id = t.object_id
GROUP BY s.name, t.name
ORDER BY SchemaName, TableName
GO

select count(distinct([EmailAddress])) as Customer_Unique_Values from customer_dim 
select count(distinct([ProductName])) as Product_Unique_Values from product_dim
select count(distinct([LineItemId])) as Order_Unique_Values from sales_fct c

