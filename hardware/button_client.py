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
    global IP, OUT_PORT, BUTTONS, DEBUG

    with open(CONFIG_PATH, 'r') as f:
        data = toml.load(f)

    DEBUG = data['debug']['DEBUG']
    IP = data['network']['IP']
    OUT_PORT = data['network']['OUT_PORT']
    BUTTONS = [data['buttons'][but] for but in data['buttons']]
    CLIENT = udp_client.SimpleUDPClient(IP, OUT_PORT)


def button_isr_routine(gpio):
    if gpio.read() == PRESSED:
        debug(DEBUG, "PRESSED")
    else:
        debug(DEBUG, "RELEASED")


def button_config(pin):
    button = mraa.Gpio(pin)
    button.dir(mraa.DIR_IN)
    # button.mode(mraa.MODE_PULLUP)
    button.isr(mraa.EDGE_BOTH, button_isr_routine, button)
    return button


if __name__ == '__main__':
    init_config()
    BUTTONS_DATA = [(button_config(but['PIN']), but['ADDRESS'])
                    for but in BUTTONS]
    print(BUTTONS_DATA)
    pause()
