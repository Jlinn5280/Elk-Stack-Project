#!/bin/bash

#Check if script was run as root. Exit if true.
if [ $UID -eq 0 ]
then
  echo "Please do not run this script as root."
  exit
fi

# Define Variables
output=$HOME/research/sys_info.txt
ip=$(ip addr | grep inet | tail -3 | head -1 | awk {'print $2'})
execs=$(find /home -type f -perm 777)
#suids=$(sudo find / -typr f -perm /4000 2> /dev/null)

# Check for research directory. Create it if needed.
if [ ! -d $HOME/research ]
then
  mkdir $HOME/research
fi

# Check for output file. Clear it if needed.
if [ -f $output ]
then
  > $output
fi


#First class script below
#Create directory for output

echo "A Quick System Audit Script" >> $output
date >> $output
echo "" >> $output
#Lists machine information
echo "Machine Type Info:" >> $output
echo $MACHTYPE >> $output
echo -e "Uname info: $(uname -a) \n" >> $output
#Lists connection information
echo -e "IP Info:" >> $output
echo -e "$ip /n" >> $output
echo -e "Hostname: $(hostname -s) \n" >> $output
echo "DNS Servers: " >> $output
cat /etc/resolv.conf >> $output
#Lists internal information
echo -e "\nMemory Info:" >> $output
free >> $output
echo -e "\nCPU Info" >> $output
lscpu | grep CPU >> $output
echo -e "\nDisk Usage:" >> $output
df -H | head -2 >> $output
echo -e "\nWho is logged in: \n $(who -a) \n" >> $output
#Lists executable files and processes
echo -e "\nExec Files" >> $output
echo $execs >> $output
echo -e "\nTop 10 Processes" >> $output
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> $output
