-- Group hosts by CPU number and sort by their memory size in descending order(within each cpu_number group)
SELECT cpu_number,host_id,total_mem
FROM host_info i
JOIN host_usage u
    ON i.id = u.host_id
ORDER BY cpu_number, total_mem DESC;


-- Function that rounds up timestamp to the nearest 5 mins interval
CREATE FUNCTION round5(ts timestamp) RETURNS timestamp AS
$$
BEGIN
    RETURN date_trunc('hour', ts) + date_part('minute', ts):: int / 5 * interval '5 min';
END;
$$
    LANGUAGE PLPGSQL;


-- Average used memory in percentage over 5 mins interval for each host. (used memory = total memory - free memory)
SELECT host_id, hostname, round5(u.timestamp) AS five_min_interval_timestamp,
       cast(AVG(((cast(total_mem AS float) - memory_free*1000)/total_mem*100)) AS int) -- Note that total_mem is in kb
           AS avg_used_mem_percentage                                                  -- And memory_free is in mb
FROM host_usage u
JOIN host_info i
     ON i.id = u.host_id
GROUP BY five_min_interval_timestamp, host_id, hostname
ORDER BY host_id, five_min_interval_timestamp;


-- Detect host failure
SELECT host_id, round5(u.timestamp) AS ts, count(*) as num_data_points
FROM host_usage u
         JOIN host_info i
              ON i.id = u.host_id
GROUP BY ts, host_id
ORDER BY host_id, ts