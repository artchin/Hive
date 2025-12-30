ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;

ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;

USE chupahinar;

--создание промежуточной Logs
DROP TABLE IF EXISTS staging_logs;

CREATE EXTERNAL TABLE staging_logs (
    ip STRING,           
    date_time STRING,    
    url STRING,          
    response_size INT,
    url_code INT,
    client_app STRING 
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
    "input.regex" = "^((?:\\d{1,3}\\.){3}\\d{1,3})\\s+(\\d{8})\\d+\\s+(http://[\\w./]+)\\s+(\\d+)\\s+(\\d+)\\s+(.*)$"
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/user_logs_M';

--создание Users
DROP TABLE IF EXISTS Users;

CREATE EXTERNAL TABLE Users (
    ip STRING,           
    browser STRING,    
    sex STRING,          
    age INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
    "input.regex" = "^((?:\\d{1,3}\\.){3}\\d{1,3})\\s+([\\w/.]+)\\s+(\\w+)\\s+(\\d+)$"
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/user_data_M';

-- Проверка
SELECT * FROM users LIMIT 10;

--создание партицированной Logs
SET hive.exec.dynamic.partition.mode=nonstrict;

DROP TABLE IF EXISTS logs;

CREATE EXTERNAL TABLE logs ( ip STRING,
                             url STRING,
                             response_size INT,
                             url_code INT,
                             client_app STRING)
                             PARTITIONED BY (date_time STRING) STORED AS TEXTFILE;
INSERT OVERWRITE TABLE logs PARTITION (date_time)

SELECT ip,
       url,
       response_size,
       url_code,
       client_app,
       date_time
FROM staging_logs;

SELECT * FROM logs LIMIT 10;

--Создание Subnets
DROP TABLE IF EXISTS Subnets;

CREATE EXTERNAL TABLE Subnets (
    ip STRING,
    mask STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY  '\t'
STORED AS TEXTFILE
--LOCATION '/data/subnets/big';
LOCATION '/data/subnets/variant1';

-- Проверка
SELECT * FROM Subnets LIMIT 10;

DROP TABLE IF EXISTS IPRegions;

CREATE EXTERNAL TABLE IPRegions (
    ip STRING,           
    region STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
    "input.regex" = "^((?:\\d{1,3}\\.){3}\\d{1,3})\\s+(.*)$"
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/ip_data_M';

-- Проверка
SELECT * FROM users LIMIT 10;
