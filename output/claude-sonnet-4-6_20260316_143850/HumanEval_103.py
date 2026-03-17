
def precondition(input) -> bool:
    if len(input) != 2:
        return False
    n, m = input
    if not isinstance(n, int) or not isinstance(m, int):
        return False
    if n <= 0 or m <= 0:
        return False
    return True


def postcondition(input, output) -> bool:
    n, m = input
    if n > m:
        return output == -1
    if not isinstance(output, str):
        return False
    if not output.startswith("0b"):
        return False
    try:
        val = int(output, 2)
    except ValueError:
        return False
    avg = (n + m) / 2
    rounded = round(avg)
    return val == rounded

def _impl(n, m):
    """You are given two positive integers n and m, and your task is to compute the
    average of the integers from n through m (including n and m). 
    Round the answer to the nearest integer and convert that to binary.
    If n is greater than m, return -1.
    Example:
    rounded_avg(1, 5) => "0b11"
    rounded_avg(7, 5) => -1
    rounded_avg(10, 20) => "0b1111"
    rounded_avg(20, 33) => "0b11010"
    """
    if n > m: return -1
    avg = round((n + m) / 2)
    return bin(avg)

def rounded_avg(n, m):
    _input = (n, m)
    assert precondition(_input)
    _output = _impl(n, m)
    assert postcondition(_input, _output)
    return _output
