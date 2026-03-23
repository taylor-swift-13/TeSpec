def get_max_triples_spec(n, count):
    if n <= 2:
        expected = 0
    else:
        one_cnt = 1 + (n - 2) // 3 * 2 + (n - 2) % 3
        zero_cnt = n - one_cnt
        expected = (one_cnt * (one_cnt - 1) * (one_cnt - 2)) // 6 + \
                   (zero_cnt * (zero_cnt - 1) * (zero_cnt - 2)) // 6
    return count == expected

def _impl(n):
    if n <= 2: return False
    one_cnt = 1 + (n - 2) // 3 * 2 + (n - 2) % 3
    zero_cnt = n - one_cnt
    return one_cnt * (one_cnt - 1) * (one_cnt - 2) // 6 + zero_cnt * (zero_cnt - 1) * (zero_cnt - 2) // 6

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(get_max_triples_spec(*input, output))

def get_max_triples(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
