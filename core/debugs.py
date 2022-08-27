from colorama import Fore


def debug(deb, txt):
    """debug printing"""
    if deb:
        print(Fore.CYAN + txt + Fore.WHITE)
