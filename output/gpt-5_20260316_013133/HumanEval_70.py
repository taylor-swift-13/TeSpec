
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    lst = input[0]
    if not isinstance(output, list):
        return False
    if len(lst) != len(output):
        return False
    for x in output:
        if not isinstance(x, int):
            return False
    def counts(seq):
        d = {}
        for v in seq:
            d[v] = d.get(v, 0) + 1
        return d
    if counts(lst) != counts(output):
        return False
    s = sorted(output)
    i, j = 0, len(s) - 1
    expected = []
    pick_min = True
    while i <= j:
        if pick_min:
            expected.append(s[i])
            i += 1
        else:
            expected.append(s[j])
            j -= 1
        pick_min = not pick_min
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
