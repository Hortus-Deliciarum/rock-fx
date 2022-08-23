from colorama import Fore


def debug(deb, txt):
    """debug printing"""
    if deb:
        print(Fore.BLUE + txt + Fore.WHITE)
