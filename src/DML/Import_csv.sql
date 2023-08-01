USE [budget_DW]
GO

-- Import customer csv into customer table
BULK INSERT [dbo].[customer_dim]
FROM 'D:\Financial_DW\ExFiles\customer.csv'
with(
    FORMAT = 'csv',
    Firstrow=1
)
GO

USE [budget_DW]
GO
-- Import product csv into product table
BULK INSERT [dbo].[product_dim]
FROM 'D:\Financial_DW\ExFiles\product.csv'
with(
    FORMAT = 'csv',
    Firstrow=1
)
GO

USE [budget_DW]
GO
-- Import sales csv into sales table with composite Primary Key
BULK INSERT [dbo].[sales_fct]
FROM 'D:\Financial_DW\ExFiles\sales.csv'
with(
    FORMAT = 'csv',
    Firstrow=1
)
GO

