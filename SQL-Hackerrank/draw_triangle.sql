-- 1) Draw The Triangle 1
SET @star = 21;
SELECT REPEAT('* ', @star := @star-1) FROM information_schema.tables LIMIT 20;

-- 2) Draw The Triangle 2
SET @star = 0;
SELECT REPEAT('* ', @star := @star+1) FROM information_schema.tables LIMIT 20;

-- OBS: This code just works on mysql