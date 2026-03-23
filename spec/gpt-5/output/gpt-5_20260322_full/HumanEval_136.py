def largest_smallest_integers_spec(lst, a, b):
    negatives = [x for x in lst if x < 0]
    if not negatives:
        expected_a = None
    else:
        expected_a = max(negatives)
        
    positives = [x for x in lst if x > 0]
    if not positives:
        expected_b = None
    else:
        expected_b = min(positives)
        
    return a == expected_a and b == expected_b

def _impl(lst):
    neg = list(filter(lambda x: x < 0, lst))
    pos = list(filter(lambda x: x > 0, lst))
    return None if neg == [] else max(neg), None if pos == [] else min(pos)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(largest_smallest_integers_spec(*input, output))

def largest_smallest_integers(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
