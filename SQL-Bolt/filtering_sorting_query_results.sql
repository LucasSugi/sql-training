/*
1 - List all directors of Pixar movies (alphabetically), without duplicates
*/
SELECT
    DISTINCT Director
FROM
    Movies
ORDER BY
    Director;

/*
2 - List the last four Pixar movies released (ordered from most recent to least)
*/
SELECT
    Title
FROM
    Movies
ORDER BY
    Year DESC
LIMIT 4;

/*
3 - List the first five Pixar movies sorted alphabetically
*/
SELECT
    Title
FROM
    Movies
ORDER BY
    Title
LIMIT 5;

/*
4 - List the next five Pixar movies sorted alphabetically
*/
SELECT
    Title
FROM
    Movies
ORDER BY
    Title
LIMIT 5,5;