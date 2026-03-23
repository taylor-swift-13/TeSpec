def is_target_digit(z: int) -> bool:
    return 1 <= z <= 9

def digit_to_word(z: int) -> str:
    if z == 1:
        return "One"
    elif z == 2:
        return "Two"
    elif z == 3:
        return "Three"
    elif z == 4:
        return "Four"
    elif z == 5:
        return "Five"
    elif z == 6:
        return "Six"
    elif z == 7:
        return "Seven"
    elif z == 8:
        return "Eight"
    elif z == 9:
        return "Nine"
    else:
        return ""

def _orig_problem_105_pre(l_in: list) -> bool:
    return True

def _orig_problem_105_spec(l_in: list, l_out: list) -> bool:
    l_filtered = [z for z in l_in if is_target_digit(z)]
    l_sorted = sorted(l_filtered)
    l_reversed = l_sorted[::-1]
    expected_out = [digit_to_word(z) for z in l_reversed]
    return l_out == expected_out

def problem_105_pre(arr):
    return bool(_orig_problem_105_pre(arr))

def problem_105_spec(arr, output):
    return bool(_orig_problem_105_spec(arr, output))
