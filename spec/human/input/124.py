def nat_of_digit(c):
    if len(c) == 1 and '0' <= c <= '9':
        return int(c)
    return None

def nat_of_2_digits(c1, c2):
    d1 = nat_of_digit(c1)
    d2 = nat_of_digit(c2)
    if d1 is not None and d2 is not None:
        return 10 * d1 + d2
    return None

def nat_of_4_digits(c1, c2, c3, c4):
    d1 = nat_of_digit(c1)
    d2 = nat_of_digit(c2)
    d3 = nat_of_digit(c3)
    d4 = nat_of_digit(c4)
    if d1 is not None and d2 is not None and d3 is not None and d4 is not None:
        return 1000 * d1 + 100 * d2 + 10 * d3 + d4
    return None

def days_in_month(m):
    if m in [1, 3, 5, 7, 8, 10, 12]:
        return 31
    elif m in [4, 6, 9, 11]:
        return 30
    elif m == 2:
        return 29
    else:
        return 0

def _orig_problem_124_pre(s):
    return True

def _orig_problem_124_spec(s):
    if len(s) != 10:
        return False
    (m1, m2, sep1, d1, d2, sep2, y1, y2, y3, y4) = s
    if sep1 != '-' or sep2 != '-':
        return False
    m = nat_of_2_digits(m1, m2)
    d = nat_of_2_digits(d1, d2)
    y = nat_of_4_digits(y1, y2, y3, y4)
    if m is None or d is None or y is None:
        return False
    if not 1 <= m <= 12:
        return False
    if not 1 <= d <= days_in_month(m):
        return False
    return True

def problem_124_pre(date):
    return bool(_orig_problem_124_pre(date))

def problem_124_spec(date, output):
    return _orig_problem_124_spec(date) == output
