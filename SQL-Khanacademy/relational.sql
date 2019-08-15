/*
1 - We've created a database of people and hobbies, and each row in hobbies is related to a row in persons via the person_id column.
In this first step, insert one more row in persons and then one more row in hobbies that is related to the newly inserted person.
*/
INSERT INTO persons (name, age) VALUES ('Lucas',23);
INSERT INTO hobbies (person_id, name) VALUES (6,'Gym');

/*
2 - Now, select the 2 tables with a join so that you can see each person's name next to their hobby.
*/
SELECT
    P.name,
    H.name
FROM
    persons P
    JOIN hobbies H
        ON P.id = H.person_id;

/*
3 - Now, add an additional query that shows only the name and hobbies of 'Bobby McBobbyFace', using JOIN combined with WHERE.
*/
SELECT
    P.name,
    H.name
FROM
    persons P
    JOIN hobbies H
        ON P.id = H.person_id
WHERE
    P.name = 'Bobby McBobbyFace';

/*
4 - We've created a database for customers and their orders.
Not all of the customers have made orders, however.
Come up with a query that lists the name and email of every customer followed by the item and price of orders they've made.
Use a LEFT OUTER JOIN so that a customer is listed even if they've made no orders, and don't add any ORDER BY.
*/
SELECT
    name,
    email,
    item,
    price
FROM
    customers C
    LEFT JOIN orders O
        ON C.id = O.customer_id;

/*
5 - Now, create another query that will result in one row per each customer, with their name, email, and total amount of money they've spent on orders.
Sort the rows according to the total money spent, from the most spent to the least spent.
*/
SELECT
    name,
    email,
    tot_price
FROM    
    customers C
    JOIN
        (SELECT
            customer_id,
            SUM(price) as tot_price
        FROM
            orders
        GROUP BY
            customer_id) O
        ON C.id = O.customer_id;

/*
6 - We've created a table with all the 'Harry Potter' movies, with a sequel_id column that matches the id of the sequel for each movie.
Issue a SELECT that will show the title of each movie next to its sequel's title (or NULL if it doesn't have a sequel).
*/
SELECT
    M1.title,
    M2.title
FROM
    movies M1
    LEFT JOIN movies M2
        ON m1.sequel_id = M2.id;

/*
7 - We've created a database for a friend networking site, with a table storing data on each person, a table on each person's hobbies, and a table of friend connections between the people.
In this first step, use a JOIN to display a table showing people's names with their hobbies.
*/
SELECT
    fullname,
    name
FROM
    persons P
    JOIN hobbies H
        ON P.id = H.person_id;

/*
8 - Now, use another SELECT with a JOIN to show the names of each pair of friends, based on the data in the friends table.
*/
SELECT
    P1.fullname,
    P2.fullname
FROM
    friends F
    JOIN persons P1
        ON P1.id = f.person1_id
    JOIN persons P2
        ON P2.id = f.person2_id;