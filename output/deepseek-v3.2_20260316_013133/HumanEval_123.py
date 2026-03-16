
def precondition(args):
    n, = args
    return isinstance(n, int) and n > 0

def postcondition(args, result):
    n, = args
    if not isinstance(result, list):
        return False
    if not all(isinstance(x, int) for x in result):
        return False
    if result != sorted(result):
        return False
    if not all(x % 2 == 1 for x in result):
        return False
    # Check that all odd numbers in Collatz sequence are included
    # by verifying some basic properties
    current = n
    seen_odds = set()
    while current != 1:
        if current % 2 == 1:
            seen_odds.add(current)
        if current % 2 == 0:
            current = current // 2
        else:
            current = 3 * current + 1
    seen_odds.add(1)
    return set(result) == seen_odds

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
