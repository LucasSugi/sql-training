/*
1 - Find the number of Artists in the studio (without a HAVING clause)
*/
SELECT
    COUNT(Name)
FROM
    employees
WHERE
    Role = 'Artist';


/*
2 - Find the number of Employees of each role in the studio
*/
SELECT
    Role,
    COUNT(Name)
FROM
    employees
GROUP BY
    Role;


/*
3 - Find the total number of years employed by all Engineers
*/
SELECT
    Role,
    SUM(Years_employed)
FROM
    employees
WHERE
    Role = 'Engineer';