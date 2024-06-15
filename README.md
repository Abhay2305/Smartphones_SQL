
### SQL Functions Overview

In addition to the machine learning tasks, we performed several SQL queries to analyze smartphone data. Here is an overview of the functions and queries used:

1. **List the top 10 models & brands with the smallest screen size**:
    ```sql
    SELECT brand_name, model, screen_size FROM (
        SELECT brand_name, model, screen_size, DENSE_RANK() OVER(ORDER BY screen_size) AS rnk 
        FROM SmartPhones
    ) a
    WHERE a.rnk <= 10;
    ```

2. **List the top 5 brands & models with the highest RAM capacity and internal memory**:
    ```sql
    SELECT brand_name, model, ram_capacity, internal_memory FROM (
        SELECT brand_name, model, ram_capacity, internal_memory, DENSE_RANK() OVER(ORDER BY ram_capacity DESC, internal_memory DESC) AS rnk 
        FROM SmartPhones
    ) a 
    WHERE rnk <= 5;
    ```

3. **Top 5 highest battery capacity models & their brands**:
    ```sql
    SELECT brand_name, model, battery_capacity FROM (
        SELECT brand_name, model, battery_capacity, DENSE_RANK() OVER(ORDER BY battery_capacity DESC) AS rnk 
        FROM SmartPhones
    ) a 
    WHERE a.rnk <= 5 
    LIMIT 5;
    ```

4. **Highest processor speed per model and brand**:
    ```sql
    SELECT brand_name, model, processor_speed FROM (
        SELECT brand_name, model, processor_speed, DENSE_RANK() OVER(ORDER BY processor_speed DESC) AS rnk 
        FROM SmartPhones
    ) a 
    WHERE a.rnk = 1;
    ```

5. **Number of cores per model, ranked by number of cores**:
    ```sql
    SELECT * FROM (
        SELECT DISTINCT model, num_cores AS number_of_cores, DENSE_RANK() OVER(ORDER BY num_cores) AS rnk 
        FROM SmartPhones
    ) a 
    ORDER BY 3;
    ```

6. **Number of processor brands available and the number of models per each brand**:
    ```sql
    SELECT COUNT(DISTINCT processor_brand) AS number_of_processor_brand 
    FROM SmartPhones;

    SELECT processor_brand, COUNT(model) 
    FROM SmartPhones 
    WHERE processor_brand IS NOT NULL 
    GROUP BY processor_brand 
    ORDER BY 2 DESC;
    ```

7. **Models that do not have 5G or have an IR blaster**:
    ```sql
    SELECT model 
    FROM SmartPhones 
    WHERE has_5g = 0 OR has_ir_blaster = 1;
    ```

8. **Top 3 highest rating brands and models**:
    ```sql
    SELECT model, brand_name, rating FROM (
        SELECT brand_name, rating, model, DENSE_RANK() OVER(ORDER BY rating DESC) AS rnk 
        FROM SmartPhones
    ) a 
    WHERE a.rnk <= 3 
    ORDER BY rnk 
    LIMIT 3;
    ```

9. **Total price of each brand’s mobile models**:
    ```sql
    SELECT brand_name, SUM(price) AS total_cost 
    FROM SmartPhones 
    GROUP BY brand_name 
    ORDER BY 1 ASC;

    SELECT model, SUM(price) AS total_cost 
    FROM SmartPhones 
    GROUP BY model 
    ORDER BY 1 ASC;

    SELECT brand_name, model, SUM(price) AS total_cost 
    FROM SmartPhones 
    GROUP BY brand_name, model 
    ORDER BY 1 ASC;
    ```

These queries help in extracting useful insights about the smartphone models based on various features like screen size, RAM capacity, battery capacity, processor speed, number of cores, and more.
