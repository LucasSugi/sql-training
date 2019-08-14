/*
1 - Select the name of all the pieces. 
*/
SELECT
	Name
FROM
	Pieces;

/*
2 - Select all the providers' data.
*/
SELECT
	Code,
    Name
FROM
	Providers;

/*
3 - Obtain the average price of each piece (show only the piece code and the average price).
*/
SELECT
	Piece,
	AVG(Price)
FROM
	Provides
GROUP BY
	Piece;

/*
4 - Obtain the names of all providers who supply piece 1.
*/
SELECT
	Name
FROM
	Providers PRS
	JOIN Provides PES
		ON PRS.Code = PES.Provider
WHERE
	PES.Piece = 1;

/*
5 - Select the name of pieces provided by provider with code "HAL".
*/
SELECT
	Pi.Name
FROM
	Pieces Pi
	JOIN Provides PES
		ON Pi.Code = PES.Piece
WHERE
	PES.Provider = 'HAL';

/*
6 - For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price (note that there could be two providers who supply the same piece at the most expensive price).
*/
SELECT
	Pi.Name,
	PRO.Name,
    Price
FROM
	Provides
	JOIN
		(SELECT
			Piece AS ID,
			MAX(Price) AS Max_price
		FROM
			Provides
		GROUP BY
			Piece) tmp
		ON Piece = ID AND Price = Max_price
	JOIN Pieces Pi
		ON Pi.Code = Piece
	JOIN Providers PRO
		ON PRO.Code = Provider;


/*
7 - Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
*/
INSERT INTO Provides VALUES (1, 'TNBC', 7);

/*
8 - Increase all prices by one cent.
*/
UPDATE Provides
SET Price = Price + 1;

/*
9 - Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
*/
DELETE FROM Provides
WHERE
	Provider = 'RBT'
	AND
	Piece = 4;

/*
10 - Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces (the provider should still remain in the database).
*/
DELETE FROM Provides
WHERE
	Provider = 'RBT';