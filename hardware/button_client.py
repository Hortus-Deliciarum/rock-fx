#!/usr/bin/env python3

from pathlib import Path
from signal import pause
import mraa
import toml
from pythonosc import udp_client
from debugs import debug

DEBUG = None
IP = None
OUT_PORT = None
BUTTONS = None
BUTTONS_DATA = None
CLIENT = None
MAINPATH = Path(__file__).parent.absolute()
CONFIG_PATH = MAINPATH / Path('rot_config.toml')
PRESSED = 0
RELEASED = 1


def init_config():
    """config global labels"""
    global IP, OUT_PORT, BUTTONS, DEBUG

    with open(CONFIG_PATH, 'r') as c_file:
        data = toml.load(c_file)

    DEBUG = data['debug']['DEBUG']
    IP = data['network']['IP']
    OUT_PORT = data['network']['OUT_PORT']
    BUTTONS = [data['buttons'][but] for but in data['buttons']]


class But:
    """class for button id and handling"""
    N_INDEX = 0
    PRESSED = 0
    RELEASED = 1

    def __init__(self, pin, address):
        self.idx = But.N_INDEX
        self.button = mraa.Gpio(pin)
        self.button.dir(mraa.DIR_IN)
        self.address = address
        self.last = RELEASED
        But.N_INDEX += 1

    def update(self, sender_func):
        """update and check new button state"""
        value = self.button.read()
        if value != self.last:
            self.last = value
            debug(
                DEBUG, f"button number: {self.idx}\t{self.address}: {1 - value}")
            sender_func(self.address, 1 - value)
            return value
        else:
            return None


if __name__ == '__main__':
    init_config()
    client = udp_client.SimpleUDPClient(IP, OUT_PORT)

    buttons = [But(but['PIN'], but['ADDRESS']) for but in BUTTONS]

    while True:
        list(map(lambda x: x.update(client.send_message), buttons))
