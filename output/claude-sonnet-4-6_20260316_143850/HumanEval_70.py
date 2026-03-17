
def precondition(args):
    if len(args) != 1:
        return False
    lst = args[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if not isinstance(x, (int, float)):
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
    remaining = sorted(lst)
    expected = []
    low = 0
    high = len(remaining) - 1
    take_min = True
    while low <= high:
        if take_min:
            expected.append(remaining[low])
            low += 1
        else:
            expected.append(remaining[high])
            high -= 1
        take_min = not take_min
    return output == expected

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
