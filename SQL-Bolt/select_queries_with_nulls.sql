/*
1 - Find the name and role of all employees who have not been assigned to a building
*/
SELECT
    Name,
    Role
FROM
    employees
WHERE
    Building IS NULL;

/*
2 - Find the names of the buildings that hold no employees
*/
SELECT
    Building_name
FROM
    Buildings B
    LEFT JOIN Employees E
        ON B.Building_name = E.Building
WHERE
    Building IS NULL;