
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not (isinstance(n, int) and not isinstance(n, bool)):
        return False
    if n < 1:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    n = input[0]
    if not (isinstance(output, tuple) and len(output) == 2):
        return False
    even_count, odd_count = output
    if not (isinstance(even_count, int) and not isinstance(even_count, bool)):
        return False
    if not (isinstance(odd_count, int) and not isinstance(odd_count, bool)):
        return False
    if even_count < 0 or odd_count < 0:
        return False

    def is_palindrome(x):
        s = str(x)
        return s == s[::-1]

    even = 0
    odd = 0
    for i in range(1, n + 1):
        if is_palindrome(i):
            if i % 2 == 0:
                even += 1
            else:
                odd += 1
    return even_count == even and odd_count == odd

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
