#! /bin/sh

#Assign CLI arguments to variables
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

#Check to make sure there are no missing arguments
if [ $# -ne 5 ]; then
  echo "missing arguments"
  exit 1
fi


#get memory info
mem_info=$(cat /proc/meminfo)
#get disk info
disk_info=$(df -BM /)
#get hostname
hostname=$(hostname -f)

#usage
memory_free=$(echo "$mem_info"  | egrep "MemFree" | awk '{ printf "%d\n", $2/1000}' | xargs) #in MB, note that we could have used vmstat --unit M
cpu_idle=$(vmstat 1 2|tail -1 | awk '{print $15}' | xargs) #vmstat without arguments will provide cpu idle since boot
                                                           #Hence, we set arguments to 1 and 2 to capture value in percentage from the past second
cpu_kernel=$(vmstat 1 2 | tail -1 | awk '{print $13 }' | xargs) #in percentage
disk_io=$(vmstat --unit M | tail -1 | awk '{print $9 + $10}') #number of disk I/O blocks
disk_available=$(echo "$disk_info"  | egrep "/dev/sda2" | awk '{print substr($4, 1, length($4) - 1)}' | xargs) #root directory available disk in MB
timestamp=$(TZ=UTC date +"%Y-%m-%d %H:%M:%S") #current timestamp in `2019-11-26 14:40:19` format

#Subquery to find matching id from host_info table
host_id="(SELECT id FROM host_info WHERE hostname='$hostname')";

insert_stmt="INSERT INTO host_usage("timestamp", host_id, memory_free, cpu_idle, cpu_kernel, disk_io, disk_available)
             VALUES('$timestamp', $host_id, '$memory_free', '$cpu_idle', '$cpu_kernel', '$disk_io', '$disk_available')";

#set up env var for psql cmd
export PGPASSWORD=$psql_password
#Insert date into a database
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?