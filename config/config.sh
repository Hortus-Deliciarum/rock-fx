#!/usr/bin/env bash

cp rotary_client.service /etc/systemd/system/.
cp rotary_server.service /etc/systemd/system/.
cp rock_jackd.service /etc/systemd/system/.
systemctl start rotary_client
systemctl start rotary_server
systemctl start rock_jackd
systemctl enable rotary_client
systemctl enable rotary_server
systemctl enable rock_jackd
echo "running daemon-reload..."
systemctl daemon-reload
