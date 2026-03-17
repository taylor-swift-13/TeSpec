
def precondition(input_args):
    if len(input_args) != 1:
        return False
    lst = input_args[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if not isinstance(x, int) or x < 0:
            return False
    return True

def postcondition(input_args, output):
    lst = input_args[0]
    if not isinstance(output, bool):
        return False
    
    is_asc = True
    for i in range(len(lst) - 1):
        if lst[i] > lst[i+1]:
            is_asc = False
            break
            
    counts_ok = True
    counts = {}
    for x in lst:
        counts[x] = counts.get(x, 0) + 1
        if counts[x] > 2:
            counts_ok = False
            break
            
    expected = is_asc and counts_ok
    return output == expected

def _impl(lst):
    """Given a list of numbers, return whether or not they are sorted
    in ascending order. If list has more than 1 duplicate of the same
    number, return False. Assume no negative numbers and only integers.

    Examples
    is_sorted([5]) ➞ True
    is_sorted([1, 2, 3, 4, 5]) ➞ True
    is_sorted([1, 3, 2, 4, 5]) ➞ False
    is_sorted([1, 2, 3, 4, 5, 6]) ➞ True
    is_sorted([1, 2, 3, 4, 5, 6, 7]) ➞ True
    is_sorted([1, 3, 2, 4, 5, 6, 7]) ➞ False
    is_sorted([1, 2, 2, 3, 3, 4]) ➞ True
    is_sorted([1, 2, 2, 2, 3, 4]) ➞ False"""
    count = dict()
    for x in lst:
        if x not in count: count[x] = 0
        count[x] += 1
        if count[x] > 2: return False
    return lst == sorted(lst)

def is_sorted(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
