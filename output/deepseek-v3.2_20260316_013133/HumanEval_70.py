
def precondition(args):
    lst, = args
    return isinstance(lst, list) and all(isinstance(x, int) for x in lst)

def postcondition(args, result):
    lst, = args
    if not isinstance(result, list):
        return False
    if len(lst) != len(result):
        return False
    if not all(isinstance(x, int) for x in result):
        return False
    if sorted(lst) != sorted(result):
        return False
    if len(result) <= 1:
        return True
    for i in range(len(result) - 1):
        if i % 2 == 0:
            if i > 0 and result[i] <= result[i - 1]:
                return False
        else:
            if result[i] <= result[i + 1] if i + 1 < len(result) else False:
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
