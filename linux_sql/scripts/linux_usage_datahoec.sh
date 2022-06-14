#! /bin/sh

#Get cpu info
specs=$(lscpu)
#get memory info
mem_info=$(cat /proc/meminfo)
#get disk info
disk_info=$(df -BM /)

#hardware
hostname=$(hostname -f)
vmstat=$(vmstat -s)
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out"  | egrep "^Architecture:" | awk '{print $2}' | xargs)
cpu_model=$(echo "$lscpu_out"  | egrep "^Model name:" | awk '{print $3, $4, $5, $6, $7}' | xargs)
cpu_mhz=$(echo "$lscpu_out"  | egrep "^CPU MHz:" | awk '{print $3}' | xargs)
l2_cache=$(echo "$lscpu_out"  | egrep "^L2 cache:" | awk '{print $3}' | xargs) #in kB
total_mem=$(echo "$memory_out"  | egrep "^Mem:" | awk '{print $2}' | xargs) #in kB
timestamp=$(TZ=UTC date +"%Y-%m-%d %H:%M:%S") #current timestamp in `2019-11-26 14:40:19` format

#usage
memory_free=$(echo "$mem_info"  | egrep "MemFree" | awk '{ printf "%d\n", $2/1000}' | xargs) #in MB, note that we could have used vmstat --unit M
cpu_idle=$(vmstat 1 2|tail -1 | awk '{print $15}' | xargs) #vmstat without arguments will provide cpu idle since boot
                                                           #Hence, we set arguments to 1 and 2 to capture value in percentage from the past second
cpu_kernel=$(vmstat 1 2 | tail -1 | awk '{print $13 }' | xargs) #in percentage
disk_io=$(vmstat --unit M | tail -1 | awk '{print $9 + $10}') #number of disk I/O blocks
disk_available=$(echo "$disk_info"  | egrep "/dev/sda2" | awk '{print substr($4, 1, length($4) - 1)}' | xargs) #root directory available disk in MB