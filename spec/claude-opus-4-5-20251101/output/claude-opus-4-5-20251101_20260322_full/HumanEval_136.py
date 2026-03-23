def is_negative(x):
    return x < 0

def is_positive(x):
    return x > 0

def largest_negative(lst):
    negatives = [x for x in lst if is_negative(x)]
    if not negatives:
        return None
    return max(negatives)

def smallest_positive(lst):
    positives = [x for x in lst if is_positive(x)]
    if not positives:
        return None
    return min(positives)

def largest_smallest_integers_spec(lst, result):
    expected_fst = largest_negative(lst)
    expected_snd = smallest_positive(lst)
    
    fst_result, snd_result = result
    
    if fst_result != expected_fst:
        return False
    if snd_result != expected_snd:
        return False
        
    return True

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
