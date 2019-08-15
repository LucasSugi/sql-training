/*
1 - Find the list of all buildings that have employees
*/
SELECT DISTINCT
    Building
FROM
    employees;

/*
2 - Find the list of all buildings and their capacity
*/
SELECT
    *
FROM
    Buildings;

/*
3 - List all buildings and the distinct employee roles in each building (including empty buildings)
*/
SELECT DISTINCT
    Building_name,
    Role
FROM
    Buildings B
    LEFT JOIN Employees E
        ON B.Building_name = E.Building;