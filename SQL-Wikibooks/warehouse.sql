/*
1 - Select all warehouses.
*/
SELECT
	*
FROM
	Warehouses;	

/*
2 - Select all boxes with a value larger than $150.
*/
SELECT
	*
FROM
	Boxes
WHERE
	value > 150;

/*
3 - Select all distinct contents in all the boxes.
*/
SELECT DISTINCT
	Contents 
FROM
	Boxes;

/*
4 - Select the average value of all the boxes.
*/
SELECT
	AVG(value)
FROM
	Boxes;

/*
5 - Select the warehouse code and the average value of the boxes in each warehouse.
*/
SELECT
	Warehouse,
    AVG(value)
FROM
	Boxes
GROUP BY
	Warehouse;

/*
6 - Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
*/
SELECT
	Warehouse,
    AVG(value)
FROM
	Boxes
GROUP BY
	Warehouse
HAVING
	AVG(value) > 150;

/*
7 - Select the code of each box, along with the name of the city the box is located in.
*/
SELECT
	B.Code,
    W.Location
FROM
	Boxes B
    JOIN Warehouses W
		ON B.Warehouse = W.Code;

/*
8 - Select the warehouse codes, along with the number of boxes in each warehouse.
Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
*/
SELECT
	W.Code,
    COUNT(B.Code)
FROM
	Warehouses W
    LEFT JOIN Boxes B
		ON W.Code = B.Warehouse
GROUP BY
	W.Code;

/*
9 - Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
*/
SELECT
	W1.Code
FROM
	Warehouses W1
	JOIN
	(SELECT
			W.Code,
		    COUNT(B.Code) AS Total_box
		FROM
			Warehouses W
		    LEFT JOIN Boxes B
				ON W.Code = B.Warehouse
		GROUP BY
			W.Code) W2
	ON W1.Code = W2.Code
WHERE
	W1.Capacity < W2.Total_box;

--OR

SELECT
	W.Code
FROM
	Warehouses W
WHERE
	W.Capacity < (
			SELECT
				COUNT(B.Code)
			FROM
				Boxes B
			WHERE
				B.Warehouse = W.Code
    );

/*
10 - Select the codes of all the boxes located in Chicago.
*/
SELECT
	B.Code
FROM
	Boxes B
	JOIN Warehouses W
		ON B.Warehouse = W.Code
WHERE
	W.Location = 'Chicago';

/*
11 - Create a new warehouse in New York with a capacity for 3 boxes.
*/
INSERT INTO Warehouses VALUES (6,'New York',3);

/*
12 - Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
*/
INSERT INTO Boxes VALUES ('H5RT','Papers',200,2);


/*
13 - Reduce the value of all boxes by 15%.
*/
UPDATE Boxes
SET value = 0.85*value;

/*
14 - Apply a 20% value reduction to boxes with a value larger than the average value of all the boxes.
*/
UPDATE Boxes
SET value = 0.80*value
WHERE
	value > (SELECT AVG(value) FROM (SELECT value FROM Boxes) AS B);

/*
15 - Remove all boxes with a value lower than $100.
*/
DELETE FROM Boxes
WHERE
	value < 100;

/*
16 - Remove all boxes from saturated warehouses.
*/
DELETE FROM Boxes
WHERE Warehouse IN 
	(SELECT
		W1.Code
	FROM
		Warehouses W1
		JOIN
		(SELECT
				W.Code,
			    COUNT(B.Code) AS Total_box
			FROM
				Warehouses W
			    LEFT JOIN Boxes B
					ON W.Code = B.Warehouse
			GROUP BY
				W.Code) W2
		ON W1.Code = W2.Code
	WHERE
		W1.Capacity < W2.Total_box);