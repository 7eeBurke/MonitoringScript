# Bash script to monitor LoadPercentage, Memory Usage, Disk Usage, and Network Stats. Updates every 5 seconds

# For Windows Machines

while true
    do
        
        # CPU Load Percentage
        cpu_usage=$(wmic cpu get loadpercentage | grep -Eo '[0-9]+') 

        # Physical Memory Usage Percentage
        total_memory=$(wmic computersystem get TotalPhysicalMemory | grep -Eo '[0-9]+')
        available_memory=$(wmic os get FreePhysicalMemory | grep -Eo '[0-9]+')
        memory_usage=$(awk "BEGIN { printf \"%.2f\", (($total_memory - $available_memory) / $total_memory) * 100 }")

        # Disk Usage Percentage
        disk_usage=$(df -k | awk 'NR>1 {print $6}')

        # Network Statistics
        network_stats=$(netstat -e | awk 'NR==5 {print "Bytes Received:", $2, "Bytes Sent:", $3}')

        echo "CPU Load Percentage: $cpu_usage%"
        echo "Memory Usage: $memory_usage%"
        echo "Disk Usage: $disk_usage"
        echo "Network Statistics: $network_stats"
        echo ""

        sleep 5
    done