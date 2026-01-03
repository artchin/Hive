use chupahinar;
SELECT TRANSFORM (ip, date_time, url, response_size, url_code, client_app)
USING 'sed "s/\.ru\//.com\//"'
AS (ip STRING, date_time STRING, url STRING, response_size INT, url_code INT, client_app STRING)
FROM logs
LIMIT 10;