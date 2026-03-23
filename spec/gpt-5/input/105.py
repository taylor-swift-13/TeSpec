def is_digit(x):
    return 1 <= x <= 9

def to_word(x):
    if x == 1:
        return "One"
    elif x == 2:
        return "Two"
    elif x == 3:
        return "Three"
    elif x == 4:
        return "Four"
    elif x == 5:
        return "Five"
    elif x == 6:
        return "Six"
    elif x == 7:
        return "Seven"
    elif x == 8:
        return "Eight"
    else:
        return "Nine"

def _orig_by_length_spec(arr, output):
    digits = [x for x in arr if is_digit(x)]
    digits_desc = sorted(digits, reverse=True)
    expected_ans = [to_word(x) for x in digits_desc]
    return output == expected_ans

def by_length_spec(arr, output):
    return bool(_orig_by_length_spec(arr, output))
