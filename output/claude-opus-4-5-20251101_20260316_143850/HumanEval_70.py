
def precondition(args):
    lst = args[0]
    if not isinstance(lst, list):
        return False
    for item in lst:
        if not isinstance(item, int):
            return False
        if isinstance(item, bool):
            return False
    return True

def postcondition(args, output):
    lst = args[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(lst):
        return False
    if sorted(output) != sorted(lst):
        return False
    if len(output) == 0:
        return True
    sorted_lst = sorted(lst)
    expected = []
    take_min = True
    remaining = sorted_lst[:]
    while remaining:
        if take_min:
            expected.append(remaining.pop(0))
        else:
            expected.append(remaining.pop())
        take_min = not take_min
    if output != expected:
        return False
    return True

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
