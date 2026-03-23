def _orig_problem_152_pre(game, guess):
    return len(game) == len(guess)

def _orig_problem_152_spec(game, guess, output):
    if len(game) != len(guess):
        return False
    if len(output) != len(game):
        return False
    for i in range(len(game)):
        if output[i] != abs(game[i] - guess[i]):
            return False
    return True

def problem_152_pre(game, guess):
    return bool(_orig_problem_152_pre(game, guess))

def problem_152_spec(game, guess, output):
    return bool(_orig_problem_152_spec(game, guess, output))
