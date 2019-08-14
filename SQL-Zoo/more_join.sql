/* 
1 - List the films where the yr is 1962 [Show id, title], 
*/ 
SELECT id, 
       title 
FROM   movie 
WHERE  yr = 1962; 

/* 
2 - Give year of 'Citizen Kane'. 
*/ 
SELECT yr 
FROM   movie 
WHERE  title = 'Citizen Kane'; 

/* 
3 - List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title).
Order results by year. 
*/ 
SELECT id, 
       title, 
       yr 
FROM   movie 
WHERE  title LIKE '%Star Trek%'; 

/* 
4 - What id number does the actor 'Glenn Close' have? 
*/ 
SELECT id 
FROM   actor 
WHERE  name = 'Glenn Close'; 

/* 
5 - What is the id of the film 'Casablanca'. 
*/ 
SELECT id 
FROM   movie 
WHERE  title = 'Casablanca'; 

/* 
6 - Obtain the cast list for 'Casablanca'. 
Use movieid=11768, (or whatever value you got from the previous question) 
*/ 
SELECT name 
FROM   actor 
       JOIN casting 
         ON actorid = id 
WHERE  movieid = 11768; 

/* 
7 - Obtain the cast list for the film 'Alien'. 
*/ 
SELECT name 
FROM   actor a 
       JOIN casting 
         ON actorid = a.id 
       JOIN movie m 
         ON movieid = m.id 
WHERE  title = 'Alien'; 

/* 
8 - List the films in which 'Harrison Ford' has appeared. 
*/ 
SELECT title 
FROM   actor a 
       JOIN casting 
         ON actorid = a.id 
       JOIN movie m 
         ON movieid = m.id 
WHERE  name = 'Harrison Ford'; 

/* 
9 - List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role].
*/ 
SELECT title 
FROM   actor a 
       JOIN casting 
         ON actorid = a.id 
       JOIN movie m 
         ON movieid = m.id 
WHERE  name = 'Harrison Ford' 
       AND ord <> 1; 

/* 
10 - List the films together with the leading star for all 1962 films. 
*/ 
SELECT title, 
       name 
FROM   actor a 
       JOIN casting 
         ON actorid = a.id 
       JOIN movie m 
         ON movieid = m.id 
WHERE  yr = 1962 
       AND ord = 1; 

/* 
11 - Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/ 
SELECT yr, 
       COUNT(title) AS total_movie 
FROM   actor a 
       JOIN casting 
         ON actorid = a.id 
       JOIN movie m 
         ON movieid = m.id 
WHERE  name = 'Rock Hudson' 
GROUP  BY yr 
HAVING total_movie > 2; 

/* 
12 - List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
*/ 
SELECT title, 
       name 
FROM   actor a1 
       JOIN casting c1 
         ON c1.actorid = a1.id 
       JOIN movie m1 
         ON c1.movieid = m1.id 
WHERE  movieid IN (SELECT movieid 
                   FROM   actor a2 
                          JOIN casting c2 
                            ON c2.actorid = a2.id 
                   WHERE  name = 'Julie Andrews') 
       AND ord = 1; 

/* 
13 - Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles. 
*/ 
SELECT name 
FROM   actor 
       JOIN casting 
         ON actorid = id 
WHERE  ord = 1 
GROUP  BY name 
HAVING COUNT(movieid) >= 30 
ORDER  BY name; 

/* 
14 - List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/ 
SELECT title, 
       COUNT(actorid) AS total_cast 
FROM   movie 
       JOIN casting 
         ON movieid = id 
WHERE  yr = 1978 
GROUP  BY title 
ORDER  BY total_cast DESC, 
          title; 

/* 
15 - List all the people who have worked with 'Art Garfunkel'. 
*/ 
SELECT name 
FROM   actor a2 
       JOIN casting c2 
         ON c2.actorid = a2.id 
WHERE  movieid IN (SELECT movieid 
                   FROM   actor a1 
                          JOIN casting c1 
                            ON c1.actorid = a1.id 
                   WHERE  name = 'Art Garfunkel') 
       AND name <> 'Art Garfunkel'; 