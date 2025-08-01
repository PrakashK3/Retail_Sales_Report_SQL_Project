-- Data Cleaning
--Null Values Checking 
select * from retail_sales 
		 where 
		 sale_date is null
		 or
		  transactions_id is null
		 or
		  sale_time is null
		 or
		  customer_id is null
		 or
		  gender is null
		 or
		  age is null
		 or
		  category is null
		 or
		  quantiy is null
		 or
		  price_per_unit is null
		 or
		  purchase_cost is null
		 or
		  total_sale is null
-- Null Values Deletion
delete from retail_sales 
		 where 
		 sale_date is null
		 or
		  transactions_id is null
		 or
		  sale_time is null
		 or
		  customer_id is null
		 or
		  gender is null
		 or
		  age is null
		 or
		  category is null
		 or
		  quantiy is null
		 or
		  price_per_unit is null
		 or
		  purchase_cost is null
		 or
		  total_sale is null
-- Data Exploration
-- How many transactions we have ?
       select
	        count(transactions_id) as No_of_transactions from retail_sales
			
-- How many Unique customers we have ?
       select 
            count(distinct customer_id) as unique_customers from retail_sales
			
-- How many Unique category we have ?
       select
	        count(distinct category) as Unique_category from retail_sales
			
-- Data Analysis
-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
       select * from retail_sales
            where sale_date =  '2022-11-05'
  
-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
       select * from retail_sales
	        where category = 'Clothing'
	        and quantiy >= 4
	        and to_char(sale_date,'yyyy-mm')='2022-11'
	 
-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.:
        select
		     category, sum(total_sale) as total_sales from retail_sales
             group by category

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
         select round(avg(age),0) as Avg_age from retail_sales
	          where category = 'Beauty'

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
         select * from retail_sales 
              where total_sale > 1000
	
-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
         select 
		      count(category), gender, category from retail_sales
	          group by gender, category
	          order by count desc
	
-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
         select * from  
              (select 
                  Extract(year from sale_date) as year, 
	              extract (month from sale_date) as month,
	              avg(total_sale) as avg_sale, 
	              RANK() OVER (PARTITION BY Extract(year from sale_date) 
                  ORDER BY avg(total_sale) DESC) as rank
                  from retail_sales
                  group by 1,2)
	              where rank = '1'

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales:
        select sum(total_sale) as total_sales, customer_id from retail_sales
	         group by customer_id
	         order by total_sales desc
	         limit 5
-- 9.Write a SQL query to find the number of unique customers who purchased items from each category.:
         select 
		      category,count(distinct customer_id) as No_of_customers
			  from retail_sales
		      group by category
			  
-- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
          with hourly_sales as
             (select *,
		       case
			     when extract (hour from sale_time) < 12 then 'Morning'
				 when extract (hour from sale_time)between 12 and 17 then 'Afternoon'
				 else 'Evening'
			  end as shift	 
		 from retail_sales)
		 select shift, count(transactions_id) as Total_orders from hourly_sales
		     group by shift

--End		 