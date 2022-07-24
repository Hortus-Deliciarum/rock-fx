#!/usr/bin/env python3

from pathlib import Path
import mraa
import toml
from pythonosc import udp_client
from colorama import Fore

DEBUG = None
IP = None
OUT_PORT = None
BUTTONS = None
MAINPATH = Path(__file__).parent.absolute()
CONFIG_PATH = MAINPATH / Path('rot_config.toml')


def init_config():
    global IP, OUT_PORT, BUTTONS, DEBUG

    with open(CONFIG_PATH, 'r') as f:
        data = toml.load(f)

    DEBUG = data['debug']['DEBUG']
    IP = data['network']['IP']
    OUT_PORT = data['network']['OUT_PORT']
    BUTTONS = [data['buttons'][but] for but in data['buttons']]


def debug(txt):
    """debug printing"""
    if DEBUG:
        print(Fore.YELLOW + txt + Fore.WHITE)


def button_isr_routine(gpio):
    debug(f"button value {gpio.read()}")


class Button:
    def __init__(self, pin=None):
        self.__config(pin)

    def __config(self, pin):
        button = mraa.Gpio(pin)
        button.dir(mraa.DIR_IN)
        button.mode(mraa.MODE_PULLDOWN)
        button.isr(mraa.EDGE_BOTH, button_isr_routine, button)


if __name__ == '__main__':
    init_config()
    client = udp_client.SimpleUDPClient(IP, OUT_PORT)
    buttons = [Button(but['PIN']) for but in BUTTONS]
