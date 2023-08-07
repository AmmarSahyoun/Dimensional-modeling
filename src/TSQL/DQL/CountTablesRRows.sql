-- Count the rows of each table
use[budget_DW]

SELECT s.name AS SchemaName, t.name AS TableName, SUM(p.rows) AS TableRowCount
FROM sys.schemas AS s
    JOIN sys.tables AS t ON t.schema_id = s.schema_id
    JOIN sys.partitions AS p ON p.object_id = t.object_id
GROUP BY s.name, t.name
ORDER BY SchemaName, TableName
GO