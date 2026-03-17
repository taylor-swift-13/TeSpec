
def precondition(inp: tuple) -> bool:
    if len(inp) != 1:
        return False
    lst = inp[0]
    if not isinstance(lst, list):
        return False
    return all(type(x) is int and x >= 0 for x in lst)

def postcondition(inp: tuple, out: bool) -> bool:
    if not isinstance(out, bool):
        return False
    lst = inp[0]
    is_asc = all(lst[i] <= lst[i+1] for i in range(len(lst) - 1))
    if not is_asc:
        expected = False
    else:
        expected = all(lst[i] != lst[i+2] for i in range(len(lst) - 2))
    return out == expected

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
