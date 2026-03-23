def fruit_distribution_spec(apples: int, oranges: int, n: int, result: int) -> bool:
    return (apples >= 0 and
            oranges >= 0 and
            n >= 0 and
            n - apples - oranges >= 0 and
            result == n - apples - oranges)

def _impl(s, n):
    words = s.split(" ")
    c1, c2 = int(words[0]), int(words[3])
    assert n - c1 - c2 >= 0, "invalid inputs" # $_CONTRACT_$
    return n - c1 - c2

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(fruit_distribution_spec(*input, output))

def fruit_distribution(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
