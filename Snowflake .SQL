 SELECT
  count(transaction_id) AS Number_of_sales,
  sum(transaction_qty*unit_price) AS Total_Revenue,
  sum(transaction_qty) AS Number_of_unit_sold,
  
  product_category,product_type,product_detail,store_location,

  DAYNAME(TRANSACTION_DATE) AS day_name,
  MONTHNAME(TRANSACTION_DATE) AS month_name,
  TO_CHAR(TO_DATE(TRANSACTION_DATE),'YYYYMM') AS month_id,

  CASE
  when transaction_time between'6:00:00' AND '11:59:59' then'morning'
  when transaction_time between'12:00:00' AND '15:59:59' then 'afternoon'
  when transaction_time between'16:00:00' AND '20:59:59' then 'evening'
  else 'night'
  END AS Time_Bucket, 

  CASE
  when sum(transaction_qty*unit_price) between 0 and 20 then 'low'
  when sum(transaction_qty*unit_price) between 21 and 40 then 'medium'
  when sum(transaction_qty*unit_price) between 41 and 60 then 'high'
  else 'very high'
  END AS spending_bucket,

   FROM
  "BRIGHTLIGHT"."COFFEESHOP"."COFFEESALES"

  GROUP BY product_category,Time_Bucket,
  product_detail,product_type,store_location,day_name,month_name,month_id;


   
