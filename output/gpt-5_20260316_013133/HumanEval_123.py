
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int) or isinstance(n, bool):
        return False
    return n > 0

def postcondition(input, output):
    # Be permissive if precondition is not met
    if not isinstance(input, tuple) or len(input) != 1:
        return True
    n = input[0]
    if not (isinstance(n, int) and not isinstance(n, bool) and n > 0):
        return True

    # Output must be a list
    if not isinstance(output, list):
        return False

    # Elements must be positive odd integers
    for x in output:
        if not (isinstance(x, int) and not isinstance(x, bool)):
            return False
        if x <= 0 or (x % 2 == 0):
            return False

    # Output must be sorted in strictly increasing order
    for i in range(1, len(output)):
        if output[i - 1] >= output[i]:
            return False

    # Special case: n == 1 -> exactly [1]
    if n == 1:
        return output == [1]

    # If n is odd, it must appear in the result (start of sequence is included)
    if n % 2 == 1 and n not in output:
        return False

    # Attempt to verify exact correctness by computing the odd numbers in the Collatz sequence
    def compute_odds(start, max_steps=200000):
        t = start
        odds = set()
        steps = 0
        while True:
            if t % 2 == 1:
                odds.add(t)
                if t == 1:
                    return True, odds
            if steps >= max_steps:
                return False, odds
            if t % 2 == 0:
                t //= 2
            else:
                t = 3 * t + 1
            steps += 1

    reached, odds = compute_odds(n, 200000)
    if reached:
        expected = sorted(odds)
        return output == expected

    # If we cannot confirm termination within the step bound, accept the basic properties
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
