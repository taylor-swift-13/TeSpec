def string_length(s: str) -> int:
    return len(s)

def total_chars(lst: list) -> int:
    return sum(string_length(s) for s in lst)

def total_match_spec(lst1: list, lst2: list, result: list) -> bool:
    c1 = total_chars(lst1)
    c2 = total_chars(lst2)
    if c1 <= c2:
        return result == lst1
    else:
        return result == lst2
