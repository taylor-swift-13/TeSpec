def compare_spec(game, guess, result):
    if len(game) != len(guess):
        return False
    if len(result) != len(game):
        return False
    for i in range(len(game)):
        if result[i] != abs(game[i] - guess[i]):
            return False
    return True

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
