USE [DW-AdventureW]
GO

-- Items sold by Fiscal Year, Quarter, sales territory region, and product category
SELECT  d.FiscalYear AS FY,
        d.FiscalQuarter AS FQ,
        t. SalesTerritoryRegion AS SalesTerritory,
        pc.EnglishProductCategoryName AS ProductCategory,
        SUM(r.OrderQuantity) AS ItemsSold
FROM FactResellerSales AS r
JOIN DimDate AS d ON r.OrderDateKey = d.DateKey
JOIN DimEmployee AS e ON r.EmployeeKey = e.EmployeeKey
JOIN DimSalesTerritory AS t ON e.SalesTerritoryKey = t.SalesTerritoryKey
JOIN DimProduct AS p ON r.ProductKey = p.ProductKey
JOIN DimProductSubcategory AS ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY d.FiscalYear, d.FiscalQuarter, t. SalesTerritoryRegion, pc.EnglishProductCategoryName
ORDER BY FY, FQ, SalesTerritory, ProductCategory