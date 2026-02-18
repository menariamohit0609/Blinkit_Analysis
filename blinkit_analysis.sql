create database BlinkitDb;

ALTER TABLE blinkit_data
RENAME COLUMN `Item Fat Content` TO Item_Fat_Content,
RENAME COLUMN `Item Identifier` TO Item_Identifier,
RENAME COLUMN `Item Type` TO Item_Type,
RENAME COLUMN `Outlet Establishment Year` TO Outlet_Establishment_Year,
RENAME COLUMN `Outlet Identifier` TO Outlet_Identifier,
RENAME COLUMN `Outlet Location Type` TO Outlet_Location_Type,
RENAME COLUMN `Outlet Size` TO Outlet_Size,
RENAME COLUMN `Outlet Type` TO Outlet_Type,
RENAME COLUMN `Item Visibility` TO Item_Visibility,
RENAME COLUMN `Item Weight` TO Item_Weight;

UPDATE blinkit_data
SET Item_Fat_Content =
    CASE
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END
WHERE Item_Fat_Content IN ('LF', 'low fat', 'reg');


SELECT * FROM blinkit_data;

SELECT CAST(SUM(Sales)/1000000  AS DECIMAL(10,2)) AS Sales_Millions FROM blinkit_data
where Outlet_Establishment_Year=2022;

SELECT CAST(AVG(Sales) AS DECIMAL(10,0 )) AS Avg_Sales FROM blinkit_data;

SEleCT COUNT(*) AS No_Of_Items FROM blinkit_data;

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating FROM blinkit_data;

SELECT Outlet_Location_Type,
CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
 CAST(AVG(Sales) AS DECIMAL(10,2 )) AS Avg_Sales,
CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
COUNT(*) AS No_Of_Items  
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales  DESC ;


-- SELECT 
--     Outlet_Location_Type,
--     CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
--     CAST(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER ()
--         AS DECIMAL(10,2)
--     ) AS Sales_Percentage
-- FROM blinkit_data
-- GROUP BY Outlet_Location_Type,
-- ORDER BY Total_Sales DESC;

