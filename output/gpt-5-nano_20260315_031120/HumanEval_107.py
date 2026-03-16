
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 1 or n > 1000:
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int) or n < 1 or n > 1000:
        return False
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    evens, odds = output
    if not isinstance(evens, int) or not isinstance(odds, int):
        return False
    if evens < 0 or odds < 0:
        return False

    # compute expected counts
    exp_evens = 0
    exp_odds = 0
    exp_total = 0
    for i in range(1, n + 1):
        s = str(i)
        if s == s[::-1]:
            exp_total += 1
            if i % 2 == 0:
                exp_evens += 1
            else:
                exp_odds += 1

    if exp_evens + exp_odds != exp_total:
        return False
    if evens != exp_evens or odds != exp_odds:
        return False
    return True

def _impl(n):
    """Given a positive integer n, return a tuple that has the number of even and odd
    integer palindromes that fall within the range(1, n), inclusive.

    Example 1:

        Input: 3
        Output: (1, 2)
        Explanation:
        Integer palindrome are 1, 2, 3. one of them is even, and two of them are odd.

    Example 2:

        Input: 12
        Output: (4, 6)
        Explanation:
        Integer palindrome are 1, 2, 3, 4, 5, 6, 7, 8, 9, 11. four of them are even, and 6 of them are odd.

    Note:
        1. 1 <= n <= 10^3
        2. returned tuple has the number of even and odd integer palindromes respectively."""
    odd_cnt, even_cnt = 0, 0
    for i in range(1, n + 1):
        if str(i) == str(i)[::-1]:
            if i % 2 == 1:
                odd_cnt += 1
            else:
                even_cnt += 1
    return even_cnt, odd_cnt

def even_odd_palindrome(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
