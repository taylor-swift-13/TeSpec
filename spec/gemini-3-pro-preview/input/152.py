def compare_spec(game, guess, result):
    if len(game) != len(guess):
        return False
    if len(result) != len(game):
        return False
    for i in range(len(game)):
        if result[i] != abs(game[i] - guess[i]):
            return False
    return True
