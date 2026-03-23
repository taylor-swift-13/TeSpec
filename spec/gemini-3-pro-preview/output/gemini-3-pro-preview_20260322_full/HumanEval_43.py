def pairs_sum_to_zero_spec(l, res):
    has_pair = False
    seen = set()
    for x in l:
        if -x in seen:
            has_pair = True
            break
        seen.add(x)
    return res == has_pair

def _impl(l):
    for i in range(len(l)):
        for j in range(len(l)):
            if i != j and l[i] + l[j] == 0:
                return True
    return False

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(pairs_sum_to_zero_spec(*input, output))

def pairs_sum_to_zero(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
