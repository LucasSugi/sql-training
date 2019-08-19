SELECT
    Start_Date,
    End_Date
FROM
    (SELECT
        ROW_NUMBER() OVER (ORDER BY P1.Start_Date) AS RN,
        P1.Start_Date
    FROM    
        Projects P1
        LEFT JOIN Projects P2
            ON P1.Start_Date = P2.End_Date
    WHERE
        P2.End_Date IS NULL
    ORDER BY
        P1.Start_Date) P1
    JOIN
        (SELECT
            ROW_NUMBER() OVER (ORDER BY P1.End_Date) AS RN,
            P1.End_Date
        FROM    
            Projects P1
            LEFT JOIN Projects P2
                ON P1.End_Date = P2.Start_Date
        WHERE
            P2.Start_Date IS NULL
        ORDER BY
            P1.End_Date) P2
        ON P1.RN = P2.RN
ORDER BY
    (End_Date-Start_Date),
    Start_Date;