import datetime
import sys

def read_screen():
    """ Takes screen shots every couple seconds until stop condition is met?"""
    try:       
        import pyautogui
    except ModuleNotFoundError:
        print("Please install modules in requirements.txt.")
        sys.exit()
    pyautogui.PAUSE = 2.5
    pyautogui.screenshot(location)
    return 