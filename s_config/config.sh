#!/usr/bin/env bash

cd ../hardware
cp rotary_client.service /etc/systemd/system/.
cp rotary_server.service /etc/systemd/system/.
systemctl start rotary_client
systemctl start rotary_server
systemctl enable rotary_client
systemctl enable rotary_server