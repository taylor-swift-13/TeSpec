
def precondition(input):
    (N,) = input
    # N must be an integer in [0, 10000]
    if not isinstance(N, int):
        return False
    if N < 0 or N > 10000:
        return False
    return True

def postcondition(input, output):
    (N,) = input
    # Output must be a string
    if not isinstance(output, str):
        return False
    # Output must be a valid binary string (only '0' and '1')
    if not all(c in '01' for c in output):
        return False
    # Output should not have leading zeros (unless it is "0")
    if len(output) > 1 and output[0] == '0':
        return False
    if len(output) == 0:
        return False
    # Compute the expected digit sum of N
    digit_sum = sum(int(d) for d in str(N))
    # The output should be the binary representation of that digit sum
    expected = bin(digit_sum)[2:]
    if output != expected:
        return False
    return True

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
