-- 1) Revising the Select Query I
SELECT
    *
FROM
    CITY
WHERE
    POPULATION > 100000 AND COUNTRYCODE = 'USA';

-- 2) Revising the Select Query II
SELECT
    NAME
FROM
    CITY
WHERE
    POPULATION > 120000 AND COUNTRYCODE = 'USA';

-- 3) Select All
SELECT
    *
FROM
    CITY;

-- 4) Select By ID
SELECT
    *
FROM
    CITY
WHERE
    ID = 1661;

-- 5) Japanese Cities' Attributes
SELECT
    *
FROM
    CITY
WHERE
    COUNTRYCODE = 'JPN';

-- 6) Japanese Cities' Names
SELECT
    NAME
FROM
    CITY
WHERE
    COUNTRYCODE = 'JPN';

-- 7) Revising Aggregations - The Count Function
SELECT
    COUNT(ID)
FROM
    CITY
WHERE
    POPULATION > 100000;

-- 8) Revising Aggregations - The Sum Function
SELECT
    SUM(POPULATION)
FROM
    CITY
WHERE
    DISTRICT = 'California';

-- 9) Revising Aggregations - Averages
SELECT
    AVG(POPULATION)
FROM
    CITY
WHERE
    DISTRICT = 'California';

-- 10) Average Population
SELECT
    FLOOR(AVG(POPULATION))
FROM
    CITY;

-- 11) Japan Population
SELECT
    SUM(POPULATION)
FROM
    CITY
WHERE
    COUNTRYCODE = 'JPN';

-- 12) Population Density Difference
SELECT
    MAX(POPULATION)-MIN(POPULATION)
FROM
    CITY;

-- 13) Asian Population
SELECT
    SUM(CITY.POPULATION)
FROM
    CITY
    JOIN COUNTRY
        ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE
    CONTINENT = 'Asia';  

-- 14) African Cities
SELECT
    CITY.NAME
FROM
    CITY
    JOIN COUNTRY
        ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE
    CONTINENT = 'Africa';

-- 15) Average Population of Each Continent
SELECT
    COUNTRY.CONTINENT,
    FLOOR(AVG(CITY.POPULATION))
FROM
    CITY
    JOIN COUNTRY
        ON CITY.COUNTRYCODE = COUNTRY.CODE
GROUP BY
    COUNTRY.CONTINENT;