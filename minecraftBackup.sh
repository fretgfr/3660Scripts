#!/bin/bash
#Script to backup minecraft server world files

#current date and time
dateSec=date +%s
#the current date
date=date
#directory where backups are saved
saveDir="/usr/local/CSI3660ProjectBackup/minecraftBackup/backups"

#this colors text 
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAG='\033[0;35m'
#no text color
NC='\033[0m'

#this compresses minecraft world folder and labels it backup_(date and time).tar.gz
#it then creates a log in backup.log with confirmation of the back up along with date and time it happened

backup(){
cd $saveDir && tar -cPzf backup_(date +%F_%H%M).tar.gz /usr/local/minecraft-server/world
cd /usr/local/CSI3660ProjectBackup/minecraftBackup && echo "Backup complete on: $date at $dateSec seoncds located in $saveDir" >> /usr/local/CSI3660ProjectBackup/minecraftBackup/backup.log 2>&1
}

startBackup(){
echo ""
echo -e "${GREEN}Creating${NC} ${CYAN}backup${NC} ${BLUE}file${NC} ${RED}for${NC} ${MAG}minecraft${NC} ${GREEN}server${NC} ${CYAN}world${NC} ${BLUE}files${NC}"
backup &
spin &
pid=$!

for i in seq 1 5
do
        sleep 1
done
kill $pid
}

spin(){
while [ 1 ]
do
        echo -ne "${GREEN}.${NC}"
        sleep 0.2
done
}
startBackup

echo "Sucess! New backup created"
echo "Check /usr/local/CSI3660ProjectBackup/minecraftBackup/backup.log for deatils"
echo ""

sleep 1

#this checks the backup files if they need to be deleted or kept based on the date and time it was created.

#it does this by subtracting todays date and time by the files date and time it was created
#if the result is grater than 84600, or one day, it will remove the file. if it is less than
echo ""
echo "Checking for old backups"
echo ""

#finds all files in backup directory with file extension .tar.gz
#this gathers all files with the extension .tar.gz in the back up directory

matchedFiles=find /usr/local/CSI3660ProjectBackup/minecraftBackup/backups -name *.tar.gz
for file in $matchedFiles
do
        #this takes the tar.gz in the backups directory and displays the date and time file was made
        x=date +%s -r $file
        #this subtracts the current date and time from the .tar.gz files time it was created
        y="$(($dateSec-$x))"
        echo ""
        echo "File Info:"
        echo "File name: $file"
        echo "File date and time created: $x"
        echo "Current date minus file date: $y"
                sleep .5
        echo ""

        if [[ $y -gt 86400 ]]
        then
                                echo -e "${RED}Removed file:${NC} $file $date"
                echo "Removed file: $file $date" >> /usr/local/CSI3660ProjectBackup/minecraftBackup/backup.log 2>&1
                rm $file
        else
                                echo -e "${GREEN}Keeping file:${NC} $file $date"
                echo ""
        fi
done
