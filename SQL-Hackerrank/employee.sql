-- 1) Employee Names
SELECT
    name
FROM
    Employee
ORDER BY
    name;

-- 2) Employee Salaries
SELECT
    name
FROM
    Employee
WHERE
    salary > 2000 AND months < 10
ORDER BY
    employee_id;

-- 3) Top Earners
SELECT
    MAX(months*salary),
    COUNT(employee_id)
FROM
    Employee
WHERE
    months*salary = 
        (SELECT
            MAX(months*salary) AS max_earnings
        FROM
            Employee);

-- 4) The Blunder
SELECT
    CEIL(AVG(Salary)-AVG(REPLACE(Salary,'0','')))
FROM
    EMPLOYEES;