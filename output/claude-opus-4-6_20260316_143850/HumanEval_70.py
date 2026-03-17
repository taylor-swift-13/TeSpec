
def precondition(input):
    (lst,) = input
    if not isinstance(lst, list):
        return False
    if not all(isinstance(x, int) for x in lst):
        return False
    return True


def postcondition(input, output):
    (lst,) = input
    if not isinstance(output, list):
        return False
    if len(output) != len(lst):
        return False
    if sorted(output) != sorted(lst):
        return False
    # Verify the strange sorting pattern:
    # Elements at even indices should be mins of remaining, odd indices should be maxes of remaining
    remaining = sorted(lst)
    for i, val in enumerate(output):
        if not remaining:
            return False
        if i % 2 == 0:
            # should pick minimum
            if val != remaining[0]:
                return False
            remaining.remove(val)
        else:
            # should pick maximum
            if val != remaining[-1]:
                return False
            remaining.remove(val)
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
