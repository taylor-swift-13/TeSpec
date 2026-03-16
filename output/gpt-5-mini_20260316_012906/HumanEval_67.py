
import re

def precondition(input):
    try:
        s, n = input
    except Exception:
        return False
    if not isinstance(s, str):
        return False
    if not isinstance(n, int):
        return False
    # Accept forms like "5 apples and 6 oranges" with optional singular/plural and flexible spacing, case-insensitive
    if re.fullmatch(r'\s*(\d+)\s+apples?\s+and\s+(\d+)\s+oranges?\s*', s, re.IGNORECASE) is None:
        return False
    return True

def postcondition(input, output):
    try:
        s, n = input
    except Exception:
        return False
    if not isinstance(s, str):
        return False
    if not isinstance(n, int):
        return False
    m = re.fullmatch(r'\s*(\d+)\s+apples?\s+and\s+(\d+)\s+oranges?\s*', s, re.IGNORECASE)
    if m is None:
        return False
    apples = int(m.group(1))
    oranges = int(m.group(2))
    if not isinstance(output, int):
        return False
    return output == n - apples - oranges

def _impl(s,n):
    """In this task, you will be given a string that represents a number of apples and oranges 
    that are distributed in a basket of fruit this basket contains 
    apples, oranges, and mango fruits. Given the string that represents the total number of 
    the oranges and apples and an integer that represent the total number of the fruits 
    in the basket return the number of the mango fruits in the basket.
    for examble:
    fruit_distribution("5 apples and 6 oranges", 19) ->19 - 5 - 6 = 8
    fruit_distribution("0 apples and 1 oranges",3) -> 3 - 0 - 1 = 2
    fruit_distribution("2 apples and 3 oranges", 100) -> 100 - 2 - 3 = 95
    fruit_distribution("100 apples and 1 oranges",120) -> 120 - 100 - 1 = 19"""
    words = s.split(" ")
    c1, c2 = int(words[0]), int(words[3])
    assert n - c1 - c2 >= 0, "invalid inputs" # $_CONTRACT_$

    return n - c1 - c2

def fruit_distribution(s,n):
    _input = (s, n)
    assert precondition(_input)
    _output = _impl(s, n)
    assert postcondition(_input, _output)
    return _output
