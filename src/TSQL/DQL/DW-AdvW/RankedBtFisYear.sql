USE [DW-AdventureW]
GO

-- Ranked sales territories by year based on total sales amount
SELECT  d.FiscalYear,
        t. SalesTerritoryRegion AS SalesTerritory,
        SUM(s.SalesAmount) AS TerritoryTotal,
        SUM(SUM(s.SalesAmount)) OVER(PARTITION BY d.FiscalYear) AS YearTotal,
        RANK() OVER(PARTITION BY d.FiscalYear
                    ORDER BY SUM(s.SalesAmount) DESC) AS RankForYear
FROM FactResellerSales AS s
JOIN DimDate AS d ON s.OrderDateKey = d.DateKey
JOIN DimEmployee AS e ON s.EmployeeKey = e.EmployeeKey
JOIN DimSalesTerritory AS t ON e.SalesTerritoryKey = t.SalesTerritoryKey
GROUP BY d.FiscalYear, t.SalesTerritoryRegion
ORDER BY d.FiscalYear;
GO