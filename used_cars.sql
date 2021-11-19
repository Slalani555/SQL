CREATE DATABASE used_cars_clean;
USE used_cars_clean;
SELECT * from used_cars_clean LIMIT 10;

SELECT Count(DISTINCT MODEL) from used_cars_clean;

SELECT DISTINCT BRAND, MODEL from used_cars_clean;

Select Distinct Fuel_type from used_cars_clean;

SELECT * from used_cars_clean where BRAND IN ('maruti suzuki');

SELECT BRAND from used_cars_clean  where Location NOT IN ('Ahmedabad');

Select * FROM used_cars_clean WHERE Year > 2014;

SELECT avg(Price) FROM used_cars_clean WHERE BRAND='maruti suzuki';

SELECT avg(Price) FROM used_cars_clean WHERE BRAND='honda';

SELECT Count(*) FROM used_cars_clean WHERE Model='Swift VDI';

Select c.Brand,c.Model,c.Fuel_type from used_cars_clean c where Transmission='Automatic';

Select Brand,MODEL, round(avg(Price),2) as Average_Price from used_cars_clean 
GROUP BY MODEL;

Select DISTINCT Model, length(Model) as length_Model from used_cars_clean; 

Select LOCATION,BRAND,Model, COUNT(Model) from used_cars_clean
WHERE Transmission='Manual' 
GROUP BY Location
HAVING COUNT(MODEL)>300;

Select Count(*) from used_cars_clean 
WHERE Fuel_Type <> 'Diesel';

-- Extract records those hase two t's in the Brand
Select * from used_cars_clean
WHERE length(Brand)-length(replace(upper(Brand),'T',''))=2;

Select substr("maruti suzuki",1,6);

Select substring("maruti suzuki",8,6);














