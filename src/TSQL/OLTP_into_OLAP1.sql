use [AW2016-OLAP];

-- DDL + DML to derive OLAP from AdventureWorks 2016 Lightweight


-- Create the updated DimCustomer table
create table DimCustomer (
    CustomerID int primary key,
    CustomerName nvarchar(100) not null,
    EmailAddress nvarchar(100),
    Phone nvarchar(25),
    AddressID int,
    AddressLine1 nvarchar(60),
    City nvarchar(30),
    StateProvince nvarchar(50),
    PostalCode nvarchar(15),
    CountryRegion nvarchar(50),
    CreatedDate date not null
);

-- Populate DimCustomer with data from Customer, CustomerAddress, and Address tables
insert into DimCustomer (CustomerID, CustomerName, EmailAddress, Phone, AddressID, 
                         AddressLine1, City, StateProvince, PostalCode, CountryRegion, CreatedDate)
select 
    c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    c.EmailAddress,
    c.Phone,
    coalesce(mainOffice.AddressID, shipping.AddressID) as AddressID,  -- Preferred address type
    coalesce(mainOffice.AddressLine1, shipping.AddressLine1) as AddressLine1,
    coalesce(mainOffice.City, shipping.City) as City,
    coalesce(mainOffice.StateProvince, shipping.StateProvince) as StateProvince,
    coalesce(mainOffice.PostalCode, shipping.PostalCode) as PostalCode,
    coalesce(mainOffice.CountryRegion, shipping.CountryRegion) as CountryRegion,
    c.ModifiedDate as CreatedDate
from AdventureWorksLT2016.SalesLT.Customer c
left join (
    select ca.CustomerID, ca.AddressID, a.AddressLine1, a.City, a.StateProvince, a.PostalCode, a.CountryRegion
    from AdventureWorksLT2016.SalesLT.CustomerAddress ca
    join AdventureWorksLT2016.SalesLT.Address a on ca.AddressID = a.AddressID
    where ca.AddressType = 'Main Office'
) as mainOffice on c.CustomerID = mainOffice.CustomerID
left join (
    select ca.CustomerID, ca.AddressID, a.AddressLine1, a.City, a.StateProvince, a.PostalCode, a.CountryRegion
    from AdventureWorksLT2016.SalesLT.CustomerAddress ca
    join AdventureWorksLT2016.SalesLT.Address a on ca.AddressID = a.AddressID
    where ca.AddressType = 'Shipping'
) as shipping on c.CustomerID = shipping.CustomerID;


-- Validate 
select * from dbo.DimCustomer where 1=1 


-- Create the Date Dimension table
create table DimDate (
    DateKey int primary key,
    FullDate date,
    Day int,
    Month int,
    Year int,
    DayOfWeek nvarchar(10),
    Quarter int
);

-- Generate full date range using a recursive CTE
with DateList as (
    select cast('2000-01-01' as date) as d
    union all
    select dateadd(day, 1, d)
    from DateList
    where d < '2025-12-31'
)
insert into DimDate (DateKey, FullDate, Day, Month, Year, DayOfWeek, Quarter)
select 
    cast(format(d, 'yyyyMMdd') as int) as DateKey,
    d as FullDate,
    day(d) as Day,
    month(d) as Month,
    year(d) as Year,
    datename(weekday, d) as DayOfWeek,
    datepart(quarter, d) as Quarter
from DateList
option (maxrecursion 0);  --Allow infinite recursion to cover all dates


-- Create the Product Dimension table with additional attributes
create table DimProduct (
    ProductID int primary key,
    ProductName nvarchar(100),
    ProductNumber nvarchar(25),
    Color nvarchar(15),
    ListPrice money,
    ProductCategory nvarchar(50),
    ParentCategory nvarchar(50), -- To capture the hierarchical nature of Product Categories
    ProductModel nvarchar(50),
    ProductDescriptions nvarchar(max), -- To capture concatenated descriptions
    ModifiedDate datetime
);


-- Insert data into DimProduct with aggregation for descriptions
insert into DimProduct (ProductID, ProductName, ProductNumber, Color, ListPrice, 
                        ProductCategory, ParentCategory, ProductModel, ProductDescriptions, ModifiedDate)
select 
    p.ProductID,
    p.Name as ProductName,
    p.ProductNumber,
    p.Color,
    p.ListPrice,
    pc.Name as ProductCategory,
    pcp.Name as ParentCategory, -- Self-join to get parent category
    pm.Name as ProductModel,
    STRING_AGG(pd.Description, ', ') as ProductDescriptions, -- Aggregating descriptions
    p.ModifiedDate
from AdventureWorksLT2016.SalesLT.Product p
left join AdventureWorksLT2016.SalesLT.ProductCategory pc 
    on p.ProductCategoryID = pc.ProductCategoryID
left join AdventureWorksLT2016.SalesLT.ProductCategory pcp 
    on pc.ParentProductCategoryID = pcp.ProductCategoryID -- Self-join for parent category
left join AdventureWorksLT2016.SalesLT.ProductModel pm 
    on p.ProductModelID = pm.ProductModelID
left join AdventureWorksLT2016.SalesLT.ProductModelProductDescription pmpd 
    on pm.ProductModelID = pmpd.ProductModelID
left join AdventureWorksLT2016.SalesLT.ProductDescription pd 
    on pmpd.ProductDescriptionID = pd.ProductDescriptionID
group by 
    p.ProductID,
    p.Name,
    p.ProductNumber,
    p.Color,
    p.ListPrice,
    pc.Name,
    pcp.Name,
    pm.Name,
    p.ModifiedDate;

select * from DimProduct;








	












