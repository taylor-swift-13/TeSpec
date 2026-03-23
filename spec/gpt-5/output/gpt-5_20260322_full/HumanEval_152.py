def compare_spec(game, guess, out):
    if len(game) != len(guess):
        return False
    expected_out = [abs(a - b) for a, b in zip(game, guess)]
    return out == expected_out

def _impl(game, guess):
    return [abs(game[i] - guess[i]) for i in range(len(game))]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(compare_spec(*input, output))

def compare(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
