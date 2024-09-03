use [AW2016-OLAP];

-- Transaction-Level Grain: FactSales
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


-- Daily Snapshot Grain: FactDailySales
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