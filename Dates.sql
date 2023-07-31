USE [budget_DW]
GO

IF OBJECT_ID('[dbo].[Date_dim]', 'U') IS NOT NULL
DROP TABLE [dbo].[Date_dim]
GO

CREATE TABLE [dbo].[Date_dim]
(
    [date_key] INT NOT NULL PRIMARY KEY, 
    [full_date] date NULL,
    [month] CHAR(10) NULL,
    [year] SMALLINT NULL,
    [month_num] SMALLINT NULL,
    [week_num] SMALLINT NULL,
    [week_day] CHAR(10) NULL,
    [week_day_num] SMALLINT NULL
    
);
GO