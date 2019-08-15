/*
1 - What are your favorite books? You can make a database table to store them in! 
In this first step, create a table to store your list of books. 
It should have columns for id, name, and rating.
*/

CREATE TABLE Books(
    id INTEGER,
    name TEXT,
    rating INTEGER,
    PRIMARY KEY(id)
);

/*
2 - Now, add three of your favorite books into the table.
*/
INSERT INTO Books VALUES (1,'An Introduction to Statistical Learning  with Applications in R',10);
INSERT INTO Books VALUES (2,'Hands–On Machine Learning with Scikit–Learn and TensorFlow',10);
INSERT INTO Books VALUES (3,'The Elements of Statistical Learning',10);

/*
3 - This database contains an incomplete list of box office hits and their release year.
In this challenge, you're going to get the results back out of the database in different ways!
In this first step, just select all the movies.
*/
SELECT
    id,
    name,
    release_year
FROM
    movies;


/*
4 - Now, add a second query after the first, that retrieves only the movies that were released in the year 2000 or later, not before. 
Sort the results so that the earlier movies are listed first. You should have 2 SELECT statements after this step.
*/
SELECT
    id,
    name,
    release_year
FROM
    movies
WHERE
    release_year >= 2000
ORDER BY
    release_year;

/*
5 - Here's a table containing a TODO list with the number of minutes it will take to complete each item.
Insert another item to your todo list with the estimated minutes it will take.
*/
INSERT INTO todo_list VALUES (4, "Learn SQL", 60);


/*
6 - Select the SUM of minutes it will take to do all of the items on your TODO list. You should only have one SELECT statement.
*/
SELECT
    SUM(minutes)
FROM
    todo_list;