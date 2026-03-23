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
