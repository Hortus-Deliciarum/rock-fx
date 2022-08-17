#!/usr/bin/env bash

# COLORS

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

DIR_SYSTEMD="/etc/systemd/system"
DIR_HOMEROCK="/home/rock"
COPY_SERVICES=( "rotary_client.service" "rotary_server.service" "rock_jackd.service" "rock_puredata.service" )
COPY_FILES=( ".jackdrc" ".puredata" )
SERVICES=( "rotary_client" "rotary_server" "rock_jackd" "rock_puredata")
figlet -c "Lem in Rock"
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
    systemctl start $service
    systemctl enable $service
done

echo -e "${NC}"
echo
echo "=== RUNNING daemon-reload... ==="
sleep 1

systemctl daemon-reload

echo
figlet -c  DONE
