--The first several exercises build on each other and illustrate the use of subqueries.

/*
1 - Who received a 1.5kg package?
*/
SELECT
	Name
FROM
	Client C
	JOIN Package P
	ON C.AccountNumber = P.Recipient
WHERE
	Weight = 1.5;

/*
2 - What is the total weight of all the packages that he sent?
*/
-- USING SUBQUERY
SELECT
	SUM(Weight)
FROM
	Package
WHERE
	Sender = 
		(SELECT
			AccountNumber
		FROM
			Client C
			JOIN Package P
			ON C.AccountNumber = P.Recipient
		WHERE
			Weight = 1.5);


/*
3 - Which pilots transported those packages?
*/
-- USING SUBQUERY
SELECT
	DISTINCT Name
FROM
	Employee E
	JOIN Shipment S
		ON E.EmployeeID = S.Manager
WHERE
	S.ShipmentID IN
		(SELECT
			Shipment
		FROM
			Package
		WHERE
			Sender = 
				(SELECT
					AccountNumber
				FROM
					Client C
					JOIN Package P
					ON C.AccountNumber = P.Recipient
				WHERE
					Weight = 1.5));