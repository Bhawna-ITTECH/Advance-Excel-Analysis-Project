use Interview_Dataset;
select * from [Advance Excel Dataset];
--? LEVEL 1 — BASIC SQL QUESTIONS
--Total number of orders count karo.
select COUNT(Order_ID) from [Advance Excel Dataset];
--Total Sales nikaalo.
select sum(sales) as total_sales from [Advance Excel Dataset];
--Total Profit nikaalo.
select sum(Profit) as total_profit from [Advance Excel Dataset];
--Unique Regions list karo.
select distinct Region from [Advance Excel Dataset];
--Unique Product Categories list karo.
select distinct Product_Category from [Advance Excel Dataset];
--Total customers count karo.
select count(distinct customer_name)as total_customer from [Advance Excel Dataset];
--Total Quantity sold nikaalo.
select sum(Quantity) as total_QTY from [Advance Excel Dataset];
--Highest Sales value find karo.
select max(sales) as high_sale from [Advance Excel Dataset];
--Lowest Profit find karo.
select min(Profit) as low_profit from [Advance Excel Dataset];
--Customer Name + Region table display karo (SELECT with specific columns).
select Region,(Customer_name) from [Advance Excel Dataset];
--? LEVEL 2 — FILTER / WHERE QUESTIONS
--East region ke saare orders show karo.
select * from [Advance Excel Dataset]
where region='East';
--Technology category ke orders filter karo.
select * from [Advance Excel Dataset]
where Product_Category='Technology';
--Discount > 0.20 wale records show karo.
select * from [Advance Excel Dataset]
where Discount>0.20;
--Profit negative hai to woh orders show karo.
select * from [Advance Excel Dataset]
where profit<0;
--Sales between 500 aur 2000 ke beech wale orders fetch karo.
select * from [Advance Excel Dataset]
where sales between 500 and 2000;
--Specific Product Name ka data show karo.
select * from [Advance Excel Dataset]
where Product_Name='laptop';
--January 2024 ke orders fetch karo (MONTH filter).
select * from [Advance Excel Dataset]
where Order_Month='January'
and year(Order_Date)=2024;
--Delivery Status = “Late” wale orders show karo.
select * from [Advance Excel Dataset]
where Delivery_Status='delayed';
--Customer Segment = “Home Office” ke orders show karo.
select * from [Advance Excel Dataset]
where Customer_Segment='VIP';
--Region + Category dono filter together (multiple WHERE conditions).
select * from [Advance Excel Dataset]
where region='east'
and Product_Category='technology';
--? LEVEL 3 — AGGREGATION (GROUP BY)
--Region-wise Total Sales nikaalo.
select Region,sum(sales) as total_sales from [Advance Excel Dataset]
group by region
order by total_sales asc;
--Product Category-wise Total Profit.
select Product_Category, sum(profit) as total_profit from [Advance Excel Dataset]
group by Product_Category
order by total_profit asc;
--Month-wise Total Orders.
select order_month, count(*) as total_order from [Advance Excel Dataset]
group by Order_Month
order by total_order asc;
--Customer-wise Total Sales.
select Customer_Name, sum(sales) as total_sales from [Advance Excel Dataset]
group by Customer_Name
order by total_sales asc;
--Top selling Product Category by quantity.
select Product_Category, sum(quantity) as total_quantity from [Advance Excel Dataset]
group by Product_Category
order by total_quantity;
--Region-wise Avg Profit Margin.
select region, avg(profit_margin) as avg_profit_margin from [Advance Excel Dataset]
group by region
order by avg_profit_margin asc;
--Product-wise Average Discount.
select Product_Name ,avg(Discount) as avg_discount from [Advance Excel Dataset]
group by Product_Name
order by avg_discount asc;
--Region-wise Total Orders Count.
select Region ,count(*) as total_order from [Advance Excel Dataset]
group by region
order by total_order asc;
--Monthly Sales Trend (YEAR + MONTH group by).
select Year(Order_Date) as order_year,Order_Month,sum(sales) as total_sales from [Advance Excel Dataset]
group by Year(order_date),Order_Month
order by order_year, Order_Month;
--Delivery Status-wise Order Count.
select Delivery_Status, COUNT(*) AS total_order from [Advance Excel Dataset]
group by Delivery_Status
order by total_order asc;
--? LEVEL 4 — SORTING + LIMIT + TOP RECORDS
--Top 5 products by sales.
select top 5 Product_Name, Sales from [Advance Excel Dataset]
order by Sales desc ;
--Top 10 customers by profit.
select top 10 Customer_Name, profit from [Advance Excel Dataset]
order by profit desc ;
--Most selling region by quantity.
select Region,sum(Quantity) as total_QTY from [Advance Excel Dataset]
group by Region
order by total_QTY desc;
--Lowest 5 profit products.
select top 5 Product_Name, profit  from [Advance Excel Dataset]
order by profit asc;
--Highest Discounted Orders (Top 10).
select top 10 Customer_Name,discount from [Advance Excel Dataset]
order by Discount desc;
--? LEVEL 5 — JOINS (If you use dimension tables)
--(Optional, if dataset split into 2–3 tables)
--Orders table + Customer Table join karke customer details laao.
--Orders + Product table join kar ke Product Category fetch karo.
--Region Table join karke Region Type fetch karo.
--Customer + Orders join karke Total Sales per customer nikaalo.
--Segment-wise average sales join ke through find karo.
--? LEVEL 6 — DATE FUNCTIONS
--Order Date se month nikaal kar group karo.
select MONTH( order_date) as order_month, count(order_id) as total_orders from [Advance Excel Dataset]
group by month(order_date);
--Delivery Date – Order Date = Delivery Days calculate karo.
select Order_ID,Order_Date,Delivery_Date,DATEDIFF(day,Order_Date,Delivery_Date) as delivery_days from [Advance Excel Dataset];
--Year-wise Total Sales nikaalo.
select year(order_date) as order_year,sum(sales) as total_sales from [Advance Excel Dataset]
group by year(order_date)
order by total_sales desc;
--Weekday-wise number of orders.
select DATENAME(weekday,order_date) as weekday_name, count(order_id) as total_orders from [Advance Excel Dataset]
group by DATENAME(weekday,order_date);
--Customer age calculate karo (DATEDIFF).
select customer_name,DATEDIFF(year,birthdate,getdate()) as age from [Advance Excel Dataset];
--? LEVEL 7 — WINDOW FUNCTIONS (ADVANCED)--(Interview me bahut pooche jaate hain)
--Sales ranking (RANK() over).
select sales, rank() over(order by sales desc) as sales_rank from [Advance Excel Dataset]
--Running Total (SUM() OVER ORDER BY).
select sales,sum(sales) over(order by sales desc) as running_total from [Advance Excel Dataset]
--Region-wise sales ranking (PARTITION BY).
select region,Sales, rank() over( partition by region order by sales desc) from [Advance Excel Dataset];
--Top 3 products per category.
select Product_Name,Product_Category, Sales from ( 
select Product_Name,Product_Category, Sales, 
rank() over ( partition by product_category order by sales desc) as rnk from [Advance Excel Dataset]) t
where rnk<=3;
--Customer-wise cumulative profit.
select Customer_Name,profit,sum(profit) over(partition by customer_name order by profit desc) as cumulative_profit from [Advance Excel Dataset]
--? LEVEL 8 — CASE STATEMENT (Important)
--Profit Category banao:--Profit > 5000 = High--Profit > 2000 = Medium--Else = Low
select profit,
case
when profit>5000 then 'High_profit'
when profit>2000 then 'Medium_profit'
else 'low_profit'
end as Profit_category
from [Advance Excel Dataset];
--Discount > 0.20 ho to “High Discount”, warna “Normal”.
select Discount,
case
when Discount>0.20 then 'High_Disc'
else 'Normal_Disc'
end as Discount_Type
from [Advance Excel Dataset];
--Delivery Days > 5 ho to “Late”, warna “On Time”.
select Order_Date,Delivery_Date,
DATEDIFF(day,Order_Date,Delivery_Date) as delivery_days,
case
when DATEDIFF(day,Order_Date,Delivery_Date)>5 then 'Delayed'
else 'Delivered'
end as Delivery_Status
from [Advance Excel Dataset];
--? LEVEL 9 — ADVANCED ANALYTICS
--Month-over-Month Sales % change (LAG).
select Order_Month,sum(Sales) as monthly_sales, 
lag(sum(sales)) over(order by order_month) as prev_month_sales,(
(sum(sales)-lag(sum(sales)) over(order by order_month))/
nullif(lag(sum(sales)) over(order by order_month),0))*100 as mom_growth_percent
from [Advance Excel Dataset]
group by Order_Month
order by Order_Month;
--Year-over-Year Sales compare.
select year(Order_Date) as order_year,sum(Sales) as total_sales, 
lag(sum(sales)) over(order by year(Order_Date)) as prev_year_sales,(
(sum(sales)-lag(sum(sales)) over(order by year(Order_Date)))/
nullif(lag(sum(sales)) over(order by year(Order_Date)),0))*100 as yoy_growth_percent
from [Advance Excel Dataset]
group by year(Order_Date)
order by Order_year;
--Customer lifetime sales (SUM with window).
select customer_name, sales, sum(sales) over(partition by customer_name) as lifetime_sales
from [Advance Excel Dataset];
--Most frequent customer (MODE / COUNT).
select top 1 Customer_Name, count(*) as total_order from [Advance Excel Dataset]
group by Customer_Name
order by total_order desc;
--Profitability Index = Profit / Cost (calculated column).
select Product_Name,sales, cost,profit,(profit/nullif(cost,0)) as profitability_Index 
from [Advance Excel Dataset];
--Top region per product category (ROW_NUMBER).
select * from(
select Product_Category,Region,sum(Sales) as Total_Sales,
row_number() over(partition by Product_Category order by sum(Sales) desc) as rn
from [Advance Excel Dataset]
group by Product_Category, Region) x
where rn = 1;
--Customer Retention (distinct customers per year).
select year(Order_Date) as Order_Year,count(distinct Customer_Name) as Unique_Customers
from [Advance Excel Dataset]
group by year(Order_Date)
order by Order_Year;
--? LEVEL 10 — PROJECT-LEVEL QUESTIONS--(GitHub ke liye best)
--Build Sales Summary View (CREATE VIEW).
create view Sales_Summary as
select Region,Product_Category,sum(Sales) as Total_Sales,sum(Profit) as Total_Profit,sum(Quantity) as Total_Quantity
from [Advance Excel Dataset]
group by Region, Product_Category;
--Create Customer Performance Table (sales, profit, orders).
create view Customer_Performance as
select Customer_Name,count(Order_ID) as Total_Orders,sum(Sales) as Total_Sales,sum(Profit) as Total_Profit,sum(Quantity) as Total_Quantity
from [Advance Excel Dataset]
group by Customer_Name;
--Create Product Profitability Table.
create view Product_Profitability as
select Product_Name,Product_Category,sum(Sales) as Total_Sales,sum(Profit) as Total_Profit,sum(Cost) as Total_Cost, 
(sum(Profit) / nullif(sum(Cost),0)) as Profitability_Index
from [Advance Excel Dataset]
group by Product_Name, Product_Category;
--Find Delivery Efficiency Score (on-time %).
select count(*) as Total_Orders,
sum(case when Delivery_Date <= dateadd(day,5,Order_Date) then 1 else 0 end) as OnTime_Orders,
(sum(case when Delivery_Date <= dateadd(day,5,Order_Date) then 1 else 0 end) * 100.0)/ count(*) as OnTime_Percentage
from [Advance Excel Dataset];
--Build a full dashboard using SQL outputs.
---Region Sales
select region, sum(sales) as total_sales from [Advance Excel Dataset]
group by region;
---product-Category Profit
select Product_Category, sum(Profit) as category_profit from [Advance Excel Dataset]
group by Product_Category;
---Monthly Trend
select Order_Month, sum(Sales) as Monthly_Sales from [Advance Excel Dataset]
group by Order_Month;
---Customer Top 10
select top 10 Customer_Name, sum(Sales) as Sales from [Advance Excel Dataset]
group by Customer_Name
order by Sales desc;
--Detect duplicate orders (GROUP HAVING).
select Order_ID,count(*) as dup_count from [Advance Excel Dataset]
group by Order_ID
having count(*) > 1;
--Find Orders with abnormal profit margin (too high/low).
select Order_ID,Profit,Sales,(Profit / nullif(Sales,0)) as Profit_Margin from [Advance Excel Dataset]
where (Profit / nullif(Sales,0)) > 0.50 or (Profit / nullif(Sales,0)) < 0.05;
--Total EMI paid = LoanAmount × InterestRate logic apply.
select Loan_Amount,Interest_Rate,Tenure_Months,
(Loan_Amount * Interest_Rate * Tenure_Months) as Total_EMI_Paid
from [Advance Excel Dataset];
--Age group segmentation (CASE).
select Customer_Name,Age,
case
when Age < 18 then 'Minor'
when Age between 18 and 30 then 'Young Adult'
when Age between 31 and 50 then 'Adult'
else 'Senior'
end as Age_Group
from [Advance Excel Dataset];
--Customer value segmentation (High/Medium/Low).
select Customer_Name,sum(Sales) as Total_Sales,
case
when sum(Sales) > 10000 then 'High Value'
when sum(Sales) between 5000 and 10000 then 'Medium Value'
else 'Low Value'
end as Customer_Value
from [Advance Excel Dataset]
group by Customer_Name;