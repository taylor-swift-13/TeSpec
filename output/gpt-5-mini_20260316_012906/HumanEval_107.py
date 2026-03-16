
def precondition(input):
    # input is a tuple of positional args; expect one integer n with 1 <= n <= 1000
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 1 or n > 10**3:
        return False
    return True

def postcondition(input, output):
    # Validate input first
    if not precondition(input):
        return False
    n = input[0]
    # Output should be a sequence of two non-negative integers (preferably a tuple)
    if not hasattr(output, "__len__") or len(output) != 2:
        return False
    try:
        even_count = int(output[0])
        odd_count = int(output[1])
    except Exception:
        return False
    if even_count < 0 or odd_count < 0:
        return False
    # Compute expected counts: number of palindromic integers in 1..n inclusive,
    # separated by parity (even, odd)
    exp_even = 0
    exp_odd = 0
    for k in range(1, n + 1):
        s = str(k)
        if s == s[::-1]:
            if k % 2 == 0:
                exp_even += 1
            else:
                exp_odd += 1
    return even_count == exp_even and odd_count == exp_odd

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
