-- DDL
CREATE TABLE IF NOT EXISTS PUBLIC.host_info
  (
     id               SERIAL NOT NULL PRIMARY KEY,
     hostname         VARCHAR NOT NULL UNIQUE,
     cpu_number       VARCHAR NOT NULL,
     cpu_architecture VARCHAR NOT NULL,
     cpu_model        VARCHAR NOT NULL,
     cpu_mhz          VARCHAR NOT NULL,
     L2_cache         VARCHAR NOT NULL,
     total_mem        VARCHAR NOT NULL,
     "timestamp"      TIMESTAMP NOT NULL
  );

-- DML
-- INSERT statement
--INSERT INTO host_info (id, hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, L2_cache, total_mem, "timestamp")
--values


-- DDL
CREATE TABLE IF NOT EXISTS PUBLIC.host_usage
  (
     "timestamp"    TIMESTAMP NOT NULL,
     host_id        VARCHAR NOT NULL,
     memory_free    VARCHAR NOT NULL,
     cpu_idle       VARCHAR NOT NULL,
     cpu_kernel     VARCHAR NOT NULL,
     disk_io        VARCHAR NOT NULL,
     disk_available VARCHAR NOT NULL
  );

-- DML
-- INSERT statement
--INSERT INTO host_usage ("timestamp", host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available)
--values