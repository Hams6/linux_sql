#! /bin/sh

#Get cpu info
specs=$(lscpu)
#get memory info
mem_info=$(cat /proc/meminfo)

#hardware
hostname=$(hostname -f)
vmstat=$(vmstat -s)
cpu_number=$(echo "$specs"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$specs"  | egrep "^Architecture:" | awk '{print $2}' | xargs)
cpu_model=$(echo "$specs"  | egrep "^Model name:" | awk '{print $3, $4, $5, $6, $7}' | xargs)
cpu_mhz=$(echo "$specs"  | egrep "^CPU MHz:" | awk '{print $3}' | xargs)
l2_cache=$(echo "$specs"  | egrep "^L2 cache:" | awk '{print $3}' | xargs) #in kB
total_mem=$(echo "$mem_info"  | egrep "^MemTotal:" | awk '{print $2}' | xargs) #in kB
timestamp=$(TZ=UTC date +"%Y-%m-%d %H:%M:%S") #current timestamp in `2019-11-26 14:40:19` format
