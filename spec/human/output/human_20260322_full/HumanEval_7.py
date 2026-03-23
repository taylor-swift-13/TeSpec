from typing import List

def contains_substring(s, sub):
    """
    Checks if 'sub' is a substring of 's'.
    Implements the logic of the Coq Fixpoint contains_substring.
    """
    return sub in s

def filter_by_substring_impl(input, sub):
    """
    Filters the input list, keeping only strings that contain 'sub'.
    Implements the logic of the Coq Fixpoint filter_by_substring_impl.
    """
    return [h for h in input if contains_substring(h, sub)]

def problem_7_pre():
    """
    Pre-condition for problem 7.
    Always returns True as per Coq definition.
    """
    return True

def problem_7_spec(input, output, sub):
    """
    Specification for problem 7.
    Checks if 'output' is the result of filtering 'input' by 'sub'.
    """
    return output == filter_by_substring_impl(input, sub)

def _impl(strings: List[str], substring: str) -> List[str]:
    return list(filter(lambda s: substring in s, strings))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_7_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_7_spec(*input, output))

def filter_by_substring(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
