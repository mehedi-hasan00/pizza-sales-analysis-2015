-- Total Revenue
select round(sum(total_price),2) as total_revenue
from pizza_sales;

-- Average Order Value
SELECT round(SUM(total_price)/COUNT(DISTINCT(order_id)),2) AS Avg_Order_Value
FROM pizza_sales;

-- Total Pizza Sold
select SUM(quantity) as Total_pizza_sold
from pizza_sales;

-- Total Orders

SELECT count(DISTINCT(order_id)) as Total_Orders
FROM pizza_sales;

-- Average Pizza per Orders

SELECT round(SUM(quantity)/ COUNT(DISTINCT(order_id)),2) as Avg_pizza_orders
FROM pizza_sales;


-- Daily Trend for Total Orders

SELECT dayname(order_date) as Day_Name , 
count(distinct order_id) as Total_Orders
from pizza_sales
group by dayname(order_date)
ORDER BY FIELD(Day_Name, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');



-- Hourly Trend for Total Orders

select hour(order_time) as Order_hour,
count(distinct order_id) as Total_Orders
from pizza_sales
group by hour(order_time);


-- Shift Wise Trend for Total Orders and Total Revenue

select 
	case 
		when hour(order_time) between 9 and 11 then 'Morning'
        when hour(order_time) between 12 and 15 then 'Lunch'
        when hour(order_time) between 16 and 18 then 'Afternoon'
        when hour(order_time) between 19 and 23 then 'Dinner'
        else 'Others'
        end as Shift_name,
	count(distinct order_id) as Total_Order,
    round(sum(total_price),2) as Total_Revenue
    
from pizza_sales
group by Shift_name
order by field(Shift_name, 'Morning','Lunch','Afternoon','Dinner','Others');
        

-- Percentage of Sales by Pizza Category

select pizza_category,
round(sum(total_price)/(select sum(total_price) from pizza_sales) * 100,2) as Sales_Percentage
from pizza_sales
group by pizza_category;

-- Percentage of Sales by Pizza Size

select pizza_size,
round(sum(total_price),2) as Total_Sales,
round(sum(total_price)/(select sum(total_price) from pizza_sales) * 100,2) as Sales_Percentage
from pizza_sales
group by pizza_size;

-- Total Pizza Sold by Pizza Category

select pizza_category,
sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_category;

-- Top 5 Best Sales Pizza(name) by Total Pizza Sold

select pizza_name,
sum(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_name
order by 2 desc
limit 5;

-- Top 5 Worst Sales Pizza(name) by Total Pizza Sold

select pizza_name,
sum(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_name
order by 2 asc
limit 5;



































































































