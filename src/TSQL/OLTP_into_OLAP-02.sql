use [AW2016-OLAP];

-- Transaction-Level Grain: FactSales. Each row represents a single line item in a sales order.
create table FactSales (
    SalesOrderID int,
    SalesOrderDetailID int,
    CustomerID int,
    ProductID int,
    OrderDateKey int,
    ShipDateKey int,
    Quantity int,
    UnitPrice money,
    Discount money,
    TotalPrice as (Quantity * (UnitPrice - Discount)) persisted,
    primary key (SalesOrderID, SalesOrderDetailID),
    foreign key (CustomerID) references DimCustomer(CustomerID),
    foreign key (ProductID) references DimProduct(ProductID),
    foreign key (OrderDateKey) references DimDate(DateKey),
    foreign key (ShipDateKey) references DimDate(DateKey)
);


insert into FactSales (SalesOrderID, SalesOrderDetailID, CustomerID, ProductID, OrderDateKey, ShipDateKey, Quantity, UnitPrice, Discount)
select 
    soh.SalesOrderID,
    sod.SalesOrderDetailID,
    soh.CustomerID,
    sod.ProductID,
    d1.DateKey as OrderDateKey,
    d2.DateKey as ShipDateKey,
    sod.OrderQty as Quantity,
    sod.UnitPrice,
    sod.UnitPriceDiscount as Discount
from AdventureWorksLT2016.SalesLT.SalesOrderDetail sod
join AdventureWorksLT2016.SalesLT.SalesOrderHeader soh on sod.SalesOrderID = soh.SalesOrderID
join DimDate d1 on cast(soh.OrderDate as date) = d1.FullDate
left join DimDate d2 on cast(soh.ShipDate as date) = d2.FullDate;


select * from FactSales


-- Daily Snapshot Grain: FactDailySales. Each row represents aggregated sales data for a specific day
create table FactDailySales (
    DateKey int,
    CustomerID int,
    ProductID int,
    TotalQuantity int,
    TotalSales money,
    TotalDiscount money,
    primary key (DateKey, CustomerID, ProductID),
    foreign key (DateKey) references DimDate(DateKey),
    foreign key (CustomerID) references DimCustomer(CustomerID),
    foreign key (ProductID) references DimProduct(ProductID)
);


insert into FactDailySales (DateKey, CustomerID, ProductID, TotalQuantity, TotalSales, TotalDiscount)
select 
    d.DateKey,
    soh.CustomerID,
    sod.ProductID,
    sum(sod.OrderQty) as TotalQuantity,
    sum(sod.OrderQty * sod.UnitPrice) as TotalSales,
    sum(sod.OrderQty * sod.UnitPriceDiscount) as TotalDiscount
from AdventureWorksLT2016.SalesLT.SalesOrderDetail sod
join AdventureWorksLT2016.SalesLT.SalesOrderHeader soh on sod.SalesOrderID = soh.SalesOrderID
join DimDate d on soh.OrderDate = d.FullDate
group by d.DateKey, soh.CustomerID, sod.ProductID;


select * from FactDailySales;


------------ Optimization Techniques:

-- Adding non-clustered index on FactSales table
create nonclustered index idx_FactSales_ProductID on FactSales(ProductID);
create nonclustered index idx_FactSales_CustomerID on FactSales(CustomerID);


-- Adding non-clustered index on FactDailySales table
create nonclustered index idx_FactDailySales_ProductID on FactDailySales(ProductID);
create nonclustered index idx_FactDailySales_CustomerID on FactDailySales(CustomerID);


-- Materialized (indexed) view with schema binding
alter view dbo.vw_DailySalesSummary
with schemabinding
as
select 
    d.DateKey,
    sum(isnull(fs.Quantity * fs.UnitPrice, 0)) as TotalSales,  -- Handle NULLs with ISNULL
    count_big(*) as RowCountCol  -- Use a different alias name
from dbo.FactSales fs  -- Fully qualify the table with schema
join dbo.DimDate d on fs.OrderDateKey = d.DateKey  -- Fully qualify the table with schema
group by d.DateKey;

-- Index to materialize the view
create unique clustered index idx_DailySalesSummary on dbo.vw_DailySalesSummary(DateKey);