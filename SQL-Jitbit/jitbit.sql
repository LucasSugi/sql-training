/*
1 - List employees (names) who have a bigger salary than their boss.
*/
SELECT
	E1.Name
FROM
	Employees E1
	JOIN Employees E2
		ON 	E1.BossID = E2.EmployeeID
WHERE
	E1.Salary > E2.salary;

/*
2 - List employees who have the biggest salary in their departments.
*/
SELECT
	E1.Name,
	E1.DepartmentID
FROM
	Employees E1
	JOIN
		(SELECT
			DepartmentID,
			MAX(Salary) AS Salary
		FROM
			Employees
		GROUP BY
			DepartmentID) E2
		ON	(E1.DepartmentID = E2.DepartmentID AND E1.Salary = E2.Salary);

-- OR
SELECT
	E1.Name,
    E1.DepartmentID
FROM
	Employees E1
WHERE
	E1.Salary >= (
		SELECT
			MAX(E2.Salary)
		FROM
			Employees E2
		WHERE
			E1.DepartmentID = E2.DepartmentID);

-- OR
SELECT
	E1.Name,
	E1.DepartmentID
FROM
	Employees E1
    LEFT JOIN Employees E2
		ON (E1.DepartmentID = E2.DepartmentID AND E1.Salary < E2.Salary)
WHERE
	E2.Salary IS NULL;

/*
3 - List departments that have less than 3 people in it.
*/
SELECT
	D.Name,
	COUNT(EmployeeID) AS total
FROM
	Employees E
	JOIN Departments D
		ON E.DepartmentID = D.DepartmentID
GROUP BY
	D.DepartmentID
HAVING
	COUNT(EmployeeID) < 3;

/*
4 - List all departments along with the number of people there (tricky - people often do an "inner join" leaving out empty departments).
*/
SELECT
	D.Name,
	COUNT(E.EmployeeID) AS total
FROM
	Departments D
	LEFT JOIN Employees E
		ON D.DepartmentID = E.DepartmentID
GROUP BY
	D.Name;


/*
5 - List employees that don't have a boss in the same department.
*/
SELECT
	E1.Name
FROM
	Employees E1
	JOIN Employees E2
		ON (E1.BossID = E2.EmployeeID)
WHERE
	E1.DepartmentID <> E2.DepartmentID
UNION
SELECT
	Name
FROM
	Employees
WHERE
	BossID IS NULL;

/*
6 - List all departments along with the total salary there.
*/
SELECT
	D.Name,
	SUM(E.Salary) AS total
FROM
	Departments D
	LEFT JOIN Employees E
		ON D.DepartmentID = E.DepartmentID
GROUP BY
	D.Name;