
def precondition(input):
    n = input[0]
    return isinstance(n, int) and n > 0

def postcondition(input, output):
    if not isinstance(output, list):
        return False
    if output != sorted(output):
        return False
    
    n = input[0]
    sequence = []
    curr = n
    while curr != 1:
        if curr % 2 != 0:
            sequence.append(curr)
        if curr % 2 == 0:
            curr //= 2
        else:
            curr = 3 * curr + 1
    sequence.append(1)
    
    expected_odds = sorted(list(set(x for x in sequence if x % 2 != 0)))
    return output == expected_odds

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
