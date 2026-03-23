def three_consecutive_distinct(s, i):
    if i < 0 or i + 2 >= len(s):
        return False
    c1, c2, c3 = s[i], s[i + 1], s[i + 2]
    return c1 != c2 and c1 != c3 and c2 != c3

def is_happy_spec(s, result):
    if len(s) < 3:
        expected = False
    else:
        expected = True
        for i in range(len(s) - 2):
            if not three_consecutive_distinct(s, i):
                expected = False
                break
    return expected == result

def _impl(s):
    if len(s) < 3: return False
    for i in range(len(s) - 2):
        if s[i] == s[i + 1] or s[i] == s[i + 2] or s[i + 1] == s[i + 2]:
            return False
    return True

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_happy_spec(*input, output))

def is_happy(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
