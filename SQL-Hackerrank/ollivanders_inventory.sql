SELECT
    id,
    age,
    coins_needed,
    pw
FROM
    (SELECT
        id,
        age,
        coins_needed,
        W.power as pw,
        ROW_NUMBER() OVER (PARTITION BY age, W.power ORDER BY coins_needed) AS RN
    FROM
        Wands W
        JOIN Wands_property WP
            ON W.code = WP.code
    WHERE is_evil <> 1)
WHERE RN = 1
ORDER BY pw DESC, age DESC;

-- OR

SELECT
    W1.id,
    WP1.age,
    W1.coins_needed,
    W1.power
FROM
    Wands W1
    JOIN Wands_Property WP1 
        ON W1.code = WP1.code
WHERE
    W1.coins_needed <= 
		(SELECT
		    MIN(coins_needed)
		FROM
		    Wands W2
		    JOIN Wands_Property WP2
		        ON W2.code = WP2.code
		WHERE
			W1.power = W2.power AND WP1.age = WP2.age)
	AND
		WP1.is_evil <> 1
ORDER BY
	W1.power DESC,
	WP1.age DESC;

-- OR
SELECT
    WWP1.id,
    WWP1.age,
    WWP1.coins_needed,
    WWP1.power
FROM
    (SELECT
        id,
        age,
        coins_needed,
        power
    FROM
        Wands W
        JOIN Wands_Property WP
            ON W.code = WP.code
    WHERE
           is_evil <> 1) WWP1
    LEFT JOIN
    (SELECT
        age,
        coins_needed,
        power
    FROM
        Wands W
        JOIN Wands_Property WP
            ON W.code = WP.code
       WHERE
           is_evil <> 1) WWP2
    ON
        (WWP1.power = WWP2.power AND WWP1.age = WWP2.age) AND (WWP1.coins_needed > WWP2.coins_needed)
WHERE
    WWP2.coins_needed IS NULL
ORDER BY
    WWP1.power DESC,
    WWP1.age DESC;

-- These other alternative queries will work on most DBMS.