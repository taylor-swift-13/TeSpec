from typing import List, Union, Tuple, Optional

def _orig_problem_68_pre(arr: List[int]) -> bool:
    return True

def _orig_problem_68_spec(arr: List[int], output: List[int]) -> bool:
    if output == []:
        for val in arr:
            if val % 2 == 0:
                return False
        return True
    if len(output) != 2:
        return False
    (v, i) = output
    if not 0 <= i < len(arr):
        return False
    if arr[i] != v:
        return False
    if v % 2 != 0:
        return False
    for val in arr:
        if val % 2 == 0 and v > val:
            return False
    for j in range(i):
        if arr[j] == v:
            return False
    return True

def problem_68_pre(arr):
    return bool(_orig_problem_68_pre(arr))

def problem_68_spec(arr, output):
    return bool(_orig_problem_68_spec(arr, output))
