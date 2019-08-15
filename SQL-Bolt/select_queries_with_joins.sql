/*
1 - Find the domestic and international sales for each movie
*/
SELECT
    Title,
    Domestic_Sales,
    International_Sales
FROM
    movies m
    JOIN boxoffice b
        ON m.id = b.movie_id;

/*
2 - Show the sales numbers for each movie that did better internationally rather than domestically
*/
SELECT
    Title,
    Domestic_Sales,
    International_Sales
FROM
    movies m
    JOIN boxoffice b
        ON m.id = b.movie_id
WHERE
    International_Sales > Domestic_Sales;

/*
3 - List all the movies by their ratings in descending order
*/
SELECT
    Title,
    Rating
FROM
    movies m
    JOIN boxoffice b
        ON m.id = b.movie_id
ORDER BY
    Rating DESC;