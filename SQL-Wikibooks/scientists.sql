/*
1 - List all the scientists' names, their projects' names, and the hours worked by that scientist on each project, in alphabetical order of project name, then scientist name.
*/
SELECT
	S.Name,
	P.Name,
	P.Hours
FROM
	Scientists S
	JOIN AssignedTo A
		ON S.SSN = A.Scientist
	JOIN Projects P
		ON P.Code = A.Project
ORDER BY
	P.Name,
	S.Name;