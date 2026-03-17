
def precondition(inp: tuple) -> bool:
    if len(inp) != 1:
        return False
    lst = inp[0]
    if not isinstance(lst, list) or not lst:
        return False
    return all(isinstance(x, int) and not isinstance(x, bool) and x > 0 for x in lst)

def postcondition(inp: tuple, out) -> bool:
    lst = inp[0]
    if not isinstance(out, int) or isinstance(out, bool):
        return False
    if out == -1:
        return all(lst.count(x) < x for x in set(lst))
    if out <= 0 or lst.count(out) < out:
        return False
    return all(lst.count(x) < x for x in set(lst) if x > out)

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
