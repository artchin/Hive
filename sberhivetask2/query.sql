use chupahinar;

select date_time, count(1) as visits from logs
group by date_time
order by visits DESC;