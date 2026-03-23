from typing import List

def is_subsequence(l1: List[float], l2: List[float]) -> bool:
    """
    Checks if l1 is a subsequence of l2.
    Iterates through l2 to find elements of l1 in order.
    """
    it = iter(l2)
    for x in l1:
        found = False
        for y in it:
            if x == y:
                found = True
                break
        if not found:
            return False
    return True

def is_positive(r: float) -> bool:
    return r > 0

def problem_30_pre(input: List[float]) -> bool:
    return True

def problem_30_spec(input: List[float], output: List[float]) -> bool:
    # 1. is_subsequence output input
    if not is_subsequence(output, input):
        return False

    # 2. (forall r, In r output <-> (In r input /\ is_positive r))
    
    # Forward: forall r, In r output -> (In r input /\ is_positive r)
    # Since is_subsequence(output, input) is True, In r output -> In r input is guaranteed.
    # We only need to check that every element in output is positive.
    for r in output:
        if not is_positive(r):
            return False

    # Backward: forall r, In r input /\ is_positive r -> In r output
    # Check that every positive element in input is present in output.
    for r in input:
        if is_positive(r):
            if r not in output:
                return False

    return True

def _impl(l: list):
    return list(filter(lambda x: x > 0, l))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_30_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_30_spec(*input, output))

def get_positive(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
