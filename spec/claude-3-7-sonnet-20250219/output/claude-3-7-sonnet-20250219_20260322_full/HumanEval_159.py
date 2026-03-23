def eat_spec(number, need, remaining, result):
    """
    Python implementation of the Coq eat_spec.
    Returns True if the inputs satisfy the specification, False otherwise.
    """
    # Check the range constraints: 0 <= x <= 1000
    # In Coq, nat is non-negative by definition, but we check 0 <= x for completeness.
    range_check = (0 <= number <= 1000 and 
                   0 <= need <= 1000 and 
                   0 <= remaining <= 1000)
    
    if not range_check:
        return False

    # Nat.leb need remaining is equivalent to need <= remaining
    if need <= remaining:
        expected_result = [number + need, remaining - need]
    else:
        expected_result = [number + remaining, 0]

    # Check if the provided result matches the expected result
    return result == expected_result

def _impl(number, need, remaining):
    if need <= remaining:
        return [number + need, remaining - need]
    else:
        return [number + remaining, 0]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(eat_spec(*input, output))

def eat(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
