#!/usr/bin/env bash

echo
echo "COPYING FILES..."
cp rotary_client.service /etc/systemd/system/.
cp rotary_server.service /etc/systemd/system/.
cp rock_jackd.service /etc/systemd/system/.
cp rock_puredata.service /etc/systemd/system/.
cp -rv .jackdrc /home/rock/.
cp -rv .puredata /home/rock/.

echo
echo "STARTING & ENABLING SERVICES"
systemctl start rotary_client
systemctl start rotary_server
systemctl start rock_jackd
systemctl start rock_puredata
systemctl enable rotary_client
systemctl enable rotary_server
systemctl enable rock_jackd
systemctl enable rock_puredata

echo
echo "RUNNING daemon-reload..."
systemctl daemon-reload

echo
echo "DONE"
