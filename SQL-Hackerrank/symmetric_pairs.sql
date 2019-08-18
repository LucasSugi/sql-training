SELECT
    F1.X,
    F1.Y
FROM
    (SELECT
        X,
        Y,
        ROWNUM AS RN
    FROM
        Functions) F1
    JOIN
    (SELECT
        X,
        Y,
        ROWNUM AS RN
    FROM
        Functions) F2
        ON (F1.X = F2.Y AND F1.Y = F2.X) AND (F1.X<F2.X OR (F1.X=F2.X AND F1.RN<F2.RN))
ORDER BY
    F1.X;