def roman_m(d: int) -> str:
    if d == 0:
        return ""
    elif d == 1:
        return "m"
    else:
        return ""

def roman_c(d: int) -> str:
    if d == 0:
        return ""
    elif d == 1:
        return "c"
    elif d == 2:
        return "cc"
    elif d == 3:
        return "ccc"
    elif d == 4:
        return "cd"
    elif d == 5:
        return "d"
    elif d == 6:
        return "dc"
    elif d == 7:
        return "dcc"
    elif d == 8:
        return "dccc"
    elif d == 9:
        return "cm"
    else:
        return ""

def roman_x(d: int) -> str:
    if d == 0:
        return ""
    elif d == 1:
        return "x"
    elif d == 2:
        return "xx"
    elif d == 3:
        return "xxx"
    elif d == 4:
        return "xl"
    elif d == 5:
        return "l"
    elif d == 6:
        return "lx"
    elif d == 7:
        return "lxx"
    elif d == 8:
        return "lxxx"
    elif d == 9:
        return "xc"
    else:
        return ""

def roman_i(d: int) -> str:
    if d == 0:
        return ""
    elif d == 1:
        return "i"
    elif d == 2:
        return "ii"
    elif d == 3:
        return "iii"
    elif d == 4:
        return "iv"
    elif d == 5:
        return "v"
    elif d == 6:
        return "vi"
    elif d == 7:
        return "vii"
    elif d == 8:
        return "viii"
    elif d == 9:
        return "ix"
    else:
        return ""

def _orig_int_to_mini_roman_spec(number: int, output: str) -> bool:
    if not 1 <= number <= 1000:
        return False
    expected = roman_m(number // 1000) + roman_c(number % 1000 // 100) + roman_x(number % 100 // 10) + roman_i(number % 10)
    return output == expected

def int_to_mini_roman_spec(number, output):
    return bool(_orig_int_to_mini_roman_spec(number, output))
