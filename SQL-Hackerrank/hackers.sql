-- 1) Top Competitors
SELECT
    H.hacker_id,
    H.name
FROM
    Hackers H
    JOIN Submissions S
        ON H.hacker_id = S.hacker_id
    JOIN Challenges C
        ON S.challenge_id = C.challenge_id
    JOIN Difficulty D
        ON C.difficulty_level = D.difficulty_level AND S.score = D.score
GROUP BY
    H.hacker_id,
    H.name
HAVING
    COUNT(DISTINCT S.challenge_id) > 1
ORDER BY
    COUNT(DISTINCT S.challenge_id) DESC,
    H.hacker_id;

-- 2) Challenges
SELECT
	H.hacker_id,
	H.name,
	COUNT(C.challenge_id)
FROM
	Hackers H
	JOIN Challenges C
		ON H.hacker_id = C.hacker_id
GROUP BY
	H.hacker_id,
	H.name
HAVING
	COUNT(C.challenge_id) IN 
		(SELECT
			total_challenges
		FROM
			(SELECT
				hacker_id,
				COUNT(challenge_id) AS total_challenges
			FROM
				Challenges
			GROUP BY
				hacker_id)
		GROUP BY
			total_challenges
		HAVING
			COUNT(hacker_id)=1)
	OR
	COUNT(C.challenge_id) = 
		(SELECT
			MAX(COUNT(challenge_id)) AS max_total_challenges
		FROM
			Challenges
		GROUP BY
			hacker_id)
ORDER BY
	COUNT(C.challenge_id) DESC,
	H.hacker_id;

-- 3) Contest Leaderboard
SELECT
	H.hacker_id,
	H.name,
	SUM(S.score)
FROM
	Hackers H
	JOIN
		(SELECT
		    hacker_id,
		    MAX(score) AS score
		FROM
		    Submissions S
		GROUP BY
			hacker_id,
			challenge_id) S
		ON H.hacker_id = S.hacker_id
GROUP BY
	H.hacker_id,
	H.name
HAVING
	SUM(S.score) > 1
ORDER BY
	SUM(score) DESC,
	H.hacker_id;

-- 4) Interviews
SELECT
	S.contest_id,
	S.hacker_id,
	S.name,
	S.total_submissions,
	S.total_accepted_submissions,
	V.total_views,
	V.total_unique_views
FROM
	(SELECT
		CON.contest_id,
		CON.hacker_id,
		CON.name,
		SUM(SS.total_submissions) AS total_submissions,
		SUM(SS.total_accepted_submissions) AS total_accepted_submissions
	FROM
		Contests CON
		JOIN Colleges COL
			ON CON.contest_id = COL.contest_id
		JOIN Challenges CHA
			ON CHA.college_id = COL.college_id
		JOIN Submission_Stats SS
			ON SS.challenge_id = CHA.challenge_id
	GROUP BY
		CON.contest_id,
		CON.hacker_id,
		CON.name) S
	JOIN
		(SELECT
			CON.contest_id,
			SUM(total_views) AS total_views,
			SUM(total_unique_views) AS total_unique_views
		FROM
			Contests CON
			JOIN Colleges COL
				ON CON.contest_id = COL.contest_id
			JOIN Challenges CHA
				ON CHA.college_id = COL.college_id
			JOIN View_Stats VS
				ON VS.challenge_id = CHA.challenge_id
		GROUP BY
			CON.contest_id) V
		ON S.contest_id = V.contest_id
WHERE
	S.total_submissions <> 0
	OR S.total_accepted_submissions <> 0
	OR V.total_views <> 0
	OR V.total_unique_views <> 0
ORDER BY
	S.contest_id;

-- 5) 15 Days of Learning SQL
SELECT
	result1.submission_date,
	result1.count,
	result2.hacker_id,
	result2.name
FROM
(SELECT
	submission_date,
	COUNT(hacker_id) AS count
FROM
	(SELECT
			S1.hacker_id,
			S1.submission_date
		FROM
			Submissions S1
			JOIN Submissions S2
				ON (S1.hacker_id = S2.hacker_id AND S1.submission_date>=S2.submission_date)
		GROUP BY
			S1.hacker_id,
			S1.submission_date
		HAVING
			(S1.submission_date - (SELECT MIN(submission_date) FROM Submissions)) = COUNT(DISTINCT S2.submission_date)-1) S
GROUP BY
	submission_date) result1
JOIN
(SELECT
	S.submission_date,
	S.hacker_id,
	H.name
FROM
	(SELECT
		submission_date,
		hacker_id,
		ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY count_submission_id DESC,hacker_id) AS RN
	FROM
		(SELECT
			submission_date,
			hacker_id,
			COUNT(submission_id) AS count_submission_id
		FROM
			Submissions S
		GROUP BY
			submission_date,
			hacker_id)) S
	JOIN Hackers H
		ON H.hacker_id = S.hacker_id
WHERE
	RN = 1) result2
ON result1.submission_date = result2.submission_date
ORDER BY
	result1.submission_date;