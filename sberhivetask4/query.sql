using chupahinar;

SELECT TRANSFORM (ip, url, size, code, browser, date)
USING 'sed "s/\.ru\//.com\//"'
AS (ip, url, size, code, browser, date)
from logs 
limit 10;