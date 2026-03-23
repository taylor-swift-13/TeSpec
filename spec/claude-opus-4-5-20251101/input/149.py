def has_even_length(s: str) -> bool:
    return len(s) % 2 == 0

def cmp_strings(s: str, t: str) -> str:
    if len(s) < len(t):
        return "Lt"
    elif len(s) > len(t):
        return "Gt"
    else:
        if s < t:
            return "Lt"
        elif s > t:
            return "Gt"
        else:
            return "Eq"

def is_sorted_by(cmp, l: list) -> bool:
    for i in range(len(l) - 1):
        if cmp(l[i], l[i+1]) not in ("Lt", "Eq"):
            return False
    return True

def _orig_sorted_list_sum_spec(lst: list, output: list) -> bool:
    expected = sorted([s for s in lst if has_even_length(s)], key=lambda s: (len(s), s))
    return output == expected

def sorted_list_sum_spec(lst, output):
    return bool(_orig_sorted_list_sum_spec(lst, output))
