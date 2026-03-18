
def precondition(input):
    # input is a tuple of positional arguments; expected one arg: lst
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    if len(lst) == 0:
        return False
    for v in lst:
        if not isinstance(v, int) or isinstance(v, bool) or v <= 0:
            return False
    return True

def postcondition(input, output):
    # Ensure input satisfies the contract
    if not precondition(input):
        return False
    # Output should be an integer
    if not isinstance(output, int):
        return False
    lst = input[0]
    from collections import Counter
    freq = Counter(lst)
    candidates = [x for x, cnt in freq.items() if x > 0 and cnt >= x]
    expected = max(candidates) if candidates else -1
    return output == expected

def _impl(lst):
    """
    You are given a non-empty list of positive integers. Return the greatest integer that is greater than 
    zero, and has a frequency greater than or equal to the value of the integer itself. 
    The frequency of an integer is the number of times it appears in the list.
    If no such a value exist, return -1.
    Examples:
        search([4, 1, 2, 2, 3, 1]) == 2
        search([1, 2, 2, 3, 3, 3, 4, 4, 4]) == 3
        search([5, 5, 4, 4, 4]) == -1
    """
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
