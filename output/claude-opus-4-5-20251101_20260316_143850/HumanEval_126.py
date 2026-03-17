
def precondition(args):
    lst = args[0]
    if not isinstance(lst, list):
        return False
    for item in lst:
        if not isinstance(item, int):
            return False
        if item < 0:
            return False
    return True

def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    lst = args[0]
    
    # Check for more than 1 duplicate of any number
    has_excessive_duplicates = False
    for item in lst:
        if lst.count(item) > 2:
            has_excessive_duplicates = True
            break
    
    # Check if sorted in ascending order
    is_ascending = True
    for i in range(len(lst) - 1):
        if lst[i] > lst[i + 1]:
            is_ascending = False
            break
    
    expected = is_ascending and not has_excessive_duplicates
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
