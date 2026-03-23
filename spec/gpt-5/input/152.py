def compare_spec(game, guess, out):
    if len(game) != len(guess):
        return False
    expected_out = [abs(a - b) for a, b in zip(game, guess)]
    return out == expected_out
