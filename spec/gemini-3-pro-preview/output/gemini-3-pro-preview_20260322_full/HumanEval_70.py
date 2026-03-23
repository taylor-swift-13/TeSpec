def strange_interleave(lst1, lst2):
    expected_lst2 = []
    left = 0
    right = len(lst1) - 1
    while left <= right:
        if left == right:
            expected_lst2.append(lst1[left])
            break
        expected_lst2.append(lst1[left])
        expected_lst2.append(lst1[right])
        left += 1
        right -= 1
    return expected_lst2 == lst2

def strange_sort_list_spec(lst, ans):
    sorted_lst = sorted(lst)
    return strange_interleave(sorted_lst, ans)

def _impl(lst):
    sorted_list = sorted(lst)
    ans, i, j = [], 0, len(sorted_list) - 1
    while i < j:
        ans.append(sorted_list[i])
        ans.append(sorted_list[j])
        i += 1
        j -= 1
    if i == j: ans.append(sorted_list[i])
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(strange_sort_list_spec(*input, output))

def strange_sort_list(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
