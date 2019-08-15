/*
1 - Select the names of all the products in the store.
*/
SELECT
	Name
FROM
	Products;

/*
2 - Select the names and the prices of all the products in the store.
*/
SELECT
	Name,
	Price
FROM
	Products;

/*
3 - Select the name of the products with a price less than or equal to $200.
*/
SELECT
	Name,
	Price
FROM
	Products
WHERE
	Price <= 200;

/*
4 - Select all the products with a price between $60 and $120.
*/
SELECT
	Name,
	Price
FROM
	Products
WHERE
	Price BETWEEN 60 AND 120;

/*
5 - Select the name and price in cents (i.e., the price must be multiplied by 100).
*/
SELECT
	Name,
	Price * 100
FROM
	Products;

/*
6 - Compute the average price of all the products.
*/
SELECT
	AVG(Price)
FROM
	Products;

/*
7 - Compute the average price of all products with manufacturer code equal to 2.
*/
SELECT
	AVG(Price)
FROM
	Products
WHERE
	Manufacturer = 2;

/*
8 - Compute the number of products with a price larger than or equal to $180.
*/
SELECT
	COUNT(Code)
FROM
	Products
WHERE
	Price >= 180;

/*
9 - 
Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
*/
SELECT
	Name,
	Price
FROM
	Products
WHERE
	Price >= 180
ORDER BY
	Price DESC, Name;

/*
10 - Select all the data from the products, including all the data for each product's manufacturer.
*/
SELECT
	*
FROM
	Products P
    JOIN Manufacturers M
		ON P.Manufacturer = M.Code;

/*
11 - 
Select the product name, price, and manufacturer name of all the products.
*/
SELECT
	P.Name,
	P.Price,
	M.Name
FROM
	Products P
    JOIN Manufacturers M
		ON P.Manufacturer = M.Code;


/*
12 - 
Select the average price of each manufacturer's products, showing only the manufacturer's code.
*/
SELECT
	AVG(Price),
	Manufacturer
FROM
	Products
GROUP BY
	Manufacturer;

/*
13 - 
Select the average price of each manufacturer's products, showing the manufacturer's name.
*/
SELECT
	Name,
	AVG_Price
FROM
	(SELECT
			M.Code,
			M.Name,
			AVG(P.price) AS AVG_Price
		FROM
			Products P
			JOIN Manufacturers M
				ON P.Manufacturer = M.Code
		GROUP BY
			M.Code,
			M.Name) AS tmp;

/*
14 - 
Select the names of manufacturer whose products have an average price larger than or equal to $150.
*/
SELECT
	Name,
	AVG_Price
FROM
	(SELECT
		M.Code,
		M.Name,
		AVG(P.price)  AS AVG_Price
	FROM
		Products P
		JOIN Manufacturers M
			ON P.Manufacturer = M.Code
	GROUP BY
		M.Code,
		M.Name
	HAVING
		AVG_Price = 150) AS tmp;

/*
15 - 
Select the name and price of the cheapest product.
*/
SELECT
	Name,
	Price
FROM
	Products
WHERE
	Price = 
		(SELECT
			MIN(Price)
		FROM
			Products);

/*
16 - 
Select the name of each manufacturer along with the name and price of its most expensive product.
*/
SELECT
	M1.Name,
	M2.Name,
	M2.Price
FROM
	Manufacturers M1
	JOIN
	(SELECT
		P1.Name,
		P1.Manufacturer,
		P1.Price
	FROM
		Products P1
	WHERE P1.Price >= (
		SELECT
			MAX(P2.Price)
		FROM
			Products P2
		WHERE
			(P1.Manufacturer = P2.Manufacturer)
		)) AS M2
	ON M1.Code = M2.Manufacturer;

-- OR
SELECT
	M.Name,
	P1.Name,
	P2.Max_price
FROM
	Products P1
	JOIN	
		(SELECT
			Manufacturer,
			MAX(Price) AS Max_price
		FROM
			Products
		GROUP BY
			Manufacturer) AS P2
		ON (P1.Manufacturer = P2.Manufacturer AND P1.Price = P2.Max_price)
	JOIN
		Manufacturers M
		ON M.Code = P1.Manufacturer;
-- OR
SELECT
    M.Name,
	P1.Name,
    P1.Price
FROM
	Products P1
    LEFT JOIN Products P2
		ON (P1.Manufacturer = P2.Manufacturer AND P1.Price < P2.Price)
	JOIN Manufacturers M
		ON M.Code = P1.Manufacturer
WHERE
	P2.Price IS NULL;

/*
17 - Add a new product: Loudspeakers, $70, manufacturer 2.
*/
INSERT INTO Products VALUES (11,'Loudspeakers',70,2);

/*
18 - 
Update the name of product 8 to "Laser Printer".
*/
UPDATE Products
SET
	Name = 'Laser Printer'
WHERE
	Code = 8;

/*
19 - Apply a 10% discount to all products.
*/
UPDATE Products
SET
	Price = 0.9 * Price;

/*
20 - Apply a 10% discount to all products with a price larger than or equal to $120.
*/
UPDATE Products
SET
	Price = 0.9 * Price
WHERE
	Price >= 120;


INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Laser Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);
INSERT INTO Products VALUES (11,'Loudspeakers',70,2);
INSERT INTO Products VALUES (12,'ABC',700,2);