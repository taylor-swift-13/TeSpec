def is_odd_digit(c):
    return c in "13579"

def count_odd_digits(s):
    count = 0
    for c in s:
        if is_odd_digit(c):
            count += 1
    return count

def string_of_nat(n):
    return str(n)

template = "the number of odd elements in the string i of the input."

def replace_i(s, replacement):
    res = ""
    for char in s:
        if char == 'i':
            res += replacement
        else:
            res += char
    return res

def _orig_odd_count_spec(lst, output):
    expected = [replace_i(template, string_of_nat(count_odd_digits(s))) for s in lst]
    return output == expected

def odd_count_spec(lst, output):
    return bool(_orig_odd_count_spec(lst, output))
