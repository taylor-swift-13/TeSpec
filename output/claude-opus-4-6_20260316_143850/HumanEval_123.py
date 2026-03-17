
def precondition(input):
    (n,) = input
    # n must be a positive integer
    return isinstance(n, int) and n >= 1

def postcondition(input, output):
    (n,) = input
    # output must be a list
    if not isinstance(output, list):
        return False
    # all elements must be odd integers
    if not all(isinstance(x, int) and x % 2 == 1 for x in output):
        return False
    # output must be sorted in increasing order
    if output != sorted(output):
        return False
    # no duplicates
    if len(output) != len(set(output)):
        return False
    # 1 must always be in the output (collatz sequence always reaches 1)
    if 1 not in output:
        return False
    # if n is odd, it must be in the output (it's the starting element)
    if n % 2 == 1 and n not in output:
        return False
    # if n is even, n should not be in the output
    if n % 2 == 0 and n in output:
        return False
    # verify by computing the actual collatz sequence odd numbers
    seen_odds = set()
    current = n
    while current != 1:
        if current % 2 == 1:
            seen_odds.add(current)
        if current % 2 == 0:
            current = current // 2
        else:
            current = 3 * current + 1
    seen_odds.add(1)
    if set(output) != seen_odds:
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
