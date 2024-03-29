/* 
1 - How many stops are in the database. 
*/ 
SELECT Count(*) 
FROM   stops; 

/* 
2 - Find the id value for the stop 'Craiglockhart' 
*/ 
SELECT id 
FROM   stops 
WHERE  NAME = 'Craiglockhart'; 

/* 
3 - Give the id and the name for the stops on the '4' 'LRT' service. 
*/ 
SELECT id, 
       NAME 
FROM   stops 
       JOIN route 
         ON id = stop 
WHERE  company = 'LRT' 
       AND num = 4; 

/* 
4 - The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
Run the query and notice the two services that link these stops have a count of 2. 
Add a HAVING clause to restrict the output to these two routes. 
*/ 
SELECT company, 
       num, 
       Count(*) 
FROM   route 
WHERE  stop = 149 
        OR stop = 53 
GROUP  BY company, 
          num 
HAVING Count(*) > 1; 

/* 
5 - Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes.
Change the query so that it shows the services from Craiglockhart to London Road. 
*/ 
SELECT r1.company, 
       r1.num, 
       r1.stop, 
       r2.stop 
FROM   route r1 
       JOIN route r2 
         ON ( r1.company = r2.company 
              AND r1.num = r2.num ) 
WHERE  r1.stop = 53 
       AND r2.stop = 149; 

/* 
6 - The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number.
Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. 
If you are tired of these places try 'Fairmilehead' against 'Tollcross' 
*/ 
SELECT r1.company, 
       r1.num, 
       s1.NAME, 
       s2.NAME 
FROM   route r1 
       JOIN route r2 
         ON ( r1.company = r2.company 
              AND r1.num = r2.num ) 
       JOIN stops s1 
         ON ( s1.id = r1.stop ) 
       JOIN stops s2 
         ON ( s2.id = r2.stop ) 
WHERE  s1.NAME = 'Craiglockhart' 
       AND s2.NAME = 'London Road'; 

/* 
7 - Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith'). 
*/ 
SELECT DISTINCT r1.company, 
                r1.num 
FROM   route r1 
       JOIN route r2 
         ON ( r1.company = r2.company 
              AND r1.num = r2.num ) 
WHERE  r1.stop = 115 
       AND r2.stop = 137; 

/* 
8 - Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'. 
*/ 
SELECT r1.company, 
       r1.num 
FROM   route r1 
       JOIN route r2 
         ON ( r1.company = r2.company 
              AND r1.num = r2.num ) 
       JOIN stops s1 
         ON ( s1.id = r1.stop ) 
       JOIN stops s2 
         ON ( s2.id = r2.stop ) 
WHERE  s1.NAME = 'Craiglockhart' 
       AND s2.NAME = 'Tollcross'; 

/* 
9 - Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company.
Include the company and bus no. of the relevant services. 
*/ 
SELECT DISTINCT s2.NAME, 
                r1.company, 
                r1.num 
FROM   route r1 
       JOIN stops s1 
         ON ( s1.id = r1.stop ) 
       JOIN route r2 
         ON ( r1.company = r2.company 
              AND r1.num = r2.num ) 
       JOIN stops s2 
         ON ( s2.id = r2.stop ) 
WHERE  s1.NAME = 'Craiglockhart'; 

/* 
10 - Find the routes involving two buses that can go from Craiglockhart to Lochend. 
Show the bus no. and company for the first bus, the name of the stop for the transfer, 
and the bus no. and company for the second bus. 
*/ 
SELECT r1.num, 
       r1.company, 
       s2.NAME, 
       r4.num, 
       r4.company 
FROM   route r1 
       JOIN route r2 
         ON r1.company = r2.company 
            AND r1.num = r2.num 
       JOIN route r3 
         ON r2.stop = r3.stop 
       JOIN route r4 
         ON r3.company = r4.company 
            AND r3.num = r4.num 
       JOIN stops s1 
         ON s1.id = r1.stop 
       JOIN stops s2 
         ON s2.id = r2.stop 
       JOIN stops s3 
         ON s3.id = r3.stop 
       JOIN stops s4 
         ON s4.id = r4.stop 
WHERE  s1.NAME = 'Craiglockhart' 
       AND s4.NAME = 'Lochend' 
       AND s2.NAME = s3.NAME 
ORDER  BY Length(r1.num), 
          r1.num; 