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
