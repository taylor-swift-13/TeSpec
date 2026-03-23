def match_at(i, input, substr):
    if len(substr) == 0:
        return False
    if i + len(substr) > len(input):
        return False
    for j in range(len(substr)):
        if input[i + j] != substr[j]:
            return False
    return True

def problem_18_pre(input, substring):
    return True

def problem_18_spec(input, substring, output):
    count = 0
    if len(substring) > 0:
        for i in range(len(input) - len(substring) + 1):
            if match_at(i, input, substring):
                count += 1
    return output == count

def _impl(string: str, substring: str) -> int:
    occurences = 0
    for i in range(len(string)):
        if string[i:].startswith(substring):
            occurences += 1
    return occurences

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_18_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_18_spec(*input, output))

def how_many_times(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
