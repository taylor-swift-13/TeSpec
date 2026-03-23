def triples_sum_to_zero_spec(l, res):
    n = len(l)
    has_triple = False
    for i in range(n):
        seen = set()
        for j in range(i + 1, n):
            target = -(l[i] + l[j])
            if target in seen:
                has_triple = True
                break
            seen.add(l[j])
        if has_triple:
            break
    return has_triple == res

def _impl(l: list):
    for i in range(len(l)):
        for j in range(len(l)):
            for k in range(len(l)):
                if i != j and i != k and j != k and l[i] + l[j] + l[k] == 0:
                    return True
    return False

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(triples_sum_to_zero_spec(*input, output))

def triples_sum_to_zero(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
