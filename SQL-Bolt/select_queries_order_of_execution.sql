/*
1 - Find the number of movies each director has directed
*/
SELECT
    Director,
    COUNT(Title)
FROM
    movies
GROUP BY
    Director;

/*
2 - Find the total domestic and international sales that can be attributed to each director
*/
SELECT
    Director,
    SUM(Domestic_Sales+International_Sales)
FROM
    movies m
    JOIN boxoffice b
        ON m.id = b.movie_id
GROUP BY
    Director;