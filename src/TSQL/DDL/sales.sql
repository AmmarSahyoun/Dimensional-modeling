USE [budget_DW]
GO

IF OBJECT_ID('[dbo].[sales_fct]', 'U') IS NOT NULL
DROP TABLE [dbo].[sales_fct]
GO

CREATE TABLE [dbo].[sales_fct]
(
    [SalesOrderId] INT NOT NULL , 
    [OrderDate] DATE NOT NULL,
    [LineItemId] INT  NOT NULL, 
    [CustomerId] INT NOT NULL,
    [ProductId] INT NOT NULL,
    [Quantity] INT NOT NULL,
    CONSTRAINT PK_OrderId PRIMARY KEY (SalesOrderId, LineItemId)
);
GO


