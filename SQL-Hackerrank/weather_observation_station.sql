-- 1
SELECT
    CITY,
    STATE
FROM
    STATION;

-- 2
SELECT
    ROUND(SUM(LAT_N),2),
    ROUND(SUM(LONG_W),2)
FROM
    STATION;

-- 3
SELECT DISTINCT 
    CITY
FROM
    STATION
WHERE MOD(ID,2) = 0;

-- 4
SELECT
    COUNT(CITY)-COUNT(DISTINCT CITY)
FROM
    STATION;

-- 5
SELECT
    *
FROM
    (SELECT
        CITY,
        LENGTH(CITY)
    FROM
        STATION
    ORDER BY
        LENGTH(CITY) DESC, CITY)
WHERE
    ROWNUM = 1
UNION
SELECT
    *
FROM
    (SELECT
        CITY,
        LENGTH(CITY)
    FROM
        STATION
    ORDER BY
        LENGTH(CITY), CITY)
WHERE
    ROWNUM = 1;

-- 6
SELECT DISTINCT
    CITY
FROM
    STATION
WHERE
    LOWER(CITY) LIKE 'a%'
    OR LOWER(CITY) LIKE 'e%'
    OR LOWER(CITY) LIKE 'i%'
    OR LOWER(CITY) LIKE 'o%'
    OR LOWER(CITY) LIKE 'u%';

-- 7
SELECT DISTINCT
    CITY
FROM
    STATION
WHERE
    LOWER(CITY) LIKE '%a'
    OR LOWER(CITY) LIKE '%e'
    OR LOWER(CITY) LIKE '%i'
    OR LOWER(CITY) LIKE '%o'
    OR LOWER(CITY) LIKE '%u';

-- 8
SELECT DISTINCT
    CITY
FROM
    STATION
WHERE
    (LOWER(CITY) LIKE 'a%'
    OR LOWER(CITY) LIKE 'e%'
    OR LOWER(CITY) LIKE 'i%'
    OR LOWER(CITY) LIKE 'o%'
    OR LOWER(CITY) LIKE 'u%')
    AND
    (LOWER(CITY) LIKE '%a'
    OR LOWER(CITY) LIKE '%e'
    OR LOWER(CITY) LIKE '%i'
    OR LOWER(CITY) LIKE '%o'
    OR LOWER(CITY) LIKE '%u');

-- 9
SELECT DISTINCT
    CITY
FROM
    STATION
WHERE
    LOWER(CITY) NOT LIKE 'a%'
    AND LOWER(CITY) NOT LIKE 'e%'
    AND LOWER(CITY) NOT LIKE 'i%'
    AND LOWER(CITY) NOT LIKE 'o%'
    AND LOWER(CITY) NOT LIKE 'u%';

-- 10
SELECT DISTINCT
    CITY
FROM
    STATION
WHERE
    LOWER(CITY) NOT LIKE '%a'
    AND LOWER(CITY) NOT LIKE '%e'
    AND LOWER(CITY) NOT LIKE '%i'
    AND LOWER(CITY) NOT LIKE '%o'
    AND LOWER(CITY) NOT LIKE '%u';

-- 11
SELECT DISTINCT
    CITY
FROM
    STATION
WHERE
    (LOWER(CITY) NOT LIKE 'a%'
    AND LOWER(CITY) NOT LIKE 'e%'
    AND LOWER(CITY) NOT LIKE 'i%'
    AND LOWER(CITY) NOT LIKE 'o%'
    AND LOWER(CITY) NOT LIKE 'u%')
    OR
    (LOWER(CITY) NOT LIKE '%a'
    AND LOWER(CITY) NOT LIKE '%e'
    AND LOWER(CITY) NOT LIKE '%i'
    AND LOWER(CITY) NOT LIKE '%o'
    AND LOWER(CITY) NOT LIKE '%u');

-- 12
SELECT DISTINCT
    CITY
FROM
    STATION
WHERE
    (LOWER(CITY) NOT LIKE 'a%'
    AND LOWER(CITY) NOT LIKE 'e%'
    AND LOWER(CITY) NOT LIKE 'i%'
    AND LOWER(CITY) NOT LIKE 'o%'
    AND LOWER(CITY) NOT LIKE 'u%')
    AND
    (LOWER(CITY) NOT LIKE '%a'
    AND LOWER(CITY) NOT LIKE '%e'
    AND LOWER(CITY) NOT LIKE '%i'
    AND LOWER(CITY) NOT LIKE '%o'
    AND LOWER(CITY) NOT LIKE '%u');

-- 13
SELECT
    ROUND(SUM(LAT_N),4)
FROM
    STATION
WHERE
    LAT_N > 38.788 AND LAT_N < 137.2345;

-- 14
SELECT
    ROUND(MAX(LAT_N),4)
FROM
    STATION
WHERE
    LAT_N < 137.2345;

-- 15
SELECT
    ROUND(LONG_W,4)
FROM
    STATION
WHERE
    LAT_N =
        (SELECT
            MAX(LAT_N)
        FROM
            STATION
        WHERE
            LAT_N < 137.2345);

-- 16
SELECT
    ROUND(MIN(LAT_N),4)
FROM
    STATION
WHERE
    LAT_N > 38.778;

-- 17
SELECT
    ROUND(LONG_W,4)
FROM
    STATION
WHERE
    LAT_N = 
        (SELECT
            MIN(LAT_N)
        FROM
            STATION
        WHERE
            LAT_N > 38.778);

-- 18
SELECT
    ROUND(ABS(MAX(LAT_N)-MIN(LAT_N))+ABS(MAX(LONG_W)-MIN(LONG_W)),4)
FROM
    STATION;

-- 19
SELECT
    ROUND(SQRT(POWER(MAX(LAT_N)-MIN(LAT_N),2)+POWER(MAX(LONG_W)-MIN(LONG_W),2)),4)
FROM
    STATION;

-- 20
SELECT
    ROUND(MEDIAN(LAT_N),4)
FROM
    STATION;