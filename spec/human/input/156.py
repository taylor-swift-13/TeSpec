def roman_digit_spec(one, ten, five, digit, res):
    if digit == 0:
        return res == []
    elif digit == 1:
        return res == [one]
    elif digit == 2:
        return res == [one, one]
    elif digit == 3:
        return res == [one, one, one]
    elif digit == 4:
        return res == [one, five]
    elif digit == 5:
        return res == [five]
    elif digit == 6:
        return res == [five, one]
    elif digit == 7:
        return res == [five, one, one]
    elif digit == 8:
        return res == [five, one, one, one]
    elif digit == 9:
        return res == [one, ten]
    return False

def problem_156_pre(number):
    return 1 <= number <= 1000

def problem_156_spec(number, result):
    if not (1 <= number <= 1000):
        return False
    
    m = number // 1000
    c = (number // 100) % 10
    x = (number // 10) % 10
    i = number % 10
    
    if m == 1:
        rm = ['m']
    elif m == 0:
        rm = []
    else:
        return False
        
    def get_roman_digit(one, ten, five, digit):
        if digit == 0: return []
        if digit == 1: return [one]
        if digit == 2: return [one, one]
        if digit == 3: return [one, one, one]
        if digit == 4: return [one, five]
        if digit == 5: return [five]
        if digit == 6: return [five, one]
        if digit == 7: return [five, one, one]
        if digit == 8: return [five, one, one, one]
        if digit == 9: return [one, ten]
        return None

    rc = get_roman_digit('c', 'm', 'd', c)
    rx = get_roman_digit('x', 'c', 'l', x)
    ri = get_roman_digit('i', 'x', 'v', i)
    
    if rc is None or rx is None or ri is None:
        return False
        
    expected_list = rm + rc + rx + ri
    expected_str = "".join(expected_list)
    
    return result == expected_str
