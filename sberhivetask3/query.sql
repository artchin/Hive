USE chupahinar;

set hive.exec.parallel=True;
set hive.exec.parallel.thread.number=8;
set hive.auto.convert.join = False;
set mapreduce.job.reduces=82;

SELECT 
    i.region,
    SUM(IF(u.sex = 'male', 1, 0)) AS male,
    SUM(IF(u.sex = 'female', 1, 0)) AS female
FROM logs l
JOIN ipregions i ON i.ip = l.ip
JOIN users u ON u.ip = l.ip
GROUP BY i.region;
