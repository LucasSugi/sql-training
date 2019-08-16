/*
1 - Write a SQL query that returns the name, phone number and most recent date for any user that has logged in over 
the last 30 days (you can tell a user has logged in if the action field in UserHistory is set to "logged_on").
Every time a user logs in a new row is inserted into the UserHistory table with user_id, 
current date and action (where action = "logged_on").
*/
SELECT
	U.NAME,
	U.PHONE_NUM,
	UH.MAX_DATE
FROM
	USER U
	JOIN
	(SELECT
			USER_ID,
			MAX(DATE) AS MAX_DATE
		FROM
			USER_HISTORY UH
		WHERE
			ACTION = 'logged_on'
		GROUP BY
			USER_ID
		HAVING
			MAX(DATE) >= DATE_SUB(CURDATE(),INTERVAL 30 DAY)) UH
	ON U.USER_ID = UH.USER_ID;

/*
2 - Write a SQL query to determine which user_ids in the User table are not contained in the UserHistory
table (assume the UserHistory table has a subset of the user_ids in User table). Do not use the SQL MINUS statement.
Note: the UserHistory table can have multiple entries for each user_id.
*/
SELECT
	U.NAME
FROM
	USER U
	LEFT JOIN USER_HISTORY UH
		ON U.USER_ID = UH.USER_ID
WHERE
	UH.USER_ID IS NULL;