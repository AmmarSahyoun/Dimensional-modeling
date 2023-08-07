USE[budget_DW]
GO

ALTER TABLE Date_dim
ADD [YYYY-MM] VARCHAR(7);
GO

UPDATE [dbo].[Date_dim]
SET [YYYY-MM] = (SUBSTRING(CONVERT(VARCHAR(7), [full_date]), 1, 7));
GO

select TOP (50) * from [dbo].[Date_dim]