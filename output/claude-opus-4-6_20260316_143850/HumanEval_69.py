
def precondition(input):
    (lst,) = input
    if not isinstance(lst, list):
        return False
    if len(lst) == 0:
        return False
    for x in lst:
        if not isinstance(x, int):
            return False
        if x <= 0:
            return False
    return True


def postcondition(input, output):
    (lst,) = input
    if not isinstance(output, int):
        return False
    
    from collections import Counter
    freq = Counter(lst)
    
    # Collect all valid candidates: integers where freq[x] >= x and x > 0
    candidates = [x for x in freq if x > 0 and freq[x] >= x]
    
    if len(candidates) == 0:
        return output == -1
    else:
        return output == max(candidates)

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
