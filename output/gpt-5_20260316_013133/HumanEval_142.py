
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    lst = input[0]
    if not isinstance(output, int):
        return False
    try:
        total = sum(lst)
    except Exception:
        return False
    if output != total:
        return False
    import math
    def is_perfect_square(n):
        if n < 0:
            return False
        r = math.isqrt(n)
        return r * r == n
    def is_perfect_cube(n):
        m = -n if n < 0 else n
        lo, hi = 0, 1
        while hi * hi * hi < m:
            hi <<= 1
        while lo <= hi:
            mid = (lo + hi) // 2
            c = mid * mid * mid
            if c == m:
                return True
            if c < m:
                lo = mid + 1
            else:
                hi = mid - 1
        return False
    for i, v in enumerate(lst):
        if i % 3 == 0:
            if not is_perfect_square(v):
                return False
        elif i % 4 == 0:
            if not is_perfect_cube(v):
                return False
    return True

def _impl(lst):
    """"
    This function will take a list of integers. For all entries in the list, the function shall square the integer entry if its index is a 
    multiple of 3 and will cube the integer entry if its index is a multiple of 4 and not a multiple of 3. The function will not 
    change the entries in the list whose indexes are not a multiple of 3 or 4. The function shall then return the sum of all entries. 

    Examples:
    For lst = [1,2,3] the output should be 6
    For lst = []  the output should be 0
    For lst = [-1,-5,2,-1,-5]  the output should be -126"""
    ans = 0
    for i, num in enumerate(lst):
        if i % 3 == 0:
            ans += num ** 2
        elif i % 4 == 0:
            ans += num ** 3
        else:
            ans += num
    return ans

def sum_squares(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
