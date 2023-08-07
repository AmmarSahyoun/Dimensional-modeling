
IF OBJECT_ID('[dbo].[customer_dim]', 'U') IS NOT NULL
DROP TABLE [dbo].[customer_dim]
GO

CREATE TABLE [dbo].[customer_dim]
(
    [CustomerId] INT NOT NULL PRIMARY KEY, 
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50)  NULL,
    [EmailAddress] NVARCHAR(50) NOT NULL,
    [Phone] NVARCHAR(50)  NULL,
   
);
GO


