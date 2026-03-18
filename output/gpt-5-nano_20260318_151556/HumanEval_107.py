
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 1 or n > 1000:
        return False
    return True

def postcondition(input, output) -> bool:
    if not precondition(input):
        return False
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    even, odd = output
    if not isinstance(even, int) or not isinstance(odd, int):
        return False
    if even < 0 or odd < 0:
        return False
    n = input[0]
    def is_pal(x):
        s = str(x)
        return s == s[::-1]
    even_expected = sum(1 for i in range(1, n+1) if is_pal(i) and i % 2 == 0)
    odd_expected = sum(1 for i in range(1, n+1) if is_pal(i) and i % 2 == 1)
    return (even, odd) == (even_expected, odd_expected)

def _impl(n):
    """
    Given a positive integer n, return a tuple that has the number of even and odd
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
        2. returned tuple has the number of even and odd integer palindromes respectively.
    """
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
