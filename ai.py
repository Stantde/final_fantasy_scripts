import datetime
import recorder

class AI:
    def __init__(self, name=None):
        if not name:
            name = "Bob"
        now = datetime.datetime.now()
        name += now.strftime("%d_%m_%Y_%H_%M_%S")
    behavior_log = []
    learned_lessons = []

def RATS():
    """ Read All The Screen"""
    now = datetime.datetime.now()       
    recorder.read_screen(self.name + now.strftime("%d_%m_%Y_%H_%M_%S"))
    return None

def get_state():
    ...

def start_game(game_mode=None):    
    """ Navigate through load screens and load up game."""
    if not game_mode: # start new game
        ...
    else: #continue existing game
        ...

    ...