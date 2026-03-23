def problem_152_pre(game, guess):
    return len(game) == len(guess)

def problem_152_spec(game, guess, result):
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
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_152_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_152_spec(*input, output))

def compare(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
