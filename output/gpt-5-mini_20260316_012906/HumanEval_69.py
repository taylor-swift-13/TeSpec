
from collections import Counter
from typing import Any

def precondition(inp: tuple) -> bool:
    # Expect exactly one positional argument: the list
    if not isinstance(inp, tuple) or len(inp) != 1:
        return False
    lst = inp[0]
    # Accept list or tuple as the sequence container
    if not isinstance(lst, (list, tuple)):
        return False
    if len(lst) == 0:
        return False
    # All elements should be integers and positive
    for x in lst:
        if not isinstance(x, int):
            return False
        if x <= 0:
            return False
    return True

def postcondition(inp: tuple, output: Any) -> bool:
    # If precondition not met, we cannot validate reliably
    if not precondition(inp):
        return False
    lst = list(inp[0])
    # Output must be an int and either -1 or a positive integer
    if not isinstance(output, int):
        return False
    if not (output == -1 or output > 0):
        return False
    cnt = Counter(lst)
    # Build set of candidate values: value >0 and frequency >= value
    candidates = {v for v, c in cnt.items() if v > 0 and c >= v}
    if output == -1:
        # Then no candidate should exist
        return len(candidates) == 0
    else:
        # output must be one of the candidates
        if output not in candidates:
            return False
        # and must be the greatest such candidate
        if any(cand > output for cand in candidates):
            return False
        return True

def _impl(lst):
    """You are given a non-empty list of positive integers. Return the greatest integer that is greater than 
    zero, and has a frequency greater than or equal to the value of the integer itself. 
    The frequency of an integer is the number of times it appears in the list.
    If no such a value exist, return -1.
    Examples:
        search([4, 1, 2, 2, 3, 1]) == 2
        search([1, 2, 2, 3, 3, 3, 4, 4, 4]) == 3
        search([5, 5, 4, 4, 4]) == -1"""
    count = dict()
    for num in lst:
        if num not in count:
            count[num] = 0
        count[num] += 1
    ans = -1
    for num, cnt in count.items():
        if cnt >= num:
            ans = max(ans, num)
    return ans

def search(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
