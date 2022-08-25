#!/usr/bin/env python3

import serial
from pythonosc import udp_client

ser = serial.Serial('/dev/ttyUSB0', 115200)  # Start serial communication


def parse_msg(msg):
    address, datum = msg.split(' ')[:2]
    datatyped = None

    try:
        datatyped = int(datum.strip(None))
    except:
        try:
            datatyped = float(datum.strip(None))
        except:
            datatyped = datum

    finally:
        return (address, datatyped)


if __name__ == '__main__':
    client = udp_client.SimpleUDPClient("127.0.0.1", 8000)

    while True:
        data = ser.readline()
        s = data.decode('ascii')
        addr, value = parse_msg(s)
        client.send_message(addr, value)
