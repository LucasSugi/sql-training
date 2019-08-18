-- PRINT PRIME NUMBERS
WITH prime AS(
    SELECT
        LEVEL+1 AS L
    FROM
        DUAL
    CONNECT BY LEVEL < 1000
)
SELECT
    LISTAGG(p1.L,'&') WITHIN GROUP (ORDER BY p1.L) AS prime_number
FROM
    prime p1
    LEFT JOIN prime p2
    ON p1.L > p2.L AND MOD(p1.L,p2.L)=0
WHERE
    p2.L IS NULL;