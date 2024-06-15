SELECT * FROM smartphones;

#Find the number of brands, and models in a store and, the number of models per brand.
select count(distinct brand_name), count(distinct model) from smartphones;

#check the number of models with rolling sum using the window function.
with cte as (
select brand_name, count(distinct model) number_of_models from smartphones
group by brand_name)
select c.*, sum(c.number_of_models) over(order by number_of_models desc) as total_number_of_models from cte c;


#total price of each brand’s mobiles, models, and also brands and their models.
select brand_name, sum(price) total_cost from smartphones group by brand_name order by 1 asc;
select model, sum(price) total_cost from smartphones group by model order by 1 asc;
select brand_name,model, sum(price) total_cost from smartphones group by brand_name, model order by 1 asc;

#Top 3 Highest rating brands and models.
select model, brand_name, rating from (
select brand_name, rating, model,dense_rank() over(order by rating desc) as rnk from smartphones) a
where a.rnk<=3 order by rnk limit 3;


#mobiles that do not have 5g or have ir blaster.
select model from smartphones
where has_5g= 0 or has_ir_blaster=1;


#Number of processor brands are available? and the number of models per each brand.
select count(distinct processor_brand) number_of_processor_brand from smartphones;

SELECT 
    processor_brand, COUNT(model)
FROM
    smartphones
WHERE
    processor_brand IS NOT NULL
GROUP BY processor_brand
ORDER BY 2 DESC;


#number of cores per model. rank them by the number of cores.
select * from ( select distinct model, num_cores as number_of_cores, dense_rank() over(order by number_of_cores)  as rnk from smartphones ) a
order by 3;


#Highest processor speed as per model and brand.
select brand_name, model, processor_speed from(
select brand_name, model, processor_speed, dense_rank() over(order by processor_speed desc) as rnk
from SmartPhones)a where a.rnk=1;


#Top 5 highest battery capacity models & their brands.
select brand_name, model, battery_capacity from (
select brand_name, model, battery_capacity, dense_rank() over(order by battery_capacity desc) as rnk 
from SmartPhones)a where a.rnk<=5 limit 5;


#list the top 5 brands & models that have the highest RAM capacity and internal memory.
select brand_name, model, ram_capacity, internal_memory from(
select brand_name, model, ram_capacity, internal_memory, dense_rank() over(order by ram_capacity desc, internal_memory desc) as
rnk from smartphones)a where rnk <=5;

#List the top 10 models & brands that have less screen size.
select brand_name, model, screen_size from(
select brand_name, model, screen_size, dense_rank() over(order by screen_size) as rnk from SmartPhones)a
where a.rnk<=10;








