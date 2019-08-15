/*
1 - Find all the Toy Story movies
*/
SELECT
    Title
FROM
    Movies
WHERE
    Title LIKE 'Toy Story%';

/*
2 - Find all the movies directed by John Lasseter
*/
SELECT
    Title
FROM
    Movies
WHERE
    Director = 'John Lasseter';

/*
3 - Find all the movies (and director) not directed by John Lasseter
*/
SELECT
    Title,
    Director
FROM
    Movies
WHERE
    Director <> 'John Lasseter';

/*
4 - Find all the WALL-* movies
*/
SELECT
    Title
FROM
    Movies
WHERE
    Title LIKE 'Wall-%';