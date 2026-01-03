use chupahinar;

SELECT TRANSFORM (ip, url, response_size, url_code, client_app, date_time)
USING 'sed "s/\.ru\//.com\//"'
AS (ip, url, response_size, url_code, client_app, date_time)
from logs 
limit 10;