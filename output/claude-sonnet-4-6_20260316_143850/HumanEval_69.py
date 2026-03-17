
def precondition(args):
    if len(args) != 1:
        return False
    lst = args[0]
    if not isinstance(lst, list):
        return False
    if len(lst) == 0:
        return False
    for x in lst:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
        if x <= 0:
            return False
    return True

def postcondition(args, output):
    if not isinstance(output, int) or isinstance(output, bool):
        return False
    lst = args[0]
    from collections import Counter
    freq = Counter(lst)
    valid = [x for x in freq if x > 0 and freq[x] >= x]
    if output == -1:
        return len(valid) == 0
    else:
        if output not in valid:
            return False
        if output != max(valid):
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
