USE [DW-AdventureW]
GO

-- Approximate number of sales orders per fiscal year by territory
SELECT  d.FiscalYear,
        t. SalesTerritoryRegion AS SalesTerritory,
        APPROX_COUNT_DISTINCT(s.SalesOrderNumber) AS ApproxOrders
FROM FactResellerSales AS s
JOIN DimDate AS d ON s.OrderDateKey = d.DateKey
JOIN DimEmployee AS e ON s.EmployeeKey = e.EmployeeKey
JOIN DimSalesTerritory AS t ON e.SalesTerritoryKey = t.SalesTerritoryKey
GROUP BY d.FiscalYear, t.SalesTerritoryRegion
ORDER BY d.FiscalYear, ApproxOrders;
GO