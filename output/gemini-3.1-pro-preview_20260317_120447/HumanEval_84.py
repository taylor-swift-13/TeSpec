
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    N = input[0]
    if not isinstance(N, int):
        return False
    if not (0 <= N <= 10000):
        return False
    return True

def postcondition(input, output) -> bool:
    if len(input) != 1:
        return False
    N = input[0]
    if not isinstance(output, str):
        return False
    expected = bin(sum(int(d) for d in str(N)))[2:]
    return output == expected

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
