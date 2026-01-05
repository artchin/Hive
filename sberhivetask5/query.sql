USE chupahinar;

set hive.exec.parallel=True;
set hive.exec.parallel.thread.number=8;
set mapreduce.job.reduces=30;


--all
SELECT 
    i.region,
    SUM(IF(u.sex = 'male', 1, 0)) AS male,
    SUM(IF(u.sex = 'female', 1, 0)) AS female
FROM logs l
JOIN ipregions i ON i.ip = l.ip
JOIN users u ON u.ip = l.ip
GROUP BY i.region;

--1k
SELECT 
    i.region,
    SUM(IF(u.sex = 'male', 1, 0)) AS male,
    SUM(IF(u.sex = 'female', 1, 0)) AS female
FROM logs TABLESAMPLE (1000 ROWS) l
JOIN ipregions i ON i.ip = l.ip
JOIN users u ON u.ip = l.ip
GROUP BY i.region;

--10k
SELECT 
    i.region,
    SUM(IF(u.sex = 'male', 1, 0)) AS male,
    SUM(IF(u.sex = 'female', 1, 0)) AS female
FROM logs TABLESAMPLE (10000 ROWS) l
JOIN ipregions i ON i.ip = l.ip
JOIN users u ON u.ip = l.ip
GROUP BY i.region;