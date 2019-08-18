-- 1) The PADS
SELECT
    Name ||
    CASE
        WHEN Occupation = 'Actor' THEN '(A)'
        WHEN Occupation = 'Doctor' THEN '(D)'
        WHEN Occupation = 'Professor' THEN '(P)'
        WHEN Occupation = 'Singer' THEN '(S)'
    END AS initials_occupation
FROM
    OCCUPATIONS
ORDER BY
    Name;
SELECT
    'There are a total of ' || COUNT(Name) || ' ' || LOWER(Occupation) || 's.'
FROM
    OCCUPATIONS
GROUP BY
    Occupation
ORDER BY
    COUNT(Name),
    Occupation;

-- 2) Occupations
SELECT
    Doctor,
    Professor,
    Singer,
    Actor
FROM
    (SELECT
        Name,
        Occupation,
        ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn_index
    FROM
        OCCUPATIONS) occupation2
PIVOT
(
    MAX(Name)
    FOR OCCUPATION IN ('Doctor' AS Doctor,'Professor' AS Professor,'Singer' AS Singer,'Actor' AS Actor)
) PVT
ORDER BY
    rn_index;