/*
    Modify this query so that the GROUP BY and the HAVING clauses also use the [Order ID] column alias.
    What happens? Why?
*/
SELECT OrderID AS [Order ID], SUM(Quantity) AS Sum_Qty
FROM Sales.OrderLines
WHERE UnitPrice > 10
GROUP BY OrderID
HAVING OrderID IN (46, 47, 48)
ORDER BY [Order ID] ASC;

-- Invalid Column name, the clauses can't use aliases
SELECT OrderID AS [Order ID], SUM(Quantity) AS Sum_Qty
FROM Sales.OrderLines
WHERE UnitPrice > 10
GROUP BY [Order ID]
HAVING [Order ID] IN (46, 47, 48)
ORDER BY [Order ID] ASC;

USE WideWorldImporters;

/*
    Modify this query so that you add a third column in the SELECT list: (Sum_Qty - 10) AS Reduced_Qty
    What happens? Why?

    How would you resolve the problem and add the Reduced_Qty column so that the query works?


    | Order ID | Sum_Qty | Reduced_Qty |
    ------------------------------------

*/

SELECT OrderID AS [Order ID], SUM(Quantity) AS Sum_Qty
FROM Sales.OrderLines
WHERE UnitPrice > 10
GROUP BY OrderID
HAVING OrderID IN (46, 47, 48)
ORDER BY [Order ID] ASC;

/* invalid colum name
SELECT OrderID AS [Order ID], SUM(Quantity) AS Sum_Qty,(Sum_Qty - 10) AS Reduced_Qty
FROM Sales.OrderLines
WHERE UnitPrice > 10
GROUP BY OrderID
HAVING OrderID IN (46, 47, 48)
ORDER BY [Order ID] ASC;
*/
-- the working solution
SELECT OrderID AS [Order ID], SUM(Quantity) AS Sum_Qty,(SUM(Quantity) - 10) AS Reduced_Qty
FROM Sales.OrderLines
WHERE UnitPrice > 10
GROUP BY OrderID
HAVING OrderID IN (46, 47, 48)
ORDER BY [Order ID] ASC;

USE WideWorldImporters;

/*
    Modify this query so that you alias the Sales.OrderLines table.
    Then qualify the column names in the SELECT list with the table alias.
*/
SELECT SO.OrderID AS [Order ID], SUM(SO.Quantity) AS Sum_Qty
FROM Sales.OrderLines AS SO
WHERE UnitPrice > 10
GROUP BY OrderID
HAVING OrderID IN (46, 47, 48)
ORDER BY [Order ID] ASC;


USE WideWorldImporters;

/*
    Remove the TOP 10 filter and see how many rows are returned.
    Apply a TOP ten percent filter instead and see how many rows are returned.
    Try different filter and percent values.
*/
SELECT TOP 10 PERCENT OrderID AS [Order ID], SUM(Quantity) AS Sum_Qty
FROM Sales.OrderLines
WHERE UnitPrice > 10
GROUP BY OrderID
ORDER BY [Order ID] ASC;

USE WideWorldImporters;

/*
    Run the following query and see the results. What do you see? 10 results
    Modify the query to use the TOP filter WITH TIES. What happens? a lot of results because of the equal vaules
    Modify the query to remove duplicates and then return the TOP 10 UnitPrice. What happens? 10 results again
*/
SELECT distinct TOP 10 WITH TIES UnitPrice
FROM Sales.OrderLines
ORDER BY UnitPrice DESC;

USE WideWorldImporters;

/*
    Find the table that contains data about cities.
    Write a query that returns the 10 cities with the highest population.
    Alias the city population column as [population].

    | CityID | CityName | population |
    ----------------------------------

*/
SELECT TOP (10) [CityID]
      ,[CityName]
      ,[LatestRecordedPopulation] AS population
  FROM [WideWorldImporters].[Application].[Cities]

  USE WideWorldImporters;

/*
    Find the table where there are order dates.
    Write a query that returns the distinct order dates in descending order.
    Alias the returned column as [Order Date].

    | Order Date |
    --------------

    Try using a different ordering, not on order date. What happens?

*/
SELECT DISTINCT
      [OrderDate] AS [Order Date]
  FROM [WideWorldImporters].[Sales].[Orders]
  ORDER BY [OrderDate] DESC;

  USE WideWorldImporters;

/*
    Find the table that contains data about cities.
    Write a query that returns the 10 cities with the highest population, but use the paging method.
    Alias the city population column as [population].


    | CityID | CityName | population |
    ----------------------------------

*/
SELECT [CityID]
      ,[CityName]
      ,[LatestRecordedPopulation] AS [population]
  FROM [WideWorldImporters].[Application].[Cities]
  ORDER BY [LatestRecordedPopulation] DESC
   OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

   USE WideWorldImporters;

/*

    Write a query for the Sales.OrderLines table that returns:
    - unique stock items and their descriptions
    - ordered by stock item ID in ascending order
    - skip the first 29 rows then return only the next 50 rows


    | StockItemID | Description |
    -----------------------------

*/
SELECT  distinct [StockItemID]
      ,[Description]
  FROM [WideWorldImporters].[Sales].[OrderLines]
      ORDER BY StockItemID
      OFFSET 29 ROWS FETCH NEXT 50 ROWS ONLY;
