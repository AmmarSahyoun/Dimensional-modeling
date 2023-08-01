USE [budget_DW]
GO

IF OBJECT_ID('[dbo].[product_dim]', 'U') IS NOT NULL
DROP TABLE [dbo].[product_dim]
GO

CREATE TABLE [dbo].[product_dim]
(
    [ProductId] INT NOT NULL PRIMARY KEY, 
    [ProductName] NVARCHAR(50)  NULL,
    [IntroductionDate] date  NULL,
    [ActualAbandonmentDate] date NULL,
    [ProductGrossWeight] DECIMAL  NULL,
    [ItemSku] VARCHAR(50) NULL,
    [ListPrice] DECIMAL NOT NULL
);
GO


