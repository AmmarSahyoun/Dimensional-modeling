use [SalesDW]
GO


SELECT s.SalesOrderId, c.EmailAddress, p.ProductName, s.Quantity
FROM sales_fct AS s
    JOIN customer_dim AS c ON s.CustomerId = c.CustomerId
    JOIN product_dim AS p ON s.ProductId = p.ProductId
ORDER BY Quantity desc



