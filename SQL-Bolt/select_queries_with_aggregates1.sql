/*
1 - Find the longest time that an employee has been at the studio
*/
SELECT
    Name,
    Years_Employed
FROM
    employees
WHERE
    Years_Employed = 
        (SELECT
            MAX(Years_Employed)
        FROM
            employees);

/*
2 - For each role, find the average number of years employed by employees in that role
*/
SELECT
    Role,
    AVG(Years_Employed)
FROM
    employees
GROUP BY
    Role;


/*
3 - Find the total number of employee years worked in each building
*/
SELECT
    Building,
    SUM(Years_Employed)
FROM
    employees
GROUP BY
    Building;