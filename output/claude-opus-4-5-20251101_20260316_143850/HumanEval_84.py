
def precondition(args):
    N = args[0]
    # Check that N is an integer
    if not isinstance(N, int):
        return False
    # Check that N is a boolean is not acceptable (bool is subclass of int)
    if isinstance(N, bool):
        return False
    # Check constraint: 0 <= N <= 10000
    if N < 0 or N > 10000:
        return False
    return True

def postcondition(args, output):
    N = args[0]
    # Output must be a string
    if not isinstance(output, str):
        return False
    # Output must be a valid binary string (only '0' and '1', or just "0")
    if len(output) == 0:
        return False
    if not all(c in '01' for c in output):
        return False
    # Binary string should not have leading zeros unless it's "0"
    if len(output) > 1 and output[0] == '0':
        return False
    # Calculate the expected sum of digits of N
    digit_sum = sum(int(d) for d in str(N))
    # Convert output from binary string to integer
    output_value = int(output, 2)
    # Check that output represents the digit sum in binary
    if output_value != digit_sum:
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
