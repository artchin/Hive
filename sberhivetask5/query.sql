USE chupahinar;

set hive.exec.parallel=True;
set hive.exec.parallel.thread.number=8;
set mapreduce.job.reduces=30;


--10 ROWS
SELECT 
    i.region,
    SUM(IF(u.sex = 'male', 1, 0)) AS male,
    SUM(IF(u.sex = 'female', 1, 0)) AS female
FROM logs TABLESAMPLE (10 ROWS) l
JOIN ipregions i ON i.ip = l.ip
JOIN users u ON u.ip = l.ip
GROUP BY i.region
ORDER BY male DESC
LIMIT 5;

--50 ROWS
SELECT 
    i.region,
    SUM(IF(u.sex = 'male', 1, 0)) AS male,
    SUM(IF(u.sex = 'female', 1, 0)) AS female
FROM logs TABLESAMPLE (50 ROWS) l
JOIN ipregions i ON i.ip = l.ip
JOIN users u ON u.ip = l.ip
GROUP BY i.region
ORDER BY male DESC
LIMIT 5;

--100 ROWS
SELECT 
    i.region,
    SUM(IF(u.sex = 'male', 1, 0)) AS male,
    SUM(IF(u.sex = 'female', 1, 0)) AS female
FROM logs TABLESAMPLE (100 ROWS) l
JOIN ipregions i ON i.ip = l.ip
JOIN users u ON u.ip = l.ip
GROUP BY i.region
ORDER BY male DESC
LIMIT 5;