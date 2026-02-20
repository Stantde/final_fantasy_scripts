import sys

def launch_game():
    """ Launches an instance of Final Fantasy I PR from the steam library."""
    try:       
        import subprocess        
    except ModuleNotFoundError:
        print("Please install modules in requirements.txt.")
        sys.exit()
    subprocess.run("C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY PR\FINAL FANTASY.exe")
    return None


    # open "C:\Program Files (x86)\Steam\Steam.exe"
    # "C:\Program Files (x86)\Steam\steamapps\appmanifest_1173770.acf"
    # "C:\Program Files (x86)\Steam\steamapps\common\FINAL FANTASY PR\FINAL FANTASY.exe"