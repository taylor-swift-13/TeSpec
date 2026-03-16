
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    n, m = input
    if not isinstance(n, int) or not isinstance(m, int):
        return False
    if n <= 0 or m <= 0:
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    n, m = input
    if not isinstance(n, int) or not isinstance(m, int):
        return False

    if n > m:
        return output == -1

    if not isinstance(output, str):
        return False
    if not output.startswith("0b"):
        return False
    bits = output[2:]
    if bits == "":
        return False
    if any(ch not in "01" for ch in bits):
        return False

    s = n + m
    a = s // 2
    if s % 2 == 0:
        rounded = a
    else:
        rounded = a if (a % 2 == 0) else a + 1

    expected = bin(rounded)
    return output == expected

def _impl(n, m):
    """You are given two positive integers n and m, and your task is to compute the
    average of the integers from n through m (including n and m). 
    Round the answer to the nearest integer and convert that to binary.
    If n is greater than m, return -1.
    Example:
    rounded_avg(1, 5) => "0b11"
    rounded_avg(7, 5) => -1
    rounded_avg(10, 20) => "0b1111"
    rounded_avg(20, 33) => "0b11010""""
    if n > m: return -1
    avg = round((n + m) / 2)
    return bin(avg)

def rounded_avg(n, m):
    _input = (n, m)
    assert precondition(_input)
    _output = _impl(n, m)
    assert postcondition(_input, _output)
    return _output
