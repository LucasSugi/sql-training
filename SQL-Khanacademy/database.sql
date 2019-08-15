/*
1 - We've created a database for a documents app, with rows for each document with it's title, content, and author.
In this first step, use UPDATE to change the author to 'Jackie Draper' for all rows where it's currently 'Jackie Paper'.
Then re-select all the rows to make sure the table changed like you expected.
*/
UPDATE documents
SET author = 'Jackie Draper'
WHERE author = 'Jackie Paper';

SELECT * FROM documents;

/*
2 - Now you'll delete a row, being very careful not to delete all the rows.
Only delete the row where the title is 'Things I'm Afraid Of'.
Then re-select all the rows to make sure the table changed like you expected.
*/
DELETE FROM documents
WHERE title = "Things I'm Afraid Of";

SELECT * FROM documents;

/*
3 - We've created a database of clothes, and decided we need a price column.
Use ALTER to add a 'price' column to the table.
Then select all the columns in each row to see what your table looks like now.
*/
ALTER TABLE clothes ADD COLUMN price NUMERIC;
SELECT * FROM clothes;

/*
4 - Now assign each item a price, using UPDATE - item 1 should be 10 dollars, item 2 should be 20 dollars, item 3 should be 30 dollars.
When you're done, do another SELECT of all the rows to check that it worked as expected.
*/
UPDATE clothes
SET PRICE = 10
WHERE id = 1;

UPDATE clothes
SET PRICE = 20
WHERE id = 2;

UPDATE clothes
SET PRICE = 30
WHERE id = 3;

SELECT * FROM clothes;

/*
5 - Now insert a new item into the table that has all three attributes filled in, including 'price'.
Do one final SELECT of all the rows to check it worked.*/
INSERT INTO clothes VALUES (4,'blazer','red',40);
SELECT * FROM clothes;