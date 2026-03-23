def abs_diff(a, b):
    return abs(a - b)

def compare_spec(game, guess, result):
    if len(game) != len(guess) or len(guess) != len(result):
        return False
    for g, gu, r in zip(game, guess, result):
        if r != abs_diff(g, gu):
            return False
    return True
