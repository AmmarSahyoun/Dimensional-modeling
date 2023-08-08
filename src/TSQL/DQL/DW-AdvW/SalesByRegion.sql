USE [DW-AdventureW]
GO

-- Items sold by Fiscal Year, Quarter, and sales territory region
SELECT  d.FiscalYear AS FY,
        d.FiscalQuarter AS FQ,
        t. SalesTerritoryRegion AS SalesTerritory,
        SUM(r.OrderQuantity) AS ItemsSold
FROM FactResellerSales AS r
JOIN DimDate AS d ON r.OrderDateKey = d.DateKey
JOIN DimEmployee AS e ON r.EmployeeKey = e.EmployeeKey
JOIN DimSalesTerritory AS t ON e.SalesTerritoryKey = t.SalesTerritoryKey
GROUP BY d.FiscalYear, d.FiscalQuarter, t. SalesTerritoryRegion
ORDER BY FY, FQ, SalesTerritory