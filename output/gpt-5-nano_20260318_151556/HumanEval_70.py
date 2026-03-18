
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list) or any((not isinstance(x, int) or isinstance(x, bool)) for x in lst):
        return False
    if not isinstance(output, list):
        return False
    if sorted(output) != sorted(lst):
        return False
    remaining = lst.copy()
    remaining.sort()
    expected = []
    while remaining:
        expected.append(remaining.pop(0))
        if remaining:
            expected.append(remaining.pop(-1))
    return output == expected

def _impl(lst):
    """
    Given list of integers, return list in strange order.
    Strange sorting, is when you start with the minimum value,
    then maximum of the remaining integers, then minimum and so on.

    Examples:
    strange_sort_list([1, 2, 3, 4]) == [1, 4, 2, 3]
    strange_sort_list([5, 5, 5, 5]) == [5, 5, 5, 5]
    strange_sort_list([]) == []
    """
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
