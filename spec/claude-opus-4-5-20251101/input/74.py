def string_length(s: str) -> int:
    return len(s)

def total_chars(lst: list) -> int:
    return sum(string_length(s) for s in lst)

def _orig_total_match_spec(lst1: list, lst2: list, output: list) -> bool:
    c1 = total_chars(lst1)
    c2 = total_chars(lst2)
    if c1 <= c2:
        return output == lst1
    else:
        return output == lst2

def total_match_spec(lst1, lst2, output):
    return bool(_orig_total_match_spec(lst1, lst2, output))
