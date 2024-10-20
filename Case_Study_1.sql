create database mr_exquisite;

--#Display the number of states present in the LocationTable.

SELECT COUNT(DISTINCT state) AS NumberOfStates
FROM Location;

--#How many products are of regular type?

SELECT COUNT(*) AS RegularProductCount
FROM Product
WHERE type = 'regular';

--#How much spending has been done on marketing of product ID 1?

SELECT SUM(Total_Expenses) AS TotalMarketingSpending
FROM fact
WHERE ProductId = 1;

--#What is the minimum sales of a product?

SELECT MIN(Product) AS MinimumSales
FROM Product;

--#Display the max Cost of Good Sold (COGS).

SELECT MAX(Budget_COGS) AS MaxCOGS
FROM fact;

--#Display the details of the product where product type is coffee.

SELECT *
FROM Product
WHERE product_type = 'coffee';

--#Display the details where total expenses are greater than 40.

SELECT *
FROM fact
WHERE total_expenses > 40;

--#What is the average sales in area code 719?

SELECT AVG(sales) AS AverageSales
FROM fact
WHERE area_code = 719;

--#Find out the total profit generated by Colorado state.

SELECT SUM(B.PROFIT) AS TotalProfit
FROM LOCATION AS A
LEFT JOIN FACT AS B
ON A.AREA_CODE = B.AREA_CODE
WHERE A.state = 'Colorado';

--#Display the average inventory for each product ID.

select 'ProductId', AVG(inventory) AS AverageInventory
from fact as a
left join product as b
on a.ProductId = b.ProductId
GROUP BY a.ProductId;

--#Display state in a sequential order in a Location Table.

SELECT state
FROM Location
ORDER BY state;

SELECT distinct state
FROM Location
ORDER BY state;

--#Display the average budget of the Product where the average budget margin should be greater than 100.

select Product, avg (Budget_Sales) as Average_Product_Budget
from product as a
left join fact as b
on a.ProductId = b.ProductId
where b.margin >100
group by a.Product;

--#What is the total sales done on date 2010-01-01?

SELECT SUM(sales) AS TotalSales
FROM fact
WHERE Date = '2010-01-01';

--#Display the average total expense of each product ID on an individual date.

SELECT productid, date, AVG(Total_Expenses) AS AverageExpense
FROM fact
GROUP BY productid, Date;

--#Display the table with the following attributes such as date, productID, product_type, product, sales, profit, state, area_code.

--DeCode>
--fact as a (date, productID, sales, profit)
--Location as b (state, area_code)
--Product as c (product_type, product)

CREATE TABLE New_table (
    date DATE,
    productID INT,
    product_type VARCHAR(255),
    product VARCHAR(255),
    sales DECIMAL(10, 2),
    profit DECIMAL(10, 2),
	state VARCHAR(255),
    area_code VARCHAR(10));

INSERT INTO New_table (date, productID, product_type, product, sales, profit, state, area_code)
SELECT 
    a.date, 
    a.productID, 
    c.product_type, 
    c.product, 
    a.sales, 
    a.profit, 
    b.state, 
    b.area_code
FROM 
    fact AS a
LEFT JOIN 
    Location AS b
	ON a.Area_Code = b.Area_Code
LEFT JOIN 
    Product AS c
	ON a.ProductId = c.ProductId;  -- Fixed ON condition

select * from new_table

--#Display the rank without any gap to show the sales wise rank

SELECT 
    productID,
    sales,
    DENSE_RANK() OVER (ORDER BY sales DESC) AS SalesRank
FROM 
    fact;

--#Find the state wise profit and sales

SELECT distinct state,
    SUM(sales) AS TotalSales,
    SUM(profit) AS TotalProfit
FROM fact as a
left join location as b
on a.area_code = b.Area_Code
GROUP BY state;

--#Find the state wise profit and sales along with the product name

--decode>
--fact as a (sales, profit)
--Location as b (state)
--Product as c (product)
SELECT 
    B.STATE,
    C.PRODUCT,
    SUM(A.SALES) AS TOTALSALES,
    SUM(A.PROFIT) AS TOTALPROFIT
FROM FACT AS A
LEFT JOIN PRODUCT AS C
ON A.PRODUCTID = C.PRODUCTID
LEFT JOIN LOCATION AS B
ON A.AREA_CODE = B.AREA_CODE
GROUP BY B.STATE, C.PRODUCT
ORDER BY B.STATE, C.PRODUCT;

--#If there is an increase in sales of 5%, calculate the increasedsales

SELECT 
    productID,
    sales,
    sales * 1.05 AS IncreasedSales  -- Calculate increased sales
FROM 
    fact;

--practice
	SELECT 
    b.state,
    c.product,
    SUM(a.sales) AS TotalSales,
    SUM(a.sales) * 1.05 AS IncreasedSales,  -- Calculate increased sales
    SUM(a.profit) AS TotalProfit
FROM 
    fact AS a
LEFT JOIN 
    product AS c ON a.productID = c.productID
LEFT JOIN 
    location AS b ON a.area_code = b.area_code
GROUP BY 
    b.state, c.product
ORDER BY 
    b.state, c.product;

--#Find the maximum profit along with the product ID and producttype.

SELECT 
    f.productID,
    p.product_type,
    MAX(f.profit) AS MaxProfit
FROM 
    fact AS f
JOIN 
    product AS p ON f.productID = p.productID
GROUP BY 
    f.productID, p.product_type
ORDER BY 
    MaxProfit DESC;

--practice
	SELECT 
    f.productID,
    p.product_type,
    f.profit
FROM 
    fact AS f
JOIN 
    product AS p ON f.productID = p.productID
WHERE 
    f.profit = (SELECT MAX(profit) FROM fact);

--#Create a stored procedure to fetch the result according to the product type from Product Table.

CREATE PROCEDURE GetProductsByType
    @ProductType VARCHAR(255)
AS
BEGIN
    SELECT 
        ProductID,
        Product,
        Product_Type
    FROM 
        Product
    WHERE 
        Product_Type = @ProductType;
END;

EXEC GetProductsByType @ProductType = 'YourProductType';

--#Write a query by creating a condition in which if the total expenses is less than 60 then it is a profit or else loss.

SELECT 
    ProductId,
	Total_Expenses AS TotalExpenses,
    CASE 
        WHEN Total_expenses < 60 THEN 'Profit'
        ELSE 'Loss'
    END AS ProfitLossStatus
FROM fact;

--#Give the total weekly sales value with the date and product ID details. Use roll-up to pull the data in hierarchical order

SELECT 
    DATEPART(YEAR, date) AS SalesYear, 
    DATEPART(WEEK, date) AS SalesWeek, 
    productID,
    SUM(sales) AS TotalSales
FROM fact
GROUP BY 
ROLLUP(DATEPART(YEAR, date), DATEPART(WEEK, date), productID)
ORDER BY SalesYear, SalesWeek, productID;

--#Apply union and intersection operator on the tables which consist of attribute area code.

SELECT area_code 
FROM fact

INTERSECT

SELECT area_code 
FROM location;

--#Create a user-defined function for the product table to fetch a particular product type based upon the user’s preference.

CREATE FUNCTION GetProductsByType_1
(@ProductType VARCHAR(255))
RETURNS TABLE 
AS
RETURN
(SELECT 
        ProductID,
        Product,
        Product_Type
  FROM 
        Product
    WHERE 
        Product_Type = @ProductType  );

SELECT *
FROM GetProductsByType_1('Coffee');

--#Change the product type from coffee to tea where product ID is 1 and undo it.

BEGIN TRANSACTION;

-- Step 1: Change product type to tea
UPDATE Product
SET Product_Type = 'tea'
WHERE ProductID = 1;

-- Step 2: Undo the change by changing it back to coffee
UPDATE Product
SET Product_Type = 'coffee'
WHERE ProductID = 1;

COMMIT TRANSACTION;  -- Commit the changes

--#Display the date, product ID and sales where total expenses are between 100 to 200.

SELECT 
    date, 
    ProductID, 
    sales 
FROM fact 
WHERE Total_Expenses BETWEEN 100 AND 200;  -- Filter for total expenses between 100 and 200

--#Delete the records in the Product Table for regular type

BEGIN TRANSACTION;

DELETE FROM Product
WHERE Product_Type = 'regular';

COMMIT TRANSACTION;  -- Commit the changes if everything is fine

--#Display the ASCII value of the fifth character from the columnProduct

SELECT 
    Product,
    ASCII(SUBSTRING(Product, 5, 1)) AS FifthCharacterASCII  -- Extracts the 5th character and gets its ASCII value
FROM 
    Product;  -- Replace with your actual table name
