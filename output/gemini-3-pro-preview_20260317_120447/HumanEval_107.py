
def precondition(args):
    n = args[0]
    return isinstance(n, int) and 1 <= n <= 1000

def postcondition(args, output):
    n = args[0]
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    even_cnt, odd_cnt = output
    if not (isinstance(even_cnt, int) and isinstance(odd_cnt, int)):
        return False
    
    expected_even = 0
    expected_odd = 0
    for i in range(1, n + 1):
        s = str(i)
        if s == s[::-1]:
            if i % 2 == 0:
                expected_even += 1
            else:
                expected_odd += 1
                
    return (even_cnt, odd_cnt) == (expected_even, expected_odd)

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
