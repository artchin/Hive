use chupahinar;
SELECT TRANSFORM (ip, url, response_size, url_code, client_app, date_time)
USING 'awk -F"\t" ''{gsub(/\.ru\//, ".com/", $2); print $1"\t"$6"\t"$2"\t"$3"\t"$4"\t"$5}'''
AS (ip STRING, date_time STRING, url STRING, response_size INT, url_code INT, client_app STRING)
FROM logs
LIMIT 10;