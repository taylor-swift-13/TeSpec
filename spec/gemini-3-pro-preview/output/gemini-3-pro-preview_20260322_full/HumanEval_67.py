def split(s: str, sep: str) -> list:
    return s.split(sep)

def to_int(s: str) -> int:
    try:
        return int(s)
    except ValueError:
        return 0

def fruit_distribution_spec(s: str, n: int, res: int) -> bool:
    words = split(s, " ")
    c1_str = words[0] if len(words) > 0 else ""
    c2_str = words[3] if len(words) > 3 else ""
    
    c1 = to_int(c1_str)
    c2 = to_int(c2_str)
    
    return (n - c1 - c2 >= 0) and (res == n - c1 - c2)

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
