
def precondition(input):
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n <= 0:
        return False
    return True

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, list):
        return False
    # Check all elements are odd integers
    for x in output:
        if not isinstance(x, int):
            return False
        if x % 2 == 0:
            return False
    # Check sorted in increasing order
    for i in range(len(output) - 1):
        if output[i] >= output[i + 1]:
            return False
    # n itself should be in output if n is odd
    if n % 2 != 0:
        if n not in output:
            return False
    # 1 should always be in output
    if 1 not in output:
        return False
    # Generate collatz sequence and verify odd numbers match
    seq = []
    current = n
    while current != 1:
        seq.append(current)
        if current % 2 == 0:
            current = current // 2
        else:
            current = 3 * current + 1
    seq.append(1)
    odd_numbers = sorted(set(x for x in seq if x % 2 != 0))
    if output != odd_numbers:
        return False
    return True

def _impl(n):
    """Given a positive integer n, return a sorted list that has the odd numbers in collatz sequence.

    The Collatz conjecture is a conjecture in mathematics that concerns a sequence defined
    as follows: start with any positive integer n. Then each term is obtained from the 
    previous term as follows: if the previous term is even, the next term is one half of 
    the previous term. If the previous term is odd, the next term is 3 times the previous
    term plus 1. The conjecture is that no matter what value of n, the sequence will always reach 1.

    Note: 
        1. Collatz(1) is [1].
        2. returned list sorted in increasing order.

    For example:
    get_odd_collatz(5) returns [1, 5] # The collatz sequence for 5 is [5, 16, 8, 4, 2, 1], so the odd numbers are only 1, and 5."""
    ans, x = [], n
    while x != 1:
        if x % 2 == 1: ans.append(x)
        x = x // 2 if x % 2 == 0 else x * 3 + 1
    ans.append(1)
    return sorted(ans)

def get_odd_collatz(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
