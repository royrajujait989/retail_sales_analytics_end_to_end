Select * from dataset;
set sql_safe_updates=0;

-- Remove Null CustomerID
delete from dataset where CustomerID is null;

-- Remove Cancelled Invoices (Invoice Starts with 'C') 
delete from dataset where InvoiceNo like 'C%';

-- Remov Negative Quantity
delete from dataset where Quantity <= 0;

-- Create Sales Column
alter table dataset add Sales decimal(10,2);
update dataset set Sales=Quantity * UnitPrice;

-- KPI Queries
-- 1. Total Sales
select sum(Quantity * UnitPrice) as Total_Sales from dataset;
Select sum(Sales) as Total_Sales from dataset;

-- 2. Total Orders
select count(InvoiceNo) as Total_Orders from dataset;
Select count(distinct InvoiceNo) as Total_Orders from dataset;

-- 3. Total Customers
Select count(CustomerID) as Total_Customers from dataset;
Select count(distinct CustomerID) as Total_Customers from dataset;

-- 4. Total Quantity
Select sum(Quantity) as Total_Quantity from dataset;

-- Monthly Sales Trend
Select 
year(InvoiceDate) as Year,
 month(InvoiceDate) as Month,
 sum(Sales) as Monthly_Sales from dataset 
 group by year(InvoiceDate), month(InvoiceDate) order by Year, Month;
 
 -- Top 10 Products
 select Description, sum(Sales) as Total_Sales from dataset group by Description Order By Total_Sales Desc limit 10;
 
 -- Country Wise Sales
 Select Country, sum(Sales) as Total_Sales from dataset group by Country order by Total_Sales desc limit 10;
 
 -- Top Customers
 Select CustomerID, sum(Sales) as Total_Sales from dataset group by CustomerID order by Total_Sales desc limit 10;
 
 Select sum(Sales) as Return_Amount from dataset where Quantity < 0;