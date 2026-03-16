
def precondition(input):
    N = input[0]
    return isinstance(N, int) and 0 <= N <= 10000

def postcondition(input, output):
    N = input[0]
    if not isinstance(output, str):
        return False
    if not all(c in '01' for c in output):
        return False
    if output == '0' and N == 0:
        return True
    if output.startswith('0'):
        return False
    try:
        decimal_sum = sum(int(digit) for digit in str(N))
        binary_sum = int(output, 2)
        return binary_sum == decimal_sum
    except:
        return False

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
