def index_strange(n, k):
    if k % 2 == 0:
        return k // 2
    else:
        return n - 1 - (k // 2)

def ans_of_sorted(s, output):
    if len(output) != len(s):
        return False
    n = len(s)
    for k in range(n):
        idx = index_strange(n, k)
        if output[k] != s[idx]:
            return False
    return True

def _orig_strange_sort_list_spec(lst, output):
    s = sorted(lst)
    return ans_of_sorted(s, output)

def strange_sort_list_spec(lst, output):
    return bool(_orig_strange_sort_list_spec(lst, output))
