select Extract(year from sysdate) as year, Extract(month from sysdate) as month, Extract(day from sysdate) as day,
      Extract(hour from cast(sysdate as timestamp)) as hour, Extract(minute from cast(sysdate as timestamp)) as minute,
      Extract(second from cast(sysdate as timestamp)) as second
  from dual;

select sysdate, add_months(sysdate, -12) as beforenextyear, sysdate + 1/24 as nexthour, sysdate - 2 * interval '3' hour as hourbefor6
  from dual;
-- interval 可用于年月日时分秒
-- + - 用于天，可以用小数来处理时分秒，也可以用倍数处理天，月，年，月年还可以用add_months(sysdate,12)
-- numtodsinterval处理时 分 秒sysdate+numtodsinterval(3,'hour'), numtoyminterval处理年月sysdate+numtoyminterval(3,'year')

-- 获取两个时间之间的秒数
select ROUND(TO_NUMBER((sysdate + 25 / (60 * 60 * 24)) - sysdate) * 24 * 60 * 60) as second from dual;
select months_between(sysdate, date'1971-05-18') from dual;
-- 获取时间差
select extract(hour from cast(SYSDATE + 2 / 24 as timestamp) - SYSDATE) AS HOUR
  from dual;

-- 没有秒
select timestamp'2017-02-12 15:18:23.365478', date'2017-02-12',trunc(sysdate,'year'), trunc(sysdate,'month'), trunc(sysdate), trunc(sysdate,'hh24'), trunc(sysdate,'mi') from dual;