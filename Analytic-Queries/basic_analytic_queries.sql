---average tip by paymant type
SELECT p.payment_type_name,AVG(f.tip_amount) FROM `uber-project-390417.uber_data_engineering_.fact_table` f
JOIN `uber-project-390417.uber_data_engineering_.payment_type_dim` p
ON p.payment_type_id = f.payment_type_id
GROUP BY p.payment_type_name;


---10 pickup locations based on the number of trips
SELECT p.pickup_longitude,pickup_latitude,STRING_AGG(CAST(pickup_location_id AS STRING), ',') AS location_ids,
    COUNT(*) AS number_of_trips
FROM 
    `uber-project-390417.uber_data_engineering_.pickup_location_dim` p
GROUP BY 
    pickup_longitude, 
    pickup_latitude
ORDER BY 
    number_of_trips DESC
LIMIT 10;

---Total number of trips by passenger count
SELECT 
    p.passenger_count,
    COUNT(f.trip_id) AS total_trips
FROM 
    `uber-project-390417.uber_data_engineering_.fact_table` f
JOIN 
    `uber-project-390417.uber_data_engineering_.passenger_count_dim` p ON f.passenger_count_id = p.passenger_count_id
GROUP BY 
    p.passenger_count
ORDER BY 
    total_trips DESC;

--Average fare amount by hour of the day

SELECT 
    d.pick_hour AS hour_of_day,
    AVG(f.fare_amount) AS average_fare
FROM 
    `uber-project-390417.uber_data_engineering_.fact_table` f
JOIN 
   `uber-project-390417.uber_data_engineering_.datetime_dim` d ON f.datetime_id = d.datetime_id
GROUP BY 
    hour_of_day
ORDER BY 
    hour_of_day;