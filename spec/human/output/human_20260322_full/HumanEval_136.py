def is_largest_negative(lst, a):
    """
    Checks if 'a' is the largest negative integer in 'lst' (Some z)
    or if no negative integers exist in 'lst' (None).
    """
    if a is not None:
        # a is Some z: z < 0 /\ In z lst /\ (forall x, In x lst -> x < 0 -> x <= z)
        return (a < 0 and a in lst and 
                all(x <= a for x in lst if x < 0))
    else:
        # a is None: forall x, In x lst -> ~(x < 0)
        return all(not (x < 0) for x in lst)

def is_smallest_positive(lst, b):
    """
    Checks if 'b' is the smallest positive integer in 'lst' (Some z)
    or if no positive integers exist in 'lst' (None).
    """
    if b is not None:
        # b is Some z: z > 0 /\ In z lst /\ (forall x, In x lst -> x > 0 -> z <= x)
        return (b > 0 and b in lst and 
                all(b <= x for x in lst if x > 0))
    else:
        # b is None: forall x, In x lst -> ~(x > 0)
        return all(not (x > 0) for x in lst)

def problem_136_pre(lst):
    """
    Precondition for problem 136: Any integer list is valid.
    """
    return True

def problem_136_spec(lst, res):
    """
    Spec for problem 136: res = (a, b) satisfies the largest negative
    and smallest positive integer conditions.
    """
    a, b = res
    return is_largest_negative(lst, a) and is_smallest_positive(lst, b)

def largest_smallest_integers(lst):
    """
    Implementation of the function described in the docstring.
    Returns a tuple (a, b), where 'a' is the largest of negative integers,
    and 'b' is the smallest of positive integers in a list.
    If there is no negative or positive integers, return them as None.
    """
    negatives = [x for x in lst if x < 0]
    positives = [x for x in lst if x > 0]
    
    a = max(negatives) if negatives else None
    b = min(positives) if positives else None
    
    return (a, b)

def _impl(lst):
    neg = list(filter(lambda x: x < 0, lst))
    pos = list(filter(lambda x: x > 0, lst))
    return None if neg == [] else max(neg), None if pos == [] else min(pos)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_136_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_136_spec(*input, output))

def largest_smallest_integers(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
