#!/usr/bin/env bash

DIR_SYSTEMD="/etc/systemd/system"
DIR_HOMEROCK="/home/rock"
COPY_SERVICES=( "rotary_client.service" "rotary_server.service" "rock_jackd.service" "rock_puredata.service" )
COPY_FILES=( ".jackdrc" ".puredata" )
SERVICES=( "rotary_client" "rotary_server" "rock_jackd" "rock_puredata")

echo
echo "COPYING FILES..."

for service in ${COPY_SERVICES[@]}; do
    echo -e "\tcopying $service in $DIR_SYSTEMD"
    cp $service $DIR_SYSTEMD
done

for file in ${COPY_FILES[@]}; do
    echo -e "\tcopying $file in $DIR_HOMEROCK"
    cp -rv $file $DIR_HOMEROCK
done

echo
echo "STARTING & ENABLING SERVICES"

for service in ${SERVICES[@]}; do
    echo -e "starting/enabling $service"
    systemctl start $service
    systemctl enable $service
done

echo
echo "RUNNING daemon-reload..."
systemctl daemon-reload

echo
echo "DONE"
