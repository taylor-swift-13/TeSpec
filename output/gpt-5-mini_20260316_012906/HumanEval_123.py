
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    # n must be a positive integer (reject bools)
    if not isinstance(n, int) or isinstance(n, bool):
        return False
    if n < 1:
        return False
    return True

def postcondition(input, output):
    # If precondition not met, do not enforce postcondition here
    if not precondition(input):
        return True
    n = input[0]
    # output must be a list
    if not isinstance(output, list):
        return False
    # elements must be integers (not bool), >=1 and odd
    for item in output:
        if not isinstance(item, int) or isinstance(item, bool):
            return False
        if item < 1:
            return False
        if item % 2 == 0:
            return False
    # must be strictly increasing (since elements should be unique and sorted)
    for i in range(len(output) - 1):
        if not (output[i] < output[i + 1]):
            return False
    # compute collatz sequence until 1 or a cycle is detected
    seen = set()
    seq = []
    x = n
    while True:
        if x in seen:
            break
        seen.add(x)
        seq.append(x)
        if x == 1:
            break
        if x % 2 == 0:
            x = x // 2
        else:
            x = 3 * x + 1
    # expected odd numbers are the unique odd terms encountered
    expected_set = {v for v in seq if v % 2 == 1}
    expected = sorted(expected_set)
    return output == expected

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
