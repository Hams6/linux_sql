-- DDL
CREATE TABLE IF NOT EXISTS PUBLIC.host_info
  (
     id               SERIAL NOT NULL PRIMARY KEY,
     hostname         VARCHAR NOT NULL UNIQUE,
     cpu_number       int NOT NULL,
     cpu_architecture VARCHAR NOT NULL,
     cpu_model        VARCHAR NOT NULL,
     cpu_mhz          FLOAT NOT NULL,
     L2_cache         int NOT NULL,
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
     host_id        SERIAL NOT NULL,
     memory_free    int NOT NULL,
     cpu_idle       int NOT NULL,
     cpu_kernel     int NOT NULL,
     disk_io        int NOT NULL,
     disk_available int NOT NULL
  );

-- DML
-- INSERT statement
--INSERT INTO host_usage ("timestamp", host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available)
--values