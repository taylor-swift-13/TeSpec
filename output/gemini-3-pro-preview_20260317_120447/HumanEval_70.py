
def precondition(args):
    lst = args[0]
    return isinstance(lst, list) and all(isinstance(x, int) for x in lst)

def postcondition(args, output):
    lst = args[0]
    if not isinstance(output, list) or len(output) != len(lst):
        return False
    
    s = sorted(lst)
    expected = []
    low = 0
    high = len(s) - 1
    while low <= high:
        expected.append(s[low])
        if low != high:
            expected.append(s[high])
        low += 1
        high -= 1
        
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
