import launcher # type: ignore
import ai

trainee = ai.AI()
def main():
    launcher.launch_game()
    trainee.start_game()
    return None

if __name__ == '__main__':
    main()
    