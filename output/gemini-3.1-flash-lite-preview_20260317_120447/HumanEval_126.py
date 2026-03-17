
def precondition(input):
    lst = input[0]
    return isinstance(lst, list) and all(isinstance(x, int) and x >= 0 for x in lst)

def postcondition(input, output):
    lst = input[0]
    if not isinstance(output, bool):
        return False
    
    has_duplicates = len(set(lst)) != len(lst)
    is_sorted = all(lst[i] <= lst[i+1] for i in range(len(lst) - 1))
    
    # Check for duplicates count constraint
    from collections import Counter
    counts = Counter(lst)
    too_many_duplicates = any(count > 2 for count in counts.values())
    
    expected = is_sorted and not too_many_duplicates
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
