
def precondition(input):
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if not isinstance(x, int):
            return False
        if x < 0:
            return False
    return True


def postcondition(input, output):
    lst = input[0]
    if not isinstance(output, bool):
        return False
    # Check: if any element appears more than twice, output must be False
    from collections import Counter
    counts = Counter(lst)
    has_more_than_2_duplicates = any(v > 2 for v in counts.values())
    if has_more_than_2_duplicates and output:
        return False
    # Check: if list is not sorted in ascending (non-decreasing) order, output must be False
    is_sorted = all(lst[i] <= lst[i+1] for i in range(len(lst) - 1))
    if not is_sorted and output:
        return False
    # Check: if list is sorted and no element appears more than twice, output must be True
    if is_sorted and not has_more_than_2_duplicates and not output:
        return False
    return True

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
