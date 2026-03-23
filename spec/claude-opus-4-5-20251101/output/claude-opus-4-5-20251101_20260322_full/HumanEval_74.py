def string_length(s: str) -> int:
    return len(s)

def total_chars(lst: list) -> int:
    return sum(string_length(s) for s in lst)

def total_match_spec(lst1: list, lst2: list, result: list) -> bool:
    c1 = total_chars(lst1)
    c2 = total_chars(lst2)
    if c1 <= c2:
        return result == lst1
    else:
        return result == lst2

def _impl(lst1, lst2):
    c1, c2 = sum(map(lambda s: len(s), lst1)), sum(map(lambda s: len(s), lst2))
    return lst1 if c1 <= c2 else lst2

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(total_match_spec(*input, output))

def total_match(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
