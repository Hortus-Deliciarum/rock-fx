#!/usr/bin/env bash

# COLORS

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

DIR_SYSTEMD="/etc/systemd/system"
DIR_HOMEROCK="/home/neum"
DIR_PATCH="$DIR_HOMEROCK/Documenti/Hortus-Deliciarum/rock-fx/patches"
PUREDATA=".puredata"
COPY_SERVICES=( "rotary_client.service" "rotary_server.service" "rock_jackd.service" "rock_puredata.service" )
COPY_FILES=( ".jackdrc" ".puredata" )
SERVICES=( "rotary_client" "rotary_server" "rock_jackd" "rock_puredata")
FILES=(`ls -C $DIR_PATCH/*.pd`)

length=${#files[@]}
counter=1

set_patch() {
    echo "#!/usr/bin/env bash" > $DIR_HOMEROCK/$PUREDATA
    echo puredata -nogui -jack $1 > $DIR_HOMEROCK/$PUREDATA
}

# BANNER

clear
echo
figlet -ck -f pagga "Lem in Rock"
figlet -ck -f future configuration
sleep 2

# CHOOSE PATCH

echo 
for i in ${FILES[@]}; do 
    #echo "$counter) $i" 
    echo "($counter) $(basename $i)"
    counter=$(( $counter + 1))
done 

control=1
echo 

while [[ control -eq 1 ]]; do 
    printf "Choose a patch by index: "
    read n
    index=$(( $n - 1 ))
    
    if [[ $index -gt $(( $length - 1 )) || $index -lt 0 ]]
        then 
            echo "Index out of range, please retry..."
        else
            set_patch ${files[$index]}
            control=0
    fi 
done

# OPERATIONS

echo
echo "=== COPYING SERVICES AND FILES... ==="
sleep 1

for service in ${COPY_SERVICES[@]}; do
    echo -e "${GREEN}\tcopying $service in $DIR_SYSTEMD"
    cp $service $DIR_SYSTEMD
done

for file in ${COPY_FILES[@]}; do
    echo -e "\tcopying $file in $DIR_HOMEROCK"
    cp $file $DIR_HOMEROCK
done

echo -e "${NC}"

echo
echo "=== STARTING & ENABLING SERVICES ==="
sleep 1

for service in ${SERVICES[@]}; do
    echo -e "${GREEN} \tstarting/enabling $service"
    systemctl start $service > /dev/null 2>&1
    systemctl enable $service > /dev/null 2>&1
done

echo -e "${NC}"
echo
echo "=== RUNNING daemon-reload... ==="
sleep 1

systemctl daemon-reload

echo
figlet -c  DONE
