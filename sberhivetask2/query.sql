select date_time, count(*) as visits from logs
group by date_time
order by visits DESC;