def abs_diff(a, b):
    return abs(a - b)

def _orig_compare_spec(game, guess, output):
    if len(game) != len(guess) or len(guess) != len(output):
        return False
    for (g, gu, r) in zip(game, guess, output):
        if r != abs_diff(g, gu):
            return False
    return True

def compare_spec(game, guess, output):
    return bool(_orig_compare_spec(game, guess, output))
