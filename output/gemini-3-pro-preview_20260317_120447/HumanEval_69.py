
def precondition(input_args: tuple) -> bool:
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    lst = input_args[0]
    if not isinstance(lst, list) or len(lst) == 0:
        return False
    return all(isinstance(x, int) and x > 0 for x in lst)

def postcondition(input_args: tuple, output: int) -> bool:
    lst = input_args[0]
    if not isinstance(output, int):
        return False
    
    counts = {}
    for x in lst:
        counts[x] = counts.get(x, 0) + 1
    
    candidates = [x for x, count in counts.items() if count >= x]
    
    if not candidates:
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
