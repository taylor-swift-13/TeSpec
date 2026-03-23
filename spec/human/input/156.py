def roman_digit_spec(one, ten, five, digit, output):
    if digit == 0:
        return output == []
    elif digit == 1:
        return output == [one]
    elif digit == 2:
        return output == [one, one]
    elif digit == 3:
        return output == [one, one, one]
    elif digit == 4:
        return output == [one, five]
    elif digit == 5:
        return output == [five]
    elif digit == 6:
        return output == [five, one]
    elif digit == 7:
        return output == [five, one, one]
    elif digit == 8:
        return output == [five, one, one, one]
    elif digit == 9:
        return output == [one, ten]
    return False

def _orig_problem_156_pre(number):
    return 1 <= number <= 1000

def _orig_problem_156_spec(number, output):
    if not 1 <= number <= 1000:
        return False
    m = number // 1000
    c = number // 100 % 10
    x = number // 10 % 10
    i = number % 10
    if m == 1:
        rm = ['m']
    elif m == 0:
        rm = []
    else:
        return False

    def get_roman_digit(one, ten, five, digit):
        if digit == 0:
            return []
        if digit == 1:
            return [one]
        if digit == 2:
            return [one, one]
        if digit == 3:
            return [one, one, one]
        if digit == 4:
            return [one, five]
        if digit == 5:
            return [five]
        if digit == 6:
            return [five, one]
        if digit == 7:
            return [five, one, one]
        if digit == 8:
            return [five, one, one, one]
        if digit == 9:
            return [one, ten]
        return None
    rc = get_roman_digit('c', 'm', 'd', c)
    rx = get_roman_digit('x', 'c', 'l', x)
    ri = get_roman_digit('i', 'x', 'v', i)
    if rc is None or rx is None or ri is None:
        return False
    expected_list = rm + rc + rx + ri
    expected_str = ''.join(expected_list)
    return output == expected_str

def problem_156_pre(number):
    return bool(_orig_problem_156_pre(number))

def problem_156_spec(number, output):
    return bool(_orig_problem_156_spec(number, output))
