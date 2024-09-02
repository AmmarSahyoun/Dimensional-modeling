-- lightweight OLTP database AdventureWorksLT2016

use [AdventureWorksLT2016];

-- Check if there are any repeating groups or redundant data
select ProductID, Name, ListPrice, StandardCost
from SalesLT.Product
where ListPrice = StandardCost; 


--Referential Integrity: Ensure all customerID in SalesOrderHeader exist in Customer table
select soh.SalesOrderID, soh.CustomerID
from SalesLT.SalesOrderHeader soh
left join SalesLT.Customer c on soh.CustomerID = c.CustomerID
where c.CustomerID is null;


-- Check for any SalesOrderDetail records with invalid OrderQty
select SalesOrderID, ProductID, OrderQty
from SalesLT.SalesOrderDetail
where 1=1 
-- and OrderQty <= 0
and UnitPriceDiscount > 0.5 

-- Triggers automats Business Logic in database, like updating a product inventory level after a sales order is processed.
select name, object_name(parent_id) as table_name, type_desc
from sys.triggers;


-- Self-Referencing Foreign Keys, Extract parent-product hierarchy
select 
	pp.Name as parent,
    p.Name as product_name,
    p.rowguid,
    p.ModifiedDate
from SalesLT.ProductCategory p 
	left join SalesLT.ProductCategory pp 
	on p.ParentProductCategoryID = pp.ProductCategoryID
order by parent


-- Check if there are cascading deletes set up in foreign key constraints
select 
    fk.name as FK_name,
    t.name as table_name,
    ref.name as referenced_table_name,
    fk.delete_referential_action_desc,
    fk.update_referential_action_desc
from sys.foreign_keys fk
join sys.tables t on fk.parent_object_id = t.object_id
join sys.tables ref on fk.referenced_object_id = ref.object_id
where fk.delete_referential_action = 1 or fk.update_referential_action = 1;


-- List all indexes on a table (Clustered indexes on PK, while non-clustered indexes applied to frequently queried columns)
select 
    i.name as index_name, 
    i.type_desc as index_type,
    c.name as column_name
from sys.indexes i
join sys.index_columns ic on i.object_id = ic.object_id and i.index_id = ic.index_id
join sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
where i.object_id = object_id('SalesLT.SalesOrderHeader');


-- Check for computed columns in a table (virtual columns calculated from other columns)
select 
    c.name as column_name, 
    c.is_computed,
    cc.definition
from sys.columns c
join sys.computed_columns cc on c.object_id = cc.object_id and c.column_id = cc.column_id
where c.object_id = object_id('SalesLT.SalesOrderDetail');


-- Check for default constraints on a table (ensure that a column is populated with a default value)
select 
    c.name as column_name, 
    dc.definition as default_value
from sys.default_constraints dc
join sys.columns c on dc.parent_object_id = c.object_id and dc.parent_column_id = c.column_id
where c.object_id = object_id('SalesLT.Customer');


-- Check the isolation level of the current session
select 
    transaction_isolation_level
from sys.dm_exec_sessions
where session_id = @@SPID;
