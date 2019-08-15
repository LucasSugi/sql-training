/*
1 - Find the movie with a row id of 6
*/
SELECT
    Title
FROM
    Movies
WHERE Id = 6;

/*
2 - Find the movies released in the years between 2000 and 2010
*/
SELECT
    Title
FROM
    Movies
WHERE Year BETWEEN 2000 AND 2010;

/*
3 - Find the movies not released in the years between 2000 and 2010
*/
SELECT
    Title
FROM
    Movies
WHERE Year NOT BETWEEN 2000 AND 2010;

/*
4 - Find the first 5 Pixar movies and their release  year
*/
SELECT
    Title,
    Year
FROM
    Movies
ORDER BY
    Id ASC
LIMIT 5;