/*
1 - Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in.
*/
ALTER TABLE movies ADD column Aspect_ratio FLOAT;

/*
2 - Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.
*/
ALTER TABLE movies ADD column Language TEXT DEFAULT 'English';