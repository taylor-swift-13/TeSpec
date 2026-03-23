from typing import List, Any

def strict_eq(a: Any, b: Any) -> bool:
    if type(a) is not type(b):
        return False
    if isinstance(a, list):
        if len(a) != len(b):
            return False
        return all(strict_eq(x, y) for x, y in zip(a, b))
    if isinstance(a, dict):
        if len(a) != len(b):
            return False
        for k in a:
            if k not in b:
                return False
            if not strict_eq(a[k], b[k]):
                return False
        return True
    return a == b

def is_int(v: Any) -> bool:
    return type(v) is int

def is_subsequence(l1: List[Any], l2: List[Any]) -> bool:
    i, j = 0, 0
    while i < len(l1) and j < len(l2):
        if strict_eq(l1[i], l2[j]):
            i += 1
        j += 1
    return i == len(l1)

def strict_in(v: Any, lst: List[Any]) -> bool:
    return any(strict_eq(v, x) for x in lst)

def problem_22_pre(input_list: List[Any]) -> bool:
    return True

def problem_22_spec(input_list: List[Any], output_list: List[Any]) -> bool:
    if not is_subsequence(output_list, input_list):
        return False

    for v in output_list:
        if not (strict_in(v, input_list) and is_int(v)):
            return False

    for v in input_list:
        if is_int(v) and not strict_in(v, output_list):
            return False

    return True

def filter_integers(values: List[Any]) -> List[int]:
    return [v for v in values if is_int(v)]
