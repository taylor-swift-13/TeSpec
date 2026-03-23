def index_strange(n, k):
    if k % 2 == 0:
        return k // 2
    else:
        return n - 1 - (k // 2)

def ans_of_sorted(s, ans):
    if len(ans) != len(s):
        return False
    n = len(s)
    for k in range(n):
        idx = index_strange(n, k)
        if ans[k] != s[idx]:
            return False
    return True

def strange_sort_list_spec(lst, ans):
    s = sorted(lst)
    return ans_of_sorted(s, ans)

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
