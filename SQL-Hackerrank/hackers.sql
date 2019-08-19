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