def count_occurrences(x, lst):
    return lst.count(x)

def no_more_than_two_duplicates(lst):
    for x in lst:
        if count_occurrences(x, lst) > 2:
            return False
    return True

def is_ascending(lst):
    for i in range(len(lst) - 1):
        if lst[i] > lst[i + 1]:
            return False
    return True

def is_sorted_spec(lst, result):
    expected = is_ascending(lst) and no_more_than_two_duplicates(lst)
    return bool(result) == expected
