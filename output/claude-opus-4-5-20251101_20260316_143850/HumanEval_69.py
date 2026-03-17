
def precondition(args):
    lst = args[0]
    # lst must be a list
    if not isinstance(lst, list):
        return False
    # lst must be non-empty
    if len(lst) == 0:
        return False
    # all elements must be positive integers
    for x in lst:
        if not isinstance(x, int):
            return False
        if isinstance(x, bool):
            return False
        if x <= 0:
            return False
    return True


def postcondition(args, output):
    lst = args[0]
    # output must be an integer
    if not isinstance(output, int):
        return False
    if isinstance(output, bool):
        return False
    # output must be -1 or a positive integer
    if output != -1 and output <= 0:
        return False
    
    # count frequencies
    freq = {}
    for x in lst:
        freq[x] = freq.get(x, 0) + 1
    
    # find all valid candidates (value > 0 and frequency >= value)
    valid_candidates = []
    for val, count in freq.items():
        if val > 0 and count >= val:
            valid_candidates.append(val)
    
    if output == -1:
        # no valid candidate should exist
        return len(valid_candidates) == 0
    else:
        # output must be a valid candidate
        if output not in valid_candidates:
            return False
        # output must be the greatest valid candidate
        return output == max(valid_candidates)

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
