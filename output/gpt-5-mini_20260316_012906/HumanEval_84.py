
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    # require integer N in range [0, 10000], reject booleans
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    if n < 0 or n > 10000:
        return False
    return True

def postcondition(input, output):
    # If precondition not met, do not enforce postcondition here
    if not precondition(input):
        return True
    n = input[0]
    expected = bin(n).count("1")
    # output must be a non-empty string of '0' and '1' whose integer value equals expected
    if not isinstance(output, str):
        return False
    if len(output) == 0:
        return False
    for ch in output:
        if ch not in ("0", "1"):
            return False
    try:
        val = int(output, 2)
    except Exception:
        return False
    return val == expected

def _impl(N):
    """Given a positive integer N, return the total sum of its digits in binary.

    Example
        For N = 1000, the sum of digits will be 1 the output should be "1".
        For N = 150, the sum of digits will be 6 the output should be "110".
        For N = 147, the sum of digits will be 12 the output should be "1100".

    Variables:
        @N integer
             Constraints: 0 ≤ N ≤ 10000.
    Output:
         a string of binary number"""
    s = sum(map(lambda x: int(x), str(N)))
    return bin(s)[2:]

def solve(N):
    _input = (N,)
    assert precondition(_input)
    _output = _impl(N)
    assert postcondition(_input, _output)
    return _output
