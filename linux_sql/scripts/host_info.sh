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

#Get cpu info
specs=$(lscpu)
#get memory info
mem_info=$(cat /proc/meminfo)

#Retrieve hardware specific variables
hostname=$(hostname -f)
cpu_number=$(echo "$specs"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$specs"  | egrep "^Architecture:" | awk '{print $2}' | xargs)
cpu_model=$(echo "$specs"  | egrep "^Model name:" | awk '{print $3, $4, $5, $6, $7}' | xargs)
cpu_mhz=$(echo "$specs"  | egrep "^CPU MHz:" | awk '{print $3}' | xargs)
l2_cache=$(echo "$specs"  | egrep "^L2 cache:" | awk '{print substr($3, 1, length($3) - 1)}' | xargs) #in kB
total_mem=$(echo "$mem_info"  | egrep "^MemTotal:" | awk '{print $2}' | xargs) #in kB
timestamp=$(TZ=UTC date +"%Y-%m-%d %H:%M:%S") #current timestamp in `2019-11-26 14:40:19` format

#PSQL command: Inserts server usage data into host_usage table
#Note: be careful with double and single quotes
insert_stmt="INSERT INTO host_info(hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, L2_cache, total_mem, timestamp)
             VALUES('$hostname', '$cpu_number', '$cpu_architecture', '$cpu_model', '$cpu_mhz', '$l2_cache', '$total_mem', '$timestamp')";

#set up env var for psql cmd
export PGPASSWORD=$psql_password
#Insert date into a database
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?
