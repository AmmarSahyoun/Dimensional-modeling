USE [DW-AdventureW]
GO
-- Items sold by Fiscal Year and Quarter

SELECT  d.FiscalYear AS FY,
        d.FiscalQuarter AS FQ,
        SUM(r.OrderQuantity) AS ItemsSold
FROM FactResellerSales AS r
JOIN DimDate AS d ON r.OrderDateKey = d.DateKey
GROUP BY d.FiscalYear, d.FiscalQuarter
ORDER BY FY, FQ;
GO