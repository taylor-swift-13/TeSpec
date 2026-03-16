
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True

def postcondition(input, output):
    # Postcondition only meaningful when precondition holds
    if not precondition(input):
        return True
    lst = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(lst):
        return False
    for y in output:
        if not isinstance(y, int) or isinstance(y, bool):
            return False
    # multiset equality
    try:
        from collections import Counter
    except Exception:
        return False
    if Counter(output) != Counter(lst):
        return False
    # construct expected strange order
    remaining = list(lst)
    expected = []
    while remaining:
        m = min(remaining)
        expected.append(m)
        remaining.remove(m)
        if remaining:
            M = max(remaining)
            expected.append(M)
            remaining.remove(M)
    return expected == output

def _impl(lst):
    """Given list of integers, return list in strange order.
    Strange sorting, is when you start with the minimum value,
    then maximum of the remaining integers, then minimum and so on.

    Examples:
    strange_sort_list([1, 2, 3, 4]) == [1, 4, 2, 3]
    strange_sort_list([5, 5, 5, 5]) == [5, 5, 5, 5]
    strange_sort_list([]) == []"""
    sorted_list = sorted(lst)
    ans, i, j = [], 0, len(sorted_list) - 1
    while i < j:
        ans.append(sorted_list[i])
        ans.append(sorted_list[j])
        i += 1
        j -= 1
    if i == j: ans.append(sorted_list[i])
    return ans

def strange_sort_list(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
