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

def is_permutation_of_filtered(original: list, filtered: list) -> bool:
    expected_set = {s for s in original if has_even_length(s)}
    filtered_set = set(filtered)
    return expected_set == filtered_set

def sorted_list_sum_spec(lst: list, result: list) -> bool:
    expected_set = {s for s in lst if has_even_length(s)}
    result_set = set(result)
    return expected_set == result_set and is_sorted_by(cmp_strings, result)

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
