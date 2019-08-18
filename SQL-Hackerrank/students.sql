-- 1) Higher Than 75 Marks
SELECT
    Name
FROM
    Students
WHERE
    Marks > 75
ORDER BY
    SUBSTR(Name,-3),
    Id;

-- 2) The Report
SELECT
    CASE
        WHEN G.Grade >=8 THEN S.Name
        ELSE 'NULL' END AS S_name,
    G.Grade,
    S.Marks
FROM
    Students S
    JOIN Grades G
        ON S.Marks >= G.Min_Mark AND S.Marks <= G.Max_Mark
ORDER BY
    G.Grade DESC,
    S_name,
    S.Marks;

-- 3) Placements
SELECT
    S.Name
FROM
    Students S
    JOIN Friends F
        ON S.ID = F.ID
    JOIN Packages P1
        ON S.ID = P1.ID
    JOIN Packages P2
        ON F.Friend_id = P2.ID
WHERE
    P2.Salary > P1.Salary
ORDER BY
    P2.Salary;