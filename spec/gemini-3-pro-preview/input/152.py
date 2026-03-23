def _orig_compare_spec(game, guess, output):
    if len(game) != len(guess):
        return False
    if len(output) != len(game):
        return False
    for i in range(len(game)):
        if output[i] != abs(game[i] - guess[i]):
            return False
    return True

def compare_spec(game, guess, output):
    return bool(_orig_compare_spec(game, guess, output))
