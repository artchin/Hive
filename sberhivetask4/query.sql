use chupahinar;

SELECT TRANSFORM (ip, url, size, code, browser, date_time)
USING 'sed "s/\.ru\//.com\//"'
AS (ip, url, size, code, browser, date_time)
from logs 
limit 10;