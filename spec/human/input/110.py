def problem_110_pre(lst1, lst2):
    return len(lst1) > 0 and len(lst2) > 0

def problem_110_spec(lst1, lst2, result):
    odds_in_lst1 = len([x for x in lst1 if x % 2 != 0])
    evens_in_lst2 = len([x for x in lst2 if x % 2 == 0])
    
    if odds_in_lst1 <= evens_in_lst2:
        return result == "YES"
    else:
        return result == "NO"
