def below_threshold(l: list, t: int) -> bool:
    """Return True if all numbers in the list l are below threshold t.
    >>> below_threshold([1, 2, 4, 10], 100)
    True
    >>> below_threshold([1, 20, 4, 10], 5)
    False
    """
    return all(x < t for x in l)

def problem_52_pre(l: list) -> bool:
    """
    Precondition: no special constraints for `below_threshold`.
    """
    return True

def problem_52_spec(l: list, t: int, output: bool) -> bool:
    """
    Specification: (forall x, In x l -> x < t) <-> (output = true)
    """
    return all(x < t for x in l) == output

def _impl(l: list, t: int):
    return all(x < t for x in l)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_52_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_52_spec(*input, output))

def below_threshold(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
