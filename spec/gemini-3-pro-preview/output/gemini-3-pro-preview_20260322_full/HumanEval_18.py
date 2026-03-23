def how_many_times_spec(s: str, sub: str, res: int) -> bool:
    count = sum(1 for i in range(len(s)) if s[i:i+len(sub)] == sub)
    return res == count

def _impl(string: str, substring: str) -> int:
    occurences = 0
    for i in range(len(string)):
        if string[i:].startswith(substring):
            occurences += 1
    return occurences

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(how_many_times_spec(*input, output))

def how_many_times(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
