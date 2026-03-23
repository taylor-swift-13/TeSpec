def has_even_length(s: str) -> bool:
    return len(s) % 2 == 0

def cmp_strings(s: str, t: str) -> str:
    len_s = len(s)
    len_t = len(t)
    if len_s < len_t:
        return "Lt"
    elif len_s > len_t:
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

def is_permutation_of_filtered(original: list, filtered: list) -> bool:
    elements = set(original) | set(filtered)
    for s in elements:
        in_filtered = s in filtered
        in_original_and_even = (s in original) and has_even_length(s)
        if in_filtered != in_original_and_even:
            return False
    return True

def sorted_list_sum_spec(lst: list, result: list) -> bool:
    elements = set(lst) | set(result)
    for s in elements:
        in_result = s in result
        in_lst_and_even = (s in lst) and has_even_length(s)
        if in_result != in_lst_and_even:
            return False
    return is_sorted_by(cmp_strings, result)

def _impl(lst):
    from functools import cmp_to_key
    def cmp(s: str, t: str):
        if len(s) != len(t):
            return len(s) - len(t)
        return -1 if s < t else 1
    return sorted(list(filter(lambda s: len(s) % 2 == 0, lst)), key=cmp_to_key(cmp))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sorted_list_sum_spec(*input, output))

def sorted_list_sum(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
