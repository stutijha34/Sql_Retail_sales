Create Database Retail;
use Retail
select * from dbo.Retail;
select count(*) from dbo.Retail;
-- findout the null values
select * from dbo.retail where transactions_id is null;
select * from dbo.Retail where sale_date is null;
select * from dbo.Retail where sale_time is null;
select * from dbo.Retail where customer_id is null;
select * from dbo.Retail where gender is null;
select * from dbo.Retail
where
age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;
--delet the null value row 
delete from dbo.Retail
where age is null
or category is null
or price_per_unit is null
or cogs is null
or total_sale is null

-- data exploration
--how many sales we have
select count(*) from dbo.Retail
-- how mnay customer we have
select count(customer_id) as total_sales from dbo.Retail
-- how mnay unique customer we have
select count(distinct customer_id) as total_sales from dbo.Retail
select count(distinct category) as total_sales from dbo.Retail
select distinct category from dbo.Retail

--data analysis and bussiness key problem and answers
--write  a sql query to retrieve all column  for sale made on '2022-11-09'
select * from dbo.Retail where sale_date = '2022-11-05';
---write a sql query to retrieve  all transaction where the category is 'clothing' and qunatity sold is more 
--than 4 in the month of nov 2022
select * from dbo.Retail where category = 'clothing'
and Format(sale_date,'yyyy-MM')= '2022-11'
and quantiy>=4

--write a sql qury to calculat the total_sale for each category
select sum(total_sale) total_sale,category from dbo.Retail
group by category

--write a sql query to fing the avg age of customer who purchased items from the 'beauty' category
select avg(age) age from dbo.Retail where category = 'Beauty'

--write a sql query to finf all transction where the total_sale is greather than 1000
select * from dbo.Retail where total_sale>1000
--write  a sql qury to find the tota numberr of transaction(transaction_id) made by each gender in each categoy
select COUNT(transactions_id)transactions_id,gender,category from dbo.Retail
group by gender,category order by category
--write a sql query to calculate the avg sale for each month fin out best selling month in each year
select * from(
select year(sale_date)year,month(sale_date) month,avg(total_sale) avg,
rank() over(partition by year(sale_date) order by avg(total_sale)) as rank
from dbo.Retail
group by 
year(sale_date),month(sale_date)
) as t1 
where rank =1 

--write a sql query to find top 5 customers based on the highest total sales
select top 5 customer_id,sum(total_sale) total_sale from dbo.Retail 
group by customer_id order by sum(total_sale)

--write a sql to find out the number of unique custoner who purchased item  from each cateogry
select count(distinct(customer_id)) ,category from
dbo.Retail group by category

--write a sql queryt to create each shift  and number of orders (example morning <=12,afternoon between 12 & 17,evening >17)
WITH hourly_sale 
as
(
select * ,
case 
when datepart(hour,sale_time)<=12 then 'Morning'
when datepart(hour,sale_time) between 12 and 17  then 'Afternoon'
when datepart(hour,sale_time) >17 then 'Evening'
end as shifts
from dbo.Retail
)
select 
shifts,count(*) as total_orded from hourly_sale
group by shifts
--end of project 
