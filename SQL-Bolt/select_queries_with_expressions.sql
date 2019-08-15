/*
1 - List all movies and their combined sales in millions of dollars
*/
SELECT
    Title,
    (Domestic_Sales+International_Sales)/1000000 AS Total_Sales
FROM
    Movies M
    JOIN Boxoffice B
        ON M.id = B.movie_id;

/*
2 - List all movies and their ratings in percent
*/
SELECT
    Title,
    Rating*10
FROM
    Movies M
    JOIN Boxoffice B
        ON M.id = B.movie_id;


/*
3 - List all movies that were released on even number years
*/
SELECT
    Title,
    Year
FROM
    Movies
WHERE
    Year%2 = 0;