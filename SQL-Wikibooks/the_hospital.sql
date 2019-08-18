/*
1 - Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.
*/
SELECT
	P.Name
FROM
	Physician P
    JOIN Undergoes U
		ON P.EmployeeID = U.Physician
	LEFT JOIN Trained_In T
		ON T.Physician = P.EmployeeID AND T.Treatment = U.Procedures
WHERE
	T.Treatment IS NULL;

/*
2 - Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.
*/
SELECT
	Phy.Name,
	Pro.Name,
	U.DateUndergoes,
	Pa.Name
FROM
	Physician Phy
    JOIN Undergoes U
		ON Phy.EmployeeID = U.Physician
	JOIN Patient Pa
		ON Pa.SSN = U.Patient
	JOIN Procedures Pro
		ON Pro.Code = U.Procedures
	LEFT JOIN Trained_In T
		ON T.Physician = Phy.EmployeeID AND T.Treatment = Pro.Code
WHERE
	T.Treatment IS NULL;

/*
3 - Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
*/
SELECT
	P.Name
FROM
	Physician P
    JOIN Undergoes U
		ON P.EmployeeID = U.Physician
	JOIN Trained_In T
		ON T.Physician = P.EmployeeID AND T.Treatment = U.Procedures
WHERE
	T.CertificationExpires < U.DateUndergoes;

/*
4 - Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
*/
SELECT
	Phy.Name,
	Pro.Name,
	U.DateUndergoes,
	Pa.Name,
	T.CertificationExpires
FROM
	Physician Phy
    JOIN Undergoes U
		ON Phy.EmployeeID = U.Physician
	JOIN Patient Pa
		ON Pa.SSN = U.Patient
	JOIN Procedures Pro
		ON Pro.Code = U.Procedures
	JOIN Trained_In T
		ON T.Physician = Phy.EmployeeID AND T.Treatment = Pro.Code
WHERE
	T.CertificationExpires < U.DateUndergoes;

/*
5 - Obtain the information for appointments where a patient met with a physician other than his/her primary care physician.
Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.
*/
SELECT
	Pa.Name,
	Phy1.Name,
	N.Name,
	A.Start,
	A.End,
	A.ExaminationRoom,
	Phy2.Name
FROM
	Patient Pa
	JOIN Appointment A
		ON A.Patient = Pa.SSN
	JOIN Physician Phy1
		ON Phy1.EmployeeID = A.Physician
	JOIN Physician Phy2
		ON Pa.PCP = Phy2.EmployeeID
	LEFT JOIN Nurse N
		ON N.EmployeeID = A.PrepNurse
WHERE
	Pa.PCP <> A.Physician;

/*
6 - The Patient field in Undergoes is redundant, since we can obtain it from the Stay table.
There are no constraints in force to prevent inconsistencies between these two tables.
More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.
Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.
*/
SELECT
	U.Patient,
	S.Patient,
	S.StayID
FROM
	Undergoes U
	JOIN Stay S
		ON U.Stay = S.StayID
WHERE
	U.Patient <> S.Patient;

/*
7 - Obtain the names of all the nurses who have ever been on call for room 123.
*/
SELECT
	N.Name
FROM
	Nurse N
	JOIN On_Call OC
		ON OC.Nurse = N.EmployeeID
	JOIN Room R
		ON (R.BlockFloor = OC.BlockFloor AND R.BlockCode = OC.BlockCode)
WHERE
	R.RoomNumber = 123;

/*
8 - The hospital has several examination rooms where appointments take place.
Obtain the number of appointments that have taken place in each examination room.
*/
SELECT
	ExaminationRoom,
	COUNT(AppointmentID)
FROM
	Appointment
GROUP BY
	ExaminationRoom;

/*
9 - Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
The patient has been prescribed some medication by his/her primary care physician.
The patient has undergone a procedure with a cost larger that $5,000
The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
The patient's primary care physician is not the head of any department.
*/
SELECT
	Pa.Name,
	Phy.Name
FROM
	Patient Pa
	JOIN Physician Phy
		ON Pa.PCP = Phy.EmployeeID
	JOIN Prescribes Pre
		ON Pre.Physician = Pa.PCP AND Pre.Patient = Pa.SSN
	JOIN Medication M
		ON M.Code = Pre.Medication
	JOIN Undergoes U
		ON U.Patient = Pa.SSN
	JOIN Procedures Pro
		ON U.Procedures = Pro.Code
	JOIN Appointment A
		ON A.Patient = Pa.SSN
	JOIN Nurse N
		ON N.EmployeeID = A.PrepNurse
WHERE
	Pro.Cost > 5000
    AND
    Phy.Position NOT LIKE '%Head%'
    AND
    N.Registered = 1
GROUP BY
	Pa.Name,
    Phy.Name
HAVING
	COUNT(A.AppointmentID)>=2;

---- ALTERNATIVE QUERY

SELECT
	Pa.Name,
	Phy.Name
FROM
	Patient Pa
	JOIN Physician Phy
		ON PCP = EmployeeID
WHERE
	Pa.SSN IN
		(SELECT
			Pa.SSN
		FROM
			Patient Pa
			JOIN Appointment A
				ON A.Patient = Pa.SSN
			JOIN Nurse N
				ON N.EmployeeID = A.PrepNurse
		WHERE
			N.Registered = 1
		GROUP BY
			Pa.SSN
		HAVING
			COUNT(A.AppointmentID)>=2)
	AND Pa.SSN IN
		(SELECT
			Pa.SSN
		FROM
			Patient Pa
			JOIN Physician Phy
				ON Pa.PCP = Phy.EmployeeID
		WHERE
			Phy.Position NOT LIKE '%Head%')
	AND Pa.SSN IN
		(SELECT
			Pa.SSN
		FROM
			Patient Pa
			JOIN Undergoes U
				ON U.Patient = Pa.SSN
			JOIN Procedures Pro
				ON U.Procedures = Pro.Code
		WHERE
			Pro.Cost > 5000)
	AND Pa.SSN IN
		(SELECT
			Pa.SSN
		FROM
			Patient Pa
			JOIN Physician Phy
				ON Pa.PCP = Phy.EmployeeID
			JOIN Prescribes Pre
				ON Pre.Physician = Pa.PCP AND Pre.Patient = Pa.SSN
			JOIN Medication M
				ON M.Code = Pre.Medication);