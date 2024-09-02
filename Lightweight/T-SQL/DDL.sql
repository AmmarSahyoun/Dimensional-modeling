create table DimProduct
as
select
    p.ProductID,
    p.Name as ProductName,
    p.ProductNumber,
    p.Color,
    p.ListPrice,
    pm.Name as ProductModel,
    pc.ProductCategoryID,
    coalesce(pc.ParentProductCategoryID, pc.ProductCategoryID) as ParentCategoryID
from
    Product p
    inner join ProductModel pm on p.ProductModelID = pm.ProductModelID
    inner join ProductCategory pc on p.ProductCategoryID = pc.ProductCategoryID;




create table DimProductCategory
as
select
    pc.ProductCategoryID,
    pc.Name as CategoryName,
    coalesce(parent.Name, 'Root') as ParentCategoryName
from
    ProductCategory pc
    left join ProductCategory parent on pc.ParentProductCategoryID = parent.ProductCategoryID;




create table DimProductModel
as
select
    pm.ProductModelID,
    pm.Name as ProductModelName,
    pd.Description as ProductDescription
from
    ProductModel pm
    inner join ProductModelProductDescription pmpd on pm.ProductModelID = pmpd.ProductModelID
    inner join ProductDescription pd on pmpd.ProductDescriptionID = pd.ProductDescriptionID;




create table FactSales
as
select
    s.SalesOrderID,
    s.OrderDate,
    p.ProductID,
    pc.ProductCategoryID,
    pm.ProductModelID,
    s.OrderQty as Quantity,
    s.LineTotal as SalesAmount
from
    SalesOrderDetail s
    inner join Product p on s.ProductID = p.ProductID
    inner join ProductCategory pc on p.ProductCategoryID = pc.ProductCategoryID
    inner join ProductModel pm on p.ProductModelID = pm.ProductModelID;
